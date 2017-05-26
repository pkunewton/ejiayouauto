package com.ejiayou.test;

import com.ejiayou.model.*;
import org.apache.log4j.PropertyConfigurator;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ejiayou.service.IAutoTestService;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:config/context.xml")
public class AutoTest {

	private static Logger logger = LoggerFactory.getLogger(AutoTest.class);
	@Autowired
	private IAutoTestService autoTest;
	
	@Test
	public void test() {
		System.out.println(AutoTest.class.getResource("/config/log4j.properties"));
		PropertyConfigurator.configure(AutoTest.class.getResource("/config/log4j.properties"));

		TestCase testCase = new TestCase();
		testCase.setCaseId(19);
		testCase.setCaseDescription("shark space");
		autoTest.updateTestCase(testCase);
		autoTest.deleteTestCase(19);
	}

}
