package com.ejiayou.utils;

/**
 * Created by Administrator on 2017/5/18.
 */
public class ResultCheck {

    public static int substringCheck(String result, String regex){
        if(regex == null || regex.trim().equals("") ){
            return 1;
        }
        if(regex.indexOf(regex) == -1){
            return 0;
        }
        return 1;
    }
}
