package com.ejiayou.model;

public class TestCase {

	private int caseId;
	private int moduleId;
	private String interfaceName;
	private String caseDescription;
	private int existParams;

	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}
	public int getModuleId() {
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public String getInterfaceName() {
		return interfaceName;
	}
	public void setInterfaceName(String interfaceName) {
		this.interfaceName = interfaceName;
	}
	public String getCaseDescription() {
		return caseDescription;
	}
	public void setCaseDescription(String caseDescription) {
		this.caseDescription = caseDescription;
	}
	public int getExistParams() {
		return existParams;
	}
	public void setExistParams(int existParams) {
		this.existParams = existParams;
	}
	
}
