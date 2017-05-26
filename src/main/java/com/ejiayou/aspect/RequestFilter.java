package com.ejiayou.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2017/5/3.
 */
@Component
@Aspect
public class RequestFilter {

    private static Logger logger = LoggerFactory.getLogger(RequestFilter.class);
    /*	execution(* com.cn21.redisCluster.controller.*(..)) :
	第一个*表示任意的修饰符（public/private/protected）及任意的返回值（void/Object）；
	第二个*表示任意的方法，‘..’表示任意数量的参数；*/
    @Pointcut("execution(* com.ejiayou.service.impl.AutoTestServiceImpl.findModuleByName(..))")
    public void declareExpression(){}

    @Before(value = "declareExpression()")
    public void beforeMethod(JoinPoint joinPoint){
        String methodName = joinPoint.getSignature().getName();
        String message = (String) joinPoint.getArgs()[0];
        logger.info("方法 - [{}] 的 参数是 {}", methodName, message);
    }
}
