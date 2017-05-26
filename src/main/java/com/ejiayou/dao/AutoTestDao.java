package com.ejiayou.dao;

import com.ejiayou.model.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AutoTestDao {

	//　测试计划
	void insertModule(TestModule testModule);
	TestModule findModuleByName(String name);
	List<TestModule> getTestModules();
	void updateTestModule(TestModule testModule);
	void deleteTestModule(int id);
	// 测试用例
	void insertCase(TestCase testCase);
	void updateTestCase(TestCase testCase);
	void deleteTestCase(int caseId);
	List<TestCaseWithParam> getTestCasesByModuleId(int moduleId);
	void insertTestCaseParams(TestCaseParams testCaseParams);
	TestCaseParams getTestCaseParamsByCaseId(int caseId);
	TestCaseWithParam getTestCaseDetailByCaseId(int caseId);
	// 执行结果
	TestResult getTestResultByResultId(int resultId);
	void insertTestResult(TestResult testResult);
	void insertResultDetailBatch(List<ResultDetail> resultDetails);
}
