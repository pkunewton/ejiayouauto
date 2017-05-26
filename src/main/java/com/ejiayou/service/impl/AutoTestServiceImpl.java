package com.ejiayou.service.impl;

import javax.annotation.Resource;

import com.ejiayou.model.*;
import org.springframework.stereotype.Service;

import com.ejiayou.dao.AutoTestDao;
import com.ejiayou.service.IAutoTestService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AutoTestServiceImpl implements IAutoTestService {

	@Resource
	private AutoTestDao dao;

	//  测试计划相关
	@Override
	@Transactional
	public void addModule(TestModule testModule) {
		dao.insertModule(testModule);
	}
	@Override
	public TestModule findModuleByName(String name){
		TestModule module = dao.findModuleByName(name);
		return module;
	}

	@Override
	public List<TestModule> getTestModules() {
		List<TestModule> testModules = dao.getTestModules();
		return testModules;
	}

	@Override
	@Transactional
	public void updateTestModule(TestModule testModule) {
		dao.updateTestModule(testModule);
	}

	@Override
	public void deleteTestModule(int id) {
		dao.deleteTestModule(id);
	}

	//  测试用例相关
	@Override
	@Transactional
	public void addTestCase(TestCase testCase, TestCaseParams testCaseParams) {
		dao.insertCase(testCase);
		int caseId = testCase.getCaseId();
		if(testCase.getExistParams() == 1){
			testCaseParams.setCaseId(caseId);
			dao.insertTestCaseParams(testCaseParams);
		}
	}

	@Override
	@Transactional
	public void updateTestCase(TestCase testCase) {
		dao.updateTestCase(testCase);
	}

	@Override
	public void deleteTestCase(int caseId) {
		dao.deleteTestCase(caseId);
	}

	@Override
	public List<TestCaseWithParam> getTestCasesByModuleId(int moduleId) {
		List<TestCaseWithParam> testCases = dao.getTestCasesByModuleId(moduleId);
		return testCases;
	}

	@Override
	public TestCaseParams getTestCaseParamsByCaseId(int caseId) {
		TestCaseParams testCaseParams = dao.getTestCaseParamsByCaseId(caseId);
		return testCaseParams;
	}

	@Override
	public TestCaseWithParam getTestCaseDetailByCaseId(int caseId) {
		TestCaseWithParam testCaseWithParam = dao.getTestCaseDetailByCaseId(caseId);
		return testCaseWithParam;
	}

	// 测试结果相关
	@Override
	public TestResult getTestResultByResultId(int resultId) {
		TestResult testResult = dao.getTestResultByResultId(resultId);
		return testResult;
	}

	@Override
	@Transactional
	public void saveTestResult(TestResult testResult) {
		dao.insertTestResult(testResult);
		int resultId = testResult.getResultId();
		for (ResultDetail resultDetail: testResult.getResultDetails()) {
			resultDetail.setResultId(resultId);
		}
		dao.insertResultDetailBatch(testResult.getResultDetails());
	}
}
