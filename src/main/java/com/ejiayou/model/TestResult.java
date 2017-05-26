package com.ejiayou.model;

import java.util.List;

/**
 * Created by Administrator on 2017/5/18.
 */
public class TestResult {

    private int resultId;
    private int moduleId;
    private int passCount;
    private int failCount;
    private int totalCount;
    private List<ResultDetail> resultDetails;

    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }


    public int getPassCount() {
        return passCount;
    }

    public void setPassCount(int passCount) {
        this.passCount = passCount;
    }

    public int getFailCount() {
        return failCount;
    }

    public void setFailCount(int failCount) {
        this.failCount = failCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public List<ResultDetail> getResultDetails() {
        return resultDetails;
    }

    public void setResultDetail(List<ResultDetail> resultDetails) {
        this.resultDetails = resultDetails;
    }
}
