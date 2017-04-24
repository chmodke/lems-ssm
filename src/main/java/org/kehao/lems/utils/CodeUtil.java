package org.kehao.lems.utils;

import java.util.Random;

/**
 * 生成验证码
 * Created by hao on 2017/04/24.
 */
public class CodeUtil {
    public static String createCode(int n){
        Random rand=new Random();
        StringBuilder sb=new StringBuilder();
        for(int i=0;i<n;i++){
            sb.append(rand.nextInt(10)+"");
        }
        return sb.toString();
    }
	public static void main(String[] args) {
		System.out.println(createCode(6));
	}
}
