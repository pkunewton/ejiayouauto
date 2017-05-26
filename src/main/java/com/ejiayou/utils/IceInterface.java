package com.ejiayou.utils;

import YijiayouServer.AppPaymentInputVo;
import YijiayouServer.AppPaymentState20170227;
import YijiayouServer.BasicInfov2;
import YijiayouServer.CheckSmsCode0405;
import YijiayouServer.CreateOrderInput0622;
import YijiayouServer.CreateOrderInput20170421;
import YijiayouServer.CreateOrderOutput0622;
import YijiayouServer.EvaluateInput;
import YijiayouServer.GetAccountInfoOutput20170215;
import YijiayouServer.GetEvaluateInfoBefore0729Output;
import YijiayouServer.GetOilGun20170214OutPut;
import YijiayouServer.GetOilGun20170227OutPut;
import YijiayouServer.GetOilGun20170316OutPut;
import YijiayouServer.GetOilGun20170421OutPut;
import YijiayouServer.GetOilGun20170503OutPut;
import YijiayouServer.GetUserInfoOutput20170421;
import YijiayouServer.GetUserOrder0201Output;
import YijiayouServer.GetUserOrderInfoOutput0217;
import YijiayouServer.HomePageStationInfoListOutput0314;
import YijiayouServer.HomeQuickStationV2ListOutput;
import YijiayouServer.InviteFriendAndQqLimitOut;
import YijiayouServer.QueryActivityMessage0525Output;
import YijiayouServer.QueryStationSupportProjectOutPut;
import YijiayouServer.QueryUserPointsOutPut;
import YijiayouServer.ReasonOutput;
import YijiayouServer.RegisterUserWithCarNumberOutput;
import YijiayouServer.ScanCodeVo;
import YijiayouServer.SendVerificationCodeOut;
import YijiayouServer.UserIdTypeOutput;
import YijiayouServer.UserInfo0918;
import YijiayouServer.UserInfo20170421;
import YijiayouServer.YijiayouinterfacePrx;
import org.springframework.stereotype.Service;

@Service
public class IceInterface {
	
	private static YijiayouinterfacePrx prx;
	
	/** 添加/追加 评价执之前查�?  evaluateId=评价订单id  type=1.添加/2.追加/3.用户回复4.已评价回�?. */
	public GetEvaluateInfoBefore0729Output getEvaluateInfoBefore0729(String orderId,int type,
			BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		GetEvaluateInfoBefore0729Output output =
				prx.getEvaluateInfoBefore0729(orderId,type,basicInfoIn);
		return output;
	}	

	
	/** 创建订单 重构用户感知优惠 5.0版本 **/
	public CreateOrderOutput0622 createOrderUser0622(CreateOrderInput0622 createOrderInput0622Input
			,String userPhoneSerial,BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		CreateOrderOutput0622 output = 
				prx.createOrderUser0622(createOrderInput0622Input,userPhoneSerial,basicInfoIn);
		return output;
	}
	
	/** 地图油站列表**/
	public HomePageStationInfoListOutput0314 homePageStationInfoListForMap(String longitude
			,String latitude,int carType,BasicInfov2 basicInfoIn,boolean isCooperate){
		prx = IceUtils.connect();
		HomePageStationInfoListOutput0314 output = prx
				.homePageStationInfoListForMap(longitude,latitude,carType,basicInfoIn ,isCooperate);

		return output;
	}

	
	/** 提交/追加评价内容  */
	public ReasonOutput insertEvaluate(EvaluateInput evaluateInputI){
		prx = IceUtils.connect();
		ReasonOutput output = prx.insertEvaluate(evaluateInputI);

		return output;
	}
	
	//获取用户当前身份类型（以支付享受为准�?
	public UserIdTypeOutput getUserIdType(int userId){
		prx = IceUtils.connect();
		UserIdTypeOutput output = prx.getUserIdType(userId);

		return output;
	} 
	
	/** 历史订单,扩展客服电话*/
	public GetUserOrder0201Output getUserOrder0201(int userId,long orderId){
		prx = IceUtils.connect();
		GetUserOrder0201Output output = prx.getUserOrder0201(userId,orderId);

		return output;
	}

