package org.kehao.lems.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

/**
 * Created by hao on 2017/04/24.
 */
public class LEMSMD5Util {
    /**
     * 采用MD5摘要算法处理
     *
     * @return
     */
    public static String md5(String msg,String salt) {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
            msg+=salt;
            byte[] input = msg.getBytes();
            byte[] output = md.digest(input);
            // 采用Base64算法将字节数组转换成字符串
            String base64_msg = Base64.encode(output);
            return base64_msg;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * Base64编码
     * @param msg
     * @return
     */
    public static String base64Encode(String msg){
        String base64_msg=null;
        try {
            base64_msg = Base64.encode(msg.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return base64_msg;
    }
    /**
     * Base解码
     * @param msg
     * @return
     */
    public static String base64Decode(String msg){
        String str=null;
        try {
            str = new String(Base64.decode(msg),"utf-8");
        } catch (Base64DecodingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return str;
    }
    /**
     * 验证字符串是否匹配
     * @param passwd 待验证的字符串
     * @param passwd_db	数据库中存储的字符
     * @return	匹配返回true，不匹配返回false
     */
    public static boolean validate(String passwd , String passwd_db,String salt) {
        return passwd_db.equals(md5(passwd,salt));
    }

    public static void main(String[] args) {
        System.out.println(md5("123456","123456"));
        System.out.println(validate("123456","6khXbzC+FmmXFpnAmtBclA==","123456"));
    }
}
