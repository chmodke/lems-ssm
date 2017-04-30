package lems.web.controller;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.utils.LEMSResult;
import org.kehao.lems.web.controller.lab.LabController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.fasterxml.jackson.databind.ObjectMapper;

import junit.framework.Assert;

@SuppressWarnings("deprecation")
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class TestLabController {
	@Autowired//注入要测试的Controller
	private LabController controller;
	//发送测试请求
	private MockMvc mockMvc;
	@Before
	public void init(){
		mockMvc=MockMvcBuilders.standaloneSetup(controller).build();
	}
	@After
	public void destroy(){
		
	}

    /**
     * 测试明文登录方法
     * @throws Exception
     */
    @Test
	public void labControllerAdd() throws Exception{
		//发送执行一个HTTP请求
		RequestBuilder request=MockMvcRequestBuilders
		.post("/lab/labadd.do")
		.param("id", "631")//传数据
		.param("lname", "631")
		.param("type", "计算机")
		.param("lsize", "50")
		.param("equcount", "50")
		.param("remark", "计算机")
		.param("uid", "2f0d9fc81dd3460daa7e791d926c96ac");
		
		MvcResult result=mockMvc.perform(request)
		.andDo(MockMvcResultHandlers.print())//将请求头和响应头打印
		.andExpect(MockMvcResultMatchers.status().isOk())//期望返回状态码200
		.andReturn();//用来返回结果
		
		//提取响应中的json字符串
		String jsonStr=result.getResponse().getContentAsString();
		System.out.println("----------------------------"+'\n'+jsonStr+'\n'+"----------------------------");
		//将json字符串转成java对象
		ObjectMapper mapper=new ObjectMapper();
		LEMSResult lemsResult=mapper.readValue(jsonStr, LEMSResult.class);
		//断言
		Assert.assertEquals(0, lemsResult.getStatus());
	}
}
