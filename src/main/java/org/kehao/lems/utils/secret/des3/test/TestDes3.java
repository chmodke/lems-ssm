package org.kehao.lems.utils.secret.des3.test;

import java.util.Scanner;

import org.kehao.lems.utils.secret.des3.util.DESUtil;

public class TestDes3 {

	public static void main(String[] args) {
		Scanner scan=new Scanner(System.in);
		System.out.print("input encode content:");
		String content=scan.nextLine();
		System.out.print("input private key:");
		String key=scan.nextLine();
		String encode=DESUtil.encrypt(content, key);
		System.out.println("加密结果"+encode);
		String decode =DESUtil.decrypt(encode, key);
		System.out.println("解密结果"+decode);
		scan.close();
	}

}
