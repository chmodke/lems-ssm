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
     * @param len
     * @return
     */
    public static String createCode(int len){
        Random rand=new Random();
        StringBuilder sb=new StringBuilder();
        for(int i=0;i<len;i++){
            sb.append(rand.nextInt(10)+"");
        }
        return sb.toString();
    }
    public static String createSalt(int len){
        Random rand=new Random();
        char [] chs={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                '0','1','2','3','4','5','6','7','8','9'};
        StringBuilder sb=new StringBuilder();
        for(int i=0;i<len;i++){
            sb.append(chs[rand.nextInt(61)]+"");
        }
        return sb.toString();
    }
    @Test
	public  void testCreateCode() {
		System.out.println(createCode(9));
	}
	@Test
	public void testCreateId(){
        System.out.println(createId());
    }
    @Test
    public void testCreateSalt(){
        System.out.println(createSalt(6));
    }
}
