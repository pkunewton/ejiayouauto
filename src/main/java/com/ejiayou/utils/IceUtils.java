package com.ejiayou.utils;

import Ice.InitializationData;
import Ice.Properties;
import YijiayouServer.YijiayouinterfacePrx;
import YijiayouServer.YijiayouinterfacePrxHelper;

public class IceUtils {

	private final static String clientName = "yijiayouClient";
	private final static String masterIp = "121.41.31.76";
	private final static String port = "10002";
	private static Ice.Communicator ic;
	private static YijiayouinterfacePrx prx;
	
	/**
	 * 初始化ice
	 */
 	
	static{
		System.setProperty("java.net.preferIPv6Addresses", "false");// 关闭IPV6
		Ice.InitializationData data = new InitializationData();
		Properties properties = Ice.Util.createProperties();
		properties.setProperty("Ice.Override.ConnectTimeout", "3000");//设置连接超时时间
		properties.setProperty("Ice.Override.Timeout", "5000");//设置响应超时时间
		properties.setProperty("Ice.ThreadPool.Client.Size", "15");
		properties.setProperty("Ice.ThreadPool.Client.SizeMax", "100");
		properties.setProperty("Ice.ThreadPool.Client.SizeWarn", "80");
		data.properties=properties;
		ic = Ice.Util.initialize(data);
	}
	
	public static YijiayouinterfacePrx connect(){
		Ice.ObjectPrx base = null ;
		try {
			base = ic.stringToProxy(clientName + ": tcp -h " + masterIp + " -p " + port);
			prx = YijiayouinterfacePrxHelper.checkedCast(base);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return prx;
	}
	
	public static void closeIce() {
		if (ic != null) {
			try {
				ic.destroy();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
