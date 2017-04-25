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
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
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
    /**
     * 登录校验算法
     * @param name
     * @param passwd
     * @return
     */
    private LEMSResult validationUser(String name, String passwd) {
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


    public LEMSResult userAdd(String auther)throws UnsupportedEncodingException {
        String base64_msg = auther.split(" ")[1];
        byte[] output = Base64.decodeBase64(base64_msg);
        String msg = new String(output, "utf-8");
        User user =new User();
        user.setUname(msg.split(":")[0]);
        user.setPasswd(msg.split(":")[1]);
        user.setTureName(msg.split(":")[2]);
        user.setEmail(msg.split(":")[3]);
        user.setMasterid(msg.split(":")[4]);
        return userAdd(user);

    }
    private LEMSResult userAdd(User user){
        LEMSResult result=new LEMSResult();
        if(userMapper.selectByName(user.getUname())!=null){
            result.setMessage("此用户名已存在");
            result.setStatus(2);
            return result;
        }else if(userMapper.selectByEmail(user.getEmail())!=null){
            result.setMessage("此用邮箱已被注册");
            result.setStatus(3);
            return result;
        }
        user.setUid(CodeUtil.createId());
        String salt=CodeUtil.createSalt(6);
        user.setSalt(salt);
        user.setPasswd(LEMSMD5Util.md5(user.getPasswd(),salt));
        user.setCreatetime(new Timestamp(System.currentTimeMillis()));
        int rec=userMapper.insertSelective(user);
        if (rec==1){
            result.setData(user);
            result.setMessage("添加成功");
            result.setStatus(0);
        }else {
            result.setMessage("添加失败,请稍后重试");
            result.setStatus(1);
        }
        return result;
    }

}
