package com.ejiayou.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.HashMap;
import java.util.Map;

public class ParameterListUtils {

	public static String[][] getParameterList(String interfaceName) {
		String[][] list = null;
		Class<?> cla = IceInterface.class;
		Method[] methods = cla.getDeclaredMethods();
		Method method = null;
		for (Method m : methods) {
			if (m.getName().equals(interfaceName)) {
				method = m;
			}
		}
		Parameter[] parameters = method.getParameters();

		if ((parameters != null) && (parameters.length > 0)) {
			list = new String[2][parameters.length];
			for (int i = 0 ; i < parameters.length ; i++) {
				
				list[0][i] = parameters[i].getName();
				list[1][i] = parameters[i].getType().getName();
			}
		}
		return list;
	}

	public static String checkParamType(String typeName) throws ClassNotFoundException {
		int code = 0;
		String message = null;
		Class<?> cla = null;
		if (typeName == null) {
			code = 1;
			message = "不可在向下拆分";
			return "{\"code\":" + code + ",\"message\":\"" + message + "\"}";
		}
		try {
			cla = Class.forName(typeName);
		} catch (ClassNotFoundException e) {
			if (typeName.equals("int") || typeName.equals("long") || typeName.equals("boolean")
					|| typeName.equals("float") || typeName.equals("double") || typeName.equals("char")
					|| typeName.equals("byte") || typeName.equals("char")) {
				code = 1;
				message = "不可在向下拆分";
			} else {
				code = 0;
				message = "不是java类";
			}
			return "{\"code\":" + code + ",\"message\":\"" + message + "\"}";
		}

		if (cla.isPrimitive() || cla.getName().equals("java.lang.String")) {
			code = 1;
			message = "不可在向下拆分";
		} else if (cla.isArray()) {
			code = 2;
			message = "数组";
		} else if (Class.forName("java.util.List").isAssignableFrom(cla)) {
			code = 3;
			message = "列表";
		} else {
			code = 4;
			message = "对象";
		}

		return "{\"code\":" + code + ",\"message\":\"" + message + "\"}";
	};

	public static Map<String, String> getFieldMap(String typeName) {
		Map<String, String> map = new HashMap<>();
		Class<?> cla = null;
		try {
			cla = Class.forName(typeName);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		if (cla != null) {
			Field[] fields = cla.getFields();
			for (Field field : fields) {
				if (!field.getName().matches("^_.*$")) {
					map.put(field.getName(), field.getType().getName());
				}
			}
		}
		return map;
	}

	public static Object[] getParameterValues(String[] paramTypeList, String[] params) {
		Object[] paramValues = new Object[paramTypeList.length];
		if(paramTypeList.length == 1){
			String param = "";
			for (int i = 0; i < params.length; i++) {
				param += params[i];
				if(params.length > i+1){
					param += ",";
				}
			}
			paramValues[0] = getParamValue(paramTypeList[0], param);
			return paramValues;
		}
		for (int i = 0; i < paramValues.length; i++) {
			// 调整参数顺序，保证反射调用方法时传入的参数是正确的顺序
			paramValues[i] = getParamValue(paramTypeList[i],params[i]);
		}
		return paramValues;
	}
	
	public static Object getParamValue(String type,String param){
		Object paramValue = null;
		if (type.equals("int")) {
			paramValue = Integer.parseInt(param);
		} else if (type.equals("java.lang.String")) {
			paramValue = param;
			System.out.println(param+ "  " + type );
		} else if (type.equals("long")) {
			paramValue = Long.parseLong(param);
		} else if (type.equals("double")) {
			paramValue = Double.parseDouble(param);
		} else if (type.equals("boolean")) {
			paramValue = Boolean.parseBoolean(param);
		} else if (type.equals("float")) {
			paramValue = Float.parseFloat(param);
		} else {
			Class<?> cla = null;
			System.out.println(param+ "  " + type );
			try {
				cla = Class.forName(type);
				paramValue = JacksonUtils.read(param, cla);
				System.out.println(paramValue.getClass().getName());
			} catch (Exception e) {
				e.printStackTrace();
				paramValue = null;
			}
		}
		return paramValue;
	}

	public static void main(String[] args) {
		String[][] arr =
				ParameterListUtils.getParameterList("getUserInfo20170421");
		System.out.println(arr[1][0]);
	}

}
