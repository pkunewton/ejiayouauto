package com.ejiayou.utils;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * Created by Administrator on 2017/5/24.
 */
public class ExecuteCommandUtil {

    public static String HOST = "121.41.31.76";
    public static int PORT = 22;
    public static String USER = "root";
    public static String PASSWD = "CJbIG8Gvt8HJHgKF8YMV";

    public static String executeCommand(String command) throws JSchException, IOException{
        JSch jSch = new JSch();
        Session session = jSch.getSession(ExecuteCommandUtil.USER, ExecuteCommandUtil.HOST, ExecuteCommandUtil.PORT);
        session.setConfig("StrictHostKeyChecking", "no");
        session.setPassword(ExecuteCommandUtil.PASSWD);
        session.connect();

        ChannelExec channelExec = (ChannelExec) session.openChannel("exec");
        InputStream in = channelExec.getInputStream();
        channelExec.setCommand(command);
        channelExec.setErrStream(System.err);
        channelExec.connect();
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        StringBuilder sb = new StringBuilder();
        String line = null;
        while ((line = br.readLine()) != null){
            sb.append(line);
            sb.append("\n");
        }
        channelExec.disconnect();
        session.disconnect();
        return sb.toString();
    }

    public static void main(String[] args) {
        try{
            System.out.println(ExecuteCommandUtil.executeCommand("ls -al"));
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
