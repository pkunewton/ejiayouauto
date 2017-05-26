package com.ejiayou.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Created by Administrator on 2017/5/18.
 */
public class IceRequest {

    private static Logger logger = LoggerFactory.getLogger(IceRequest.class);

    public static Object iceRequest(String interfaceName, String[] paramTypes, String[] paramValues) throws InstantiationException {
        Class<?> cla = IceInterface.class;
        Method[] methods = cla.getDeclaredMethods();
        Object object = null;
        Object[] objects = null;
        if(paramTypes != null){
            objects = ParameterListUtils.getParameterValues(paramTypes, paramValues);
        }
        for (Method method : methods) {
            if(method.getName().equals(interfaceName)){
                try {
                    logger.info("正在调用接口 ： {}", interfaceName);
                    object = method.invoke(cla.newInstance(), objects);
                } catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
                    e.printStackTrace();
                    logger.info("请求失败！");
                }
            }
        }
        return object;
    }
}
