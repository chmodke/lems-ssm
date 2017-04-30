package lems.env;

import org.springframework.aop.interceptor.SimpleTraceInterceptor;

public class TestEnv {

	public static void main(String[] args) {
		org.springframework.aop.interceptor.SimpleTraceInterceptor traceInterceptor=new SimpleTraceInterceptor();
		System.out.println(traceInterceptor);
	}

}
