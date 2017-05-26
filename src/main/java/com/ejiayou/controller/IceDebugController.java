package com.ejiayou.controller;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.BrokenBarrierException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.ejiayou.model.*;
import com.ejiayou.utils.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ejiayou.service.IAutoTestService;

@Controller
public class IceDebugController {

	private static Logger logger = LoggerFactory.getLogger(IceDebugController.class);
	@Resource
	private IAutoTestService autoTest;
	@Resource
	private IceInterface iceInterface;
	@Resource
	private ExecuteRequest executeRequest;

	// 调试首页
	@RequestMapping(value="/debug")
	public String mainPage(){

        logger.info("this is a {} log","slf4j");
		return "debug";
	} 
	

	//  获取ice接口列表
	@RequestMapping(value="/interfacelist")
	@ResponseBody
	public String getIceInterface(){

		Class<?>  cla = iceInterface.getClass();
		Method[] methods = cla.getDeclaredMethods(); 
		List<String> list = new ArrayList<>();
		for (Method method : methods) {
			if(!method.getName().equals("main")){
				list.add(method.getName());
			}
		}
		String json = JacksonUtils.write(list);
		return json;
	}


	// 添加测试计划
	@RequestMapping(value = "/addTestPlan", method = RequestMethod.POST)
	public void addTestPlan(@RequestParam(name = "name")String name,@RequestParam(name = "description")String description){
		TestModule testModule = new TestModule();
		testModule.setName(name);
		testModule.setDescription(description);
		autoTest.addModule(testModule);
	}

	//　获取测试计划列表
	@RequestMapping(value = "/plans")
	@ResponseBody
	public String getTestPlans(){
		List<TestModule> testModules = autoTest.getTestModules();
		String json = JacksonUtils.write(testModules);
		return json;
	}

	// 修改测试计划
	@RequestMapping(value = "/updateTestPlan")
	@ResponseBody
	public Object updateTestPlan(@RequestParam int moduleId,@RequestParam String name, @RequestParam String desciption){
		TestModule testModule = new TestModule();
		testModule.setId(moduleId);
		testModule.setName(name);
		testModule.setDescription(desciption);
		autoTest.updateTestModule(testModule);
		return testModule;
	}

	//  删除测试计划
	@RequestMapping(value = "deleteTestPlan")
	@ResponseBody
	public String deleteTestPlan(@RequestParam int moduleId){
		autoTest.deleteTestModule(moduleId);
		return "{\"code\":200}";
	}


	// 添加测试用例
	@RequestMapping(value = "addTestCase", method = RequestMethod.POST)
	@ResponseBody
	public String addTestCase(@RequestParam(name = "interfaceName")String interfaceName,
							@RequestParam(name = "moduleId")int moduleId,
							@RequestParam(name = "existParams")int existParams,
							@RequestParam(name = "caseDescription")String caseDescription,
							@RequestParam(name = "paramTypeList",required=false)String[] paramTypeList,
							@RequestParam(name ="params",required=false)String[] params){
		TestCase testCase = new TestCase();
		testCase.setInterfaceName(interfaceName);
		testCase.setModuleId(moduleId);
		testCase.setExistParams(existParams);
		testCase.setCaseDescription(caseDescription);
		TestCaseParams testCaseParams = null;
		if( existParams == 1){
			testCaseParams = new TestCaseParams();
			testCaseParams.setCaseId(testCase.getCaseId());
			if(paramTypeList.length == 1){
				testCaseParams.setParamValue(StringUtils.arrayJoin(params, ","));
			}else {
				testCaseParams.setParamValue(StringUtils.arrayJoin(params, StringUtils.separator));
			}
			testCaseParams.setParamType(StringUtils.arrayJoin(paramTypeList, StringUtils.separator));
			autoTest.addTestCase(testCase, testCaseParams);
			return "{\"code\":200}";
		}
		autoTest.addTestCase(testCase, testCaseParams);
		return "{\"code\":200}";
	}

