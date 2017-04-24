package org.kehao.lems.utils.secret.aes_plus.test;

import java.util.Scanner;

import org.kehao.lems.utils.secret.aes_plus.util.AesUtilPlus;

public class TestAesPlus {

	public static void main(String[] args) {
		Scanner scan=new Scanner(System.in);
		System.out.print("input encode content:");
		String content=scan.nextLine();
		System.out.print("input private key:");
		String key=scan.nextLine();
		String encode=AesUtilPlus.encrypt(content, key);
		System.out.println("加密结果"+encode);
		String decode =AesUtilPlus.decrypt(encode, key);
		System.out.println("解密结果"+decode);
		scan.close();
	}

}
