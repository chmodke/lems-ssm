package org.kehao.lems.utils.secret.aes_plus.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

public class AesUtilPlus {
	/**
	 * 加密
	 * 
	 * @param content
	 *            需要加密的内容
	 * @param private_key
	 *            加密密码
	 * @return
	 */
	public static String encrypt(String content, String private_key) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, new SecureRandom(private_key.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(byteContent);
			String encode = Base64.encode(result);
			return encode; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 解密
	 * 
	 * @param encoded
	 *            待解密内容
	 * @param private_key
	 *            解密密钥
	 * @return
	 */
	public static String  decrypt(String encoded, String private_key) {
		try {
			try {
				byte[] content= Base64.decode(encoded);
				KeyGenerator kgen = KeyGenerator.getInstance("AES");
				kgen.init(128, new SecureRandom(private_key.getBytes()));
				SecretKey secretKey = kgen.generateKey();
				byte[] enCodeFormat = secretKey.getEncoded();
				SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
				Cipher cipher = Cipher.getInstance("AES");// 创建密码器
				cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
				byte[] result = cipher.doFinal(content);
				return new String (result,"utf-8"); // 解密
			} catch (Base64DecodingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return null;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}
}
