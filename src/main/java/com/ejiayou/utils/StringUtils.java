package com.ejiayou.utils;

/**
 * Created by Administrator on 2017/5/17.
 */
public class StringUtils {

    public final static String separator = "#&#";

    public static String arrayJoin(String[] arr, String separator){
        if(arr == null){
            return "";
        }
        StringBuilder sb = new StringBuilder();
        int len = arr.length;
        for (int i = 0; i < len; i++) {
            sb.append(arr[i]);
            if(i < len - 1){
                sb.append(separator);
            }
        }
        return sb.toString();
    }
}
