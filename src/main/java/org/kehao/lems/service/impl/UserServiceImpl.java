package org.kehao.lems.service.impl;

import org.apache.commons.codec.binary.Base64;
import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSMD5Util;
import org.kehao.lems.utils.LEMSResult;
import org.kehao.lems.utils.secret.aes.util.AesUtil;
import org.kehao.lems.utils.secret.aes_plus.util.AesUtilPlus;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kehao on 2017/4/20.
 */
@Service("userService")
public class UserServiceImpl implements UserService{
    @Resource
    private UserMapper userMapper;

    public LEMSResult getUserByUid(String uid) {
        LEMSResult result=new LEMSResult();
        result.setData(userMapper.selectByPrimaryKey(uid));
        return result;
    }

    public LEMSResult getUserByName(String name) {
        LEMSResult result=new LEMSResult();
        result.setData(userMapper.selectByName(name));
        return result;
    }

    /**
     * 登录校验算法
     * @param name
     * @param passwd
     * @return
     */
    public LEMSResult validationUser(String name, String passwd) {
        LEMSResult result=new LEMSResult();
        User user=userMapper.selectByName(name);
        if(user==null){
            result.setMessage("用户名不存在");
            result.setStatus(1);
            return result;
        }else if(LEMSMD5Util.validate(passwd,user.getPasswd(),user.getSalt())){
            user.setToken(CodeUtil.createId());
            Map data=new HashMap();
            data.put("uid",user.getUid());
            data.put("token",user.getToken());
            userMapper.updateTokenByUid(data);
            result.setData(user);
            result.setMessage("登录成功");
            result.setStatus(0);
            return result;
        }else {
            result.setMessage("密码不正确");
            result.setStatus(2);
            return result;
        }
    }

    /**
     * 登录校验入口
     * @param auther
     * @return
     * @throws UnsupportedEncodingException
     */
    public LEMSResult checkLogin(String auther) throws UnsupportedEncodingException {
        String base64_msg = auther.split(" ")[1];
        byte[] output = Base64.decodeBase64(base64_msg);
        String msg = new String(output, "utf-8");
        return validationUser(msg.split(":")[0], msg.split(":")[1]);
    }
}