	// 获取测试用例集
	@RequestMapping(value = "/testCases")
	@ResponseBody
	public List<TestCaseWithParam> getTestCases(@RequestParam int moduleId){
		List<TestCaseWithParam> testCases = autoTest.getTestCasesByModuleId(moduleId);
		logger.info("测试计划 {} 的用例数为 {} ", moduleId, testCases.size());
		return testCases;
	}

	// 执行测试用例
	@RequestMapping(value = "/executeTestCase")
	@ResponseBody
	public Object executeTestCase(@RequestParam(name = "caseId")int caseId) throws InstantiationException {
		TestCaseWithParam testCaseWithParam = autoTest.getTestCaseDetailByCaseId(caseId);
		String[] paramTypes = null;
		String[] paramValues = null;
		if(testCaseWithParam.getExistParams() == 1){
			paramTypes = testCaseWithParam.getTestCaseParams().getParamType().split(StringUtils.separator);
			paramValues = testCaseWithParam.getTestCaseParams().getParamValue().split(StringUtils.separator);
		}
		Object object = IceRequest.iceRequest(testCaseWithParam.getInterfaceName(), paramTypes, paramValues);
		String json = JacksonUtils.write(object);
		int passStatus = ResultCheck.substringCheck(json, testCaseWithParam.getTestCaseParams().getExpectRegex());
		logger.info(json);
		if(passStatus == 1){
			logger.info("module {} case {} pass the test", testCaseWithParam.getModuleId(), testCaseWithParam.getCaseId());
		}else {
			logger.info("module {} case {} fail ", testCaseWithParam.getModuleId(), testCaseWithParam.getCaseId());
		}
		return object;
	}

	// 执行测试用例集
	@RequestMapping(value = "/executeTestPlan")
	@ResponseBody
	public Object executeTestPlan(@RequestParam int moduleId) throws InstantiationException, BrokenBarrierException, InterruptedException {
		TestResult testResult = (TestResult) executeRequest.executeTestPlan(moduleId);
		return testResult;
	}

	// 压力测试接口
	@RequestMapping(value = "/currentTest")
	@ResponseBody
	public void executeCurrentTest(@RequestParam int moduleId, @RequestParam int threadNum, @RequestParam int clientNum)
			throws InstantiationException, BrokenBarrierException, InterruptedException {
		executeRequest.execute(moduleId, threadNum, clientNum, executeRequest);
	}



	// ice接口执行结果
	@RequestMapping(value="/result",method=RequestMethod.POST)
	@ResponseBody
	public Object getResult(@RequestParam(value="interfaceName")String interfaceName,
			HttpServletResponse response,@ModelAttribute("result")String result,Model model,
			@RequestParam(value="paramTypeList",required=false)String[] paramTypeList,
			@RequestParam(value="params",required=false)String[] params) throws InstantiationException {

		Object object = IceRequest.iceRequest(interfaceName, paramTypeList, params);

		String json = JacksonUtils.write(object);
		response.setCharacterEncoding("UTF-8");
		model.addAttribute("result", json);
		return object;
	}

	// 获取ice接口参数集
	@RequestMapping(value="/paramlist")
	@ResponseBody
	public String getParameterList(@RequestParam(name = "interfaceName")String interfaceName,
			HttpServletResponse response){
		String[][] map = 
				ParameterListUtils.getParameterList(interfaceName);
		String json = JacksonUtils.write(map);
		response.setCharacterEncoding("UTF-8"); 
		return json;
	}

	// 获取ice接口参数的域
	@RequestMapping(value="/fieldlist")
	@ResponseBody
	public String getFieldList(@RequestParam(name = "fieldType",required=false)String fieldType,
			HttpServletResponse response){
		Map<String,String> map = 
				ParameterListUtils.getFieldMap(fieldType);
		String json = JacksonUtils.write(map);
		response.setCharacterEncoding("UTF-8"); 
		return json;
	}
	
	@RequestMapping(value="/checkParam")
	@ResponseBody
	public String checkParamType(@RequestParam(name = "fieldType",required=false)String fieldType) throws ClassNotFoundException{
		String json = ParameterListUtils.checkParamType(fieldType);
		return json;
	}
	
}
