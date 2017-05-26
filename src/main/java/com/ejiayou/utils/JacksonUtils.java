package com.ejiayou.utils;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JacksonUtils {

	private static ObjectMapper mapper = new ObjectMapper();
	
	public static <T> Object read(String src,Class<T> valueType){
		Object object = null;
		try {
			object = mapper.readValue(src, valueType);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return object;
	}
	
	public static String write(Object value){
		String str = null;
		try {
			str = mapper.writeValueAsString(value);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
	}
}