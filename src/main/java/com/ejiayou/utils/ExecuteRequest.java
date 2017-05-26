package com.ejiayou.utils;

import com.ejiayou.model.ResultDetail;
import com.ejiayou.model.TestCaseWithParam;
import com.ejiayou.model.TestResult;
import com.ejiayou.service.IAutoTestService;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

/**
 * Created by Administrator on 2017/5/24.
 */
@Service
public class ExecuteRequest {

    private static Logger logger = LoggerFactory.getLogger(ExecuteRequest.class);
    @Resource
    private IAutoTestService autoTest;

    public Object executeTestPlan(int moduleId) throws InstantiationException{
        List<TestCaseWithParam> testCaseWithParams = autoTest.getTestCasesByModuleId(moduleId);

        if(testCaseWithParams.size() == 0 || testCaseWithParams == null){
            return null;
        }
        TestResult testResult = new TestResult();
        testResult.setModuleId(moduleId);
        int passCount = 0;
        int failCount = 0;
        List<ResultDetail> resultDetails = new ArrayList<>();
        //执行测试用例集
        for (TestCaseWithParam testCaseWithParam: testCaseWithParams) {
            String[] paramTypes = null;
            String[] paramValues = null;
            ResultDetail resultDetail = new ResultDetail();
            if(testCaseWithParam.getExistParams() == 1){
                paramTypes = testCaseWithParam.getTestCaseParams().getParamType().split(StringUtils.separator);
                paramValues = testCaseWithParam.getTestCaseParams().getParamValue().split(StringUtils.separator);
            }
            Object object = IceRequest.iceRequest(testCaseWithParam.getInterfaceName(), paramTypes, paramValues);
            String json = JacksonUtils.write(object);
            // 验证测试用例结果是否符合预期
            int passStatus = ResultCheck.substringCheck(json, testCaseWithParam.getTestCaseParams().getExpectRegex());
            if(passStatus == 1){
                passCount += 1;
                resultDetail.setPassStatus(1);
            }else {
                failCount += 1;
                resultDetail.setPassStatus(0);
            }
            resultDetail.setModuleId(moduleId);
            resultDetail.setCaseId(testCaseWithParam.getCaseId());
            resultDetail.setActualResult(json);
            resultDetail.setExpectRegex(testCaseWithParam.getTestCaseParams().getExpectRegex());

            resultDetails.add(resultDetail);
            logger.info(json);
            if(passStatus == 1){
                logger.info("module {} case {} pass the test", testCaseWithParam.getModuleId(), testCaseWithParam.getCaseId());
            }else {
                logger.info("module {} case {} fail ", testCaseWithParam.getModuleId(), testCaseWithParam.getCaseId());
            }
        }
        testResult.setFailCount(failCount);
        testResult.setPassCount(passCount);
        testResult.setTotalCount(failCount + passCount);
        testResult.setResultDetail(resultDetails);
//        autoTest.saveTestResult(testResult);
        return testResult;
    }

    public void execute(int moduleId, int threadNum, int clientNum, ExecuteRequest executeRequest)
            throws InstantiationException, InterruptedException, BrokenBarrierException{
        ExecutorService exec = Executors.newCachedThreadPool();
        final Semaphore semaphore = new Semaphore(threadNum);
        CyclicBarrier cyclicBarrier = new CyclicBarrier(clientNum);
        for (int i = 0; i < clientNum; i++) {
            final int num = i;

            class Task implements Runnable{

                private CyclicBarrier cyclicBarrier;

                public Task(CyclicBarrier cyclicBarrier){
                    this.cyclicBarrier = cyclicBarrier;
                }

                @Override
                public void run(){
                    try{
                        cyclicBarrier.await();
                        int times = 1;
                        logger.info("Thread {} start", num);
                        while (times < 5){
                            semaphore.acquire();
                            logger.info("Thread {} ,times {}", num, times);
                            executeRequest.executeTestPlan(moduleId);
                            times++;
                            semaphore.release();
                        }
                    }catch (Exception e){
                        logger.info(e.getMessage());
                    }
                }
            }
            exec.execute(new Task(cyclicBarrier));
        }
        exec.shutdown();
    }

}
