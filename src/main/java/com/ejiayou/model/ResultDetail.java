package com.ejiayou.model;

/**
 * Created by Administrator on 2017/5/18.
 */
public class ResultDetail {
    private int detailId;
    private int resultId;
    private int moduleId;
    private int caseId;

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public int getCaseId() {
        return caseId;
    }

    public void setCaseId(int caseId) {
        this.caseId = caseId;
    }

    private String actualResult;
    private String expectRegex;
    private int passStatus;

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public String getActualResult() {
        return actualResult;
    }

    public void setActualResult(String actualResult) {
        this.actualResult = actualResult;
    }

    public String getExpectRegex() {
        return expectRegex;
    }

    public void setExpectRegex(String expectRegex) {
        this.expectRegex = expectRegex;
    }

    public int getPassStatus() {
        return passStatus;
    }

    public void setPassStatus(int passStatus) {
        this.passStatus = passStatus;
    }
}
