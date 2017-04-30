package org.kehao.lems.utils.secret.des3.util;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

public class DESUtil {
	public static String  encrypt(String context,String key){
		String encrypt = "";
		try {
			byte[] bkey = EncryptUtils.GetKeyBytes(key);
			encrypt = EncryptUtils.byte2Base64(EncryptUtils.encryptMode(bkey, context.getBytes()));
			encrypt=EncryptUtils.Encrypt3DES(context, key);
		} catch (Exception ex) {
			System.out.println("Exception:" + ex.getMessage());
		}
		return encrypt;
	}
	public static String decrypt(String encrypt,String key){
		String decrypt = "";
		try {
			byte[] bkey = EncryptUtils.GetKeyBytes(key);
			decrypt = new String(EncryptUtils.decryptMode(bkey, Base64.decode(encrypt)));
			decrypt=EncryptUtils.Decrypt3DES(encrypt, key);
		} catch (Exception ex) {
			System.out.println("Exception:" + ex.getMessage());
		}
		return decrypt;
	}
}
