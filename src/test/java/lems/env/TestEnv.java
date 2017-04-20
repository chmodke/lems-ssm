package lems.env;

import org.springframework.aop.interceptor.SimpleTraceInterceptor;

public class TestEnv {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		org.springframework.aop.interceptor.SimpleTraceInterceptor traceInterceptor=new SimpleTraceInterceptor();
		System.out.println(traceInterceptor);
	}

}