	//短信验证码发送接�?,4.6.0版本登录页面--手机获取验证码接口更�?
	public SendVerificationCodeOut sendVerificationCode151117(String phoneNum){
		prx = IceUtils.connect();
		SendVerificationCodeOut output = prx.sendVerificationCode151117(phoneNum);

		return output;
	}


	
	//修改用户个人信息(basicInfoIn.userId必须)
	public ReasonOutput updateUserInfo0918(UserInfo0918 userInfo , BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		ReasonOutput output = prx.updateUserInfo0918(userInfo,basicInfoIn);

		return output;
	}
	
	/** 校验验证码接口，加入灰名单控�?**/
	public CheckSmsCode0405 checkSmsCodeAndGrey0405(String phoneNum,String smsCode,BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		CheckSmsCode0405 output = prx.checkSmsCodeAndGrey0405(phoneNum,smsCode,basicInfoIn);

		return output;
	}
	
    //用户登录和注�? 灰名单的用户�?要提交车牌号
	public RegisterUserWithCarNumberOutput loginOrRegisterUserSendWithCarNumber(String userPhoneSerial
			,int osType,int userId,String jpushId,String userPhoneIn,String verifyNumber,int idType,String carNumber){
		prx = IceUtils.connect();
		RegisterUserWithCarNumberOutput output = prx.loginOrRegisterUserSendWithCarNumber(userPhoneSerial, osType
				, userId, jpushId, userPhoneIn, verifyNumber, idType, carNumber);

		return output;
	}


	

	
	/** 消息中心增加版本控制*/
	public QueryActivityMessage0525Output queryActivityMessageByClientType(int page,int platform
			,String userId,BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		QueryActivityMessage0525Output output = prx.queryActivityMessageByClientType(page,platform,userId,basicInfoIn);

		return output;
	}

	
	//创建订单�?款申�?
	public ReasonOutput CreateRefundApply(String orderId,String reason){
		prx = IceUtils.connect();
		ReasonOutput output = prx.CreateRefundApply(orderId,reason);	

		return output;
	}

	
	/** 异常扫码扩展返回优惠�? 抵扣积分 余额 */
	public GetUserOrderInfoOutput0217 getUserRefundableOrder0217(int userId){
		prx = IceUtils.connect();
		GetUserOrderInfoOutput0217 output = prx.getUserRefundableOrder0217(userId);	

		return output;
	}
	
	//修改手机获取验证�?
	public SendVerificationCodeOut	sendVerificationCodeAfterChecked(String phoneNum){
		prx = IceUtils.connect();
		SendVerificationCodeOut output = prx.sendVerificationCodeAfterChecked(phoneNum);	

		return output;
	}
	
	
	/** 油站支持的项�?(抽奖,兑换积分,充�??) */
	public QueryStationSupportProjectOutPut queryStationSupportProject(String stationId){
		prx = IceUtils.connect();
		QueryStationSupportProjectOutPut output = prx.queryStationSupportProject(stationId);	

		return output;
	}


	/** 查询用户剩余积分 */
	public QueryUserPointsOutPut queryUserPoints(String stationId,String userId){
		prx = IceUtils.connect();
		QueryUserPointsOutPut output = prx.queryUserPoints(stationId,userId);	

		return output;
	}
	

	
	/** �?请好友分享QQ**/
	public InviteFriendAndQqLimitOut inviteFriendAddLimit0918(BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		InviteFriendAndQqLimitOut output = prx.inviteFriendAddLimit0918(basicInfoIn);	

		return output;
	}
		
	
	/** v5.0.5版本使用�?键加油，轮换图片改�??**/
	public HomeQuickStationV2ListOutput getQuickStationV3(BasicInfov2 basicInfoIn,String longitude,String latitude){
		prx = IceUtils.connect();
		HomeQuickStationV2ListOutput output = prx.getQuickStationV3(basicInfoIn, longitude, latitude);

		return output;
	}
	
