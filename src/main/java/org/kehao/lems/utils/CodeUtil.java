package org.kehao.lems.utils;

import org.junit.Test;

import java.util.Random;
import java.util.UUID;

/**
 * 生成序列号
 * Created by hao on 2017/04/24.
 */
public class CodeUtil {

    /**
     * 创建32位随机id
     * @return
     */
    public static String createId(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * 生成指定长度随机数字编码
     * @param n
     * @return
     */
    public static String createCode(int n){
        Random rand=new Random();
        StringBuilder sb=new StringBuilder();
        for(int i=0;i<n;i++){
            sb.append(rand.nextInt(10)+"");
        }
        return sb.toString();
    }
    @Test
	public  void testCreateCode() {
		System.out.println(createCode(6));
	}
	@Test
	public void testCreateId(){
        System.out.println(createId());
    }
}
