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
     * 测试实验室添加方法
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

	/**
	 * 测试实验室搜索方法
	 * @throws Exception
	 */
	@Test
	public void labControllerSearch() throws Exception{
		//发送执行一个HTTP请求
		RequestBuilder request=MockMvcRequestBuilders
				.post("/lab/labsearch.do")
				.param("page", "1")//传数据
				.param("rows", "2")
				.param("order", "asc")
				.param("sort", "lab.lname")
				.param("lname", "6");

		MvcResult result=mockMvc.perform(request)
				.andDo(MockMvcResultHandlers.print())//将请求头和响应头打印
				.andExpect(MockMvcResultMatchers.status().isOk())//期望返回状态码200
				.andReturn();//用来返回结果

		//提取响应中的json字符串
		String jsonStr=result.getResponse().getContentAsString();
		System.out.println("----------------------------"+'\n'+jsonStr+'\n'+"----------------------------");
        System.out.println(jsonStr);
    }
	/**
	 * 测试实验室搜索方法
	 * @throws Exception
	 */
	@Test
	public void labControllerOrderLab() throws Exception{
		//发送执行一个HTTP请求
		RequestBuilder request=MockMvcRequestBuilders
				.post("/lab/order_lab.do")
				.param("lid", "0b1533555c0748b4a8e985f7b9e52897")//传数据
				.param("starttime", "2017-05-10 11:43:39")
				.param("endtime", "2017-05-17 11:43:43")
				.param("sname", "lab.lname")
				.param("stel", "121");

		MvcResult result=mockMvc.perform(request)
				.andDo(MockMvcResultHandlers.print())//将请求头和响应头打印
				.andExpect(MockMvcResultMatchers.status().isOk())//期望返回状态码200
				.andReturn();//用来返回结果

		//提取响应中的json字符串
		String jsonStr=result.getResponse().getContentAsString();
		System.out.println("----------------------------"+'\n'+jsonStr+'\n'+"----------------------------");
		System.out.println(jsonStr);
	}
}