	/** 2017-02-15 获取账号信息,增加是否展示修改密码 **/
	public GetAccountInfoOutput20170215 getAccountInfo20170215(BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		GetAccountInfoOutput20170215 output = prx.getAccountInfo20170215(basicInfoIn);
		return output;
	}
	
	// 扫码接口  增加车队卡数�?5.3.5�?
    public GetOilGun20170214OutPut getOilgunbackListLimitCash20170214(String QRCode,String userId,String longitude,
    		String latitude,BasicInfov2 basicInfoIn,int fromSource,String userPhoneSerial){
    	prx = IceUtils.connect();
    	GetOilGun20170214OutPut output = prx.getOilgunbackListLimitCash20170214(QRCode,userId,longitude,
    			latitude,basicInfoIn,fromSource,userPhoneSerial);
		return output;
    };
    
    // 扫码接口  增加E卡数�?5.3.8�?
    public GetOilGun20170227OutPut getOilgunbackListLimitCash20170227(String QRCode,String userId,
    		String longitude,String latitude,BasicInfov2 basicInfoIn,int fromSource,String userPhoneSerial){
    	prx = IceUtils.connect();
    	GetOilGun20170227OutPut output = prx.getOilgunbackListLimitCash20170227(QRCode,userId,longitude,
    			latitude,basicInfoIn,fromSource,userPhoneSerial);
		return output;
    }
    
    // 重载白名�
    public String reloadIpWhiteList(){
    	prx = IceUtils.connect();
    	String output = prx.reloadIpWhiteList();
		return output;
    }
    
    // 2017-02-27 获取app支付的所有类�?,状�??,待支付金�?
    public AppPaymentState20170227 getAppPaymentState20170227(AppPaymentInputVo vo, BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	AppPaymentState20170227 output = prx.getAppPaymentState20170227(vo,basicInfoIn);
		return output;
    }
    
	/** 2017-03-16 新版的扫码接 **/
	public GetOilGun20170316OutPut getOilgunbackListLimitCash20170316(ScanCodeVo vo, BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	GetOilGun20170316OutPut output = prx.getOilgunbackListLimitCash20170316(vo,basicInfoIn);
		return output;
	}
	
	/** 创建订单 增加车牌  5.4.1版本 **/
	public CreateOrderOutput0622 createOrderUser20170421(CreateOrderInput20170421 createOrderInput20170421Input,
			String userPhoneSerial,BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	CreateOrderOutput0622 output = prx.createOrderUser20170421(createOrderInput20170421Input,userPhoneSerial,basicInfoIn);
		return output;
	};

	/** 2017-04-21 新的上传个人信息接口 **/
	public ReasonOutput updateUserInfo20170421(UserInfo20170421 userInfo , BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	ReasonOutput output = prx.updateUserInfo20170421(userInfo,basicInfoIn);
		return output;
	};
	/** 2017-04-21 新加头像 **/
	public GetUserInfoOutput20170421 getUserInfo20170421(BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	GetUserInfoOutput20170421 output = prx.getUserInfo20170421(basicInfoIn);
		return output;
	};

	/** 2017-04-21 5.4.1 新版的扫码接
     * type == 1 表示判断是否需要强框
     * type == 2 选择个人支付方式
     * type == 3 选择车队卡支付方式
	**/
	public GetOilGun20170421OutPut getOilgunbackListLimitCash20170421(ScanCodeVo vo, String type,
			BasicInfov2 basicInfoIn){
    	prx = IceUtils.connect();
    	GetOilGun20170421OutPut output = prx.getOilgunbackListLimitCash20170421(vo,type,basicInfoIn);
		return output;
	}

	public GetOilGun20170503OutPut getOilgunbackListLimitCash20170503(ScanCodeVo vo, String type, BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		GetOilGun20170503OutPut output = prx.getOilgunbackListLimitCash20170503(vo, type, basicInfoIn);
        return output;
	}

	public AppPaymentState20170227 getAppPaymentState20170421(AppPaymentInputVo vo,String type, BasicInfov2 basicInfoIn){
		prx = IceUtils.connect();
		AppPaymentState20170227 output = prx.getAppPaymentState20170421(vo, type, basicInfoIn);
		return output;
	}

}
