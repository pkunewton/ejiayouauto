package com.ejiayou.service;

import com.ejiayou.model.*;

import java.util.List;

public interface IAutoTestService {
	
	void addModule(TestModule testModule);
    TestModule findModuleByName(String name);
    void updateTestModule(TestModule testModule);
    void deleteTestModule(int id);
    List<TestModule> getTestModules();

    void addTestCase(TestCase testCase, TestCaseParams testCaseParams);
    void updateTestCase(TestCase testCase);
    void deleteTestCase(int caseId);
    List<TestCaseWithParam> getTestCasesByModuleId(int moduleId);
    TestCaseParams getTestCaseParamsByCaseId(int caseId);
    TestCaseWithParam getTestCaseDetailByCaseId(int caseId);


    TestResult getTestResultByResultId(int resultId);
    void saveTestResult(TestResult testResult);
}
