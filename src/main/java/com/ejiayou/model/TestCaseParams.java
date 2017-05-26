package com.ejiayou.model;

public class TestCaseParams {

    private int paramId;
    private int caseId;
    private String paramType;
    private String paramValue;
    private String expectRegex;

    public String getExpectRegex() {
        return expectRegex;
    }

    public void setExpectRegex(String expectRegex) {
        this.expectRegex = expectRegex;
    }

    public int getParamId() {
        return paramId;
    }

    public void setParamId(int paramsId) {
        this.paramId = paramId;
    }

    public int getCaseId() {
        return caseId;
    }

    public void setCaseId(int caseId) {
        this.caseId = caseId;
    }

    public String getParamType() {
        return paramType;
    }

    public void setParamType(String paramType) {
        this.paramType = paramType;
    }

    public String getParamValue() {
        return paramValue;
    }

    public void setParamValue(String paramValue) {
        this.paramValue = paramValue;
    }

}
