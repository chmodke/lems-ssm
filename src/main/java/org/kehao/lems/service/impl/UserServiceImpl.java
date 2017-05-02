package org.kehao.lems.service.impl;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.dao.UserRoleMapper;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.UserRole;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSMD5Util;
import org.kehao.lems.utils.LEMSResult;
import org.kehao.lems.utils.SendEmail;
import org.springframework.stereotype.Service;

/**
 * Created by kehao on 2017/4/20.
 */
@Service("userService")
public class UserServiceImpl implements UserService{
    @Resource
    private UserMapper userMapper;

    @Resource
    private UserRoleMapper userRoleMapper;

    private Map<String,String> valiCode=new HashMap<String, String>(8);//存储用户重置密码时产生的用户名和验证码键值对，防止用户恶意利用

    public LEMSResult getUserByUid(String uid) {
        LEMSResult result=new LEMSResult();
        User user=userMapper.selectByPrimaryKey(uid);
        if(user!=null){
            result.setData(user);
            result.setStatus(0);
            result.setMessage("获取用户信息成功");
        }else {
            result.setStatus(1);
            result.setMessage("获取用户信息失败");
        }
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
        }else if(user.getStatus()!=0){
            result.setMessage("用户状态不可用");
            result.setStatus(3);
            return result;
        }else if(LEMSMD5Util.validate(passwd,user.getPasswd(),user.getSalt())){
            user.setToken(CodeUtil.createId());
            Map<String ,Object> data=new HashMap<String ,Object>();
            data.put("uid",user.getUid());
            data.put("token",user.getToken());
            userMapper.updateTokenByUid(data);
            user=userMapper.selectRloeByUid(user.getUid());
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
        user.setUserRole(new UserRole());
        user.getUserRole().setRid(Integer.valueOf(msg.split(":")[5]));
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
        user.getUserRole().setUid(user.getUid());
        //添加用户
        int rec=userMapper.insertSelective(user);
        //添加权限
        int rec2=userRoleMapper.insert(user.getUserRole());
        if (rec==1&&rec2==1){
            result.setData(user);
            result.setMessage("添加成功");
            result.setStatus(0);
        }else {
            result.setMessage("添加失败,请稍后重试");
            result.setStatus(1);
            //撤销数据库操作
            userRoleMapper.deleteByUid(user.getUserRole().getUid());
            userMapper.deleteByPrimaryKey(user.getUserRole().getUid());
        }
        return result;
    }

    public LEMSResult useraddValidation(String uname) {
        LEMSResult result=new LEMSResult();
        User user=userMapper.selectByName(uname);
        if(user!=null){
            result.setMessage("用户名已存在");
            result.setStatus(1);
        }else{
            result.setMessage("用户名不存在");
            result.setStatus(0);
        }
        return result;
    }

    public LEMSResult modfifyUserInfo(User user) {
        LEMSResult result=new LEMSResult();
        if(userMapper.updateByPrimaryKeySelective(user)==1){
            result.setStatus(0);
            result.setMessage("修改用户信息成功");
        }else {
            result.setStatus(1);
            result.setMessage("修改用户信息失败");
        }
        return result;
    }

    /**
     * 发送验证邮件
     * @param uname
     * @return
     */
    public LEMSResult sendValiCode(String uname) {
        final User user=(User)this.getUserByName(uname).getData();
        LEMSResult result=new LEMSResult();
        valiCode.put(uname,CodeUtil.createCode(8));
        //发送邮件
        // /邮件的内容
        final StringBuffer sb = new StringBuffer("您的邮箱:");
        sb.append(user.getEmail()+"</br>");
        sb.append("您的验证码:");
        sb.append(valiCode.get(uname));
        // 发送邮件
        Thread t=new Thread (){//使用后台线程缩短ajax响应时间
            public void run(){
                SendEmail.send(user.getEmail(), sb.toString());
            }
        };
        //采用双线程，缩短ajax响应时间
        t.start();
        result.setStatus(0);
        result.setMessage("获取成功");
        return result;
    }
    public LEMSResult valiCodeValidation(String uname,String reqCode){
        LEMSResult result=new LEMSResult();
        if(reqCode!=null&&!reqCode.equals("")&&reqCode.equals(valiCode.get(uname))){
            result.setStatus(0);
            result.setMessage("验证码正确");
            valiCode.remove(uname);
        }else {
            result.setStatus(1);
            result.setMessage("验证码错误");
        }
        return result;
    }

    public LEMSResult modifyUserPasswd(String auther) throws UnsupportedEncodingException {
        String base64_msg = auther.split(" ")[1];
        byte[] output = Base64.decodeBase64(base64_msg);
        String msg = new String(output, "utf-8");
        User user =new User();
        user.setUname(msg.split(":")[0]);
        user.setPasswd(msg.split(":")[1]);
        return modifyUserPasswd(user);
    }

    /**
     * 修改用户密码工具方法
     * @param user
     * @return
     */
    private LEMSResult modifyUserPasswd(User user){
        LEMSResult result=new LEMSResult();
        String salt=CodeUtil.createSalt(6);
        user.setSalt(salt);
        user.setPasswd(LEMSMD5Util.md5(user.getPasswd(),salt));
        if(userMapper.updateByUserNameSelective(user)==1){
            result.setStatus(0);
            result.setMessage("重置密码成功");
        }else {
            result.setStatus(1);
            result.setMessage("重置密码失败");
        }
        return result;
    }

    public LEMSResult getUser(Integer page, Integer pageSize, User user, String order, String sort,String rname) {
        LEMSResult result=new LEMSResult();
        Map<String,Object> map=new HashMap<String, Object>(8);
        if(null!=user.getUname()){
            map.put("uname",user.getUname());
        }
        if(null!=user.getTureName()){
            map.put("tureName",user.getTureName());
        }
//        if(null!=user.getUserRole()){
//            map.put("rname",user.getUserRole().getRole().getRname());
//        }
        if(null==page){
            page=1;
        }
        map.put("startRec",pageSize*(page-1));//5*(1-1)=0,,5*(2-1)=5
        if(null==pageSize){
            pageSize=5;
        }
        map.put("recCount",pageSize);

        map.put("order",order);
        if(sort.equals("tureName")){
            sort="ture_name";
        }
        if(sort.equals("userRole")){
            sort="rname";
        }
        map.put("sort",sort);

        if(null!=rname){
            map.put("rname",rname);
        }

        result.setData(userMapper.selectUserCondition(map));
        result.setStatus(0);
        return result;
    }

    public Long getUserCount(User user,String rname) {
        Map<String,Object> map=new HashMap<String, Object>(8);
        if(null!=user.getUname()){
            map.put("uname",user.getUname());
        }
        if(null!=user.getTureName()){
            map.put("tureName",user.getTureName());
        }
//        if(null!=user.getUserRole()){
//            map.put("rname",user.getUserRole().getRole().getRname());
//        }
        if(null!=rname){
            map.put("rname",rname);
        }
        return userMapper.selectUserConditionCount(map);
    }

    public LEMSResult userDel (List<String> delList){
        LEMSResult result=new LEMSResult();
        Map map=new HashMap();
        map.put("status",1);
        map.put("list",delList);
        int rec=userMapper.updateUserStatusByUid(map);
        if(rec==delList.size()){
            result.setMessage("批量删除成功");
            result.setStatus(0);
            result.setData(rec);
        }else {
            result.setMessage("批量删除失败");
            result.setStatus(1);
        }
        return result;
    }
}
