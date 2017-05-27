module EjiayouStationServer{
	["java:getset"]
	class ReasonOutPut{
		string reason;
		bool rst;
		string code;
	};

	interface EjiayouStationServerInterface{
		/** 支持多台后台打印机 */
		ReasonOutPut supplementSingleByMoreServerPrinter(string orderId,int type);//type 补打类型,1=顾客联 2=员工联 3=柜台联
		/** 验证成功扣除积分 */
		ReasonOutPut deductPointsOpt(string deuctPoints,string userId,string vipId,string stationId,string groupId);
	};
};
module YijiayouServer{
	["java:getset"]
	struct ReasonOutput{
		string reason;
		bool rst;
		string code;
	};
	/** 
		title:标题		content:内容		code:字段名
	*/
	class KVString{
		string title;
		string content;
		string code;
	};
	["java:type:java.util.ArrayList"] sequence <KVString> KVStringList;
	["java:type:java.util.ArrayList"] sequence <string> StringList;
	["java:type:java.util.ArrayList"] sequence <string> ListString;
	["java:type:java.util.ArrayList"] sequence <int> IntList;
	//加油机信息
	struct TankerInfo{
		int tankerId;
		string tankerNumber;
		string tankerState;
		string fillingStationName;
		
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
	};
	
	//油枪信息（油机改成油枪）
	struct OilGun{
		int oilgunId;
		string oilgunCode;
		string oilgunState;
		string oilgunName;
	};
	sequence<OilGun> OilGunSeq;
	

	struct Activity{
		string id;
		string activityPrice;//活动价格
		string activityName;//活动名
		int type;	//活动类型 类型 1金钱补贴 2 多加油补贴
		bool isChoice;//是否必选	
		bool isDefault;//是否默认	
		bool needinvoice;//是否要发票 跟活动优惠信息有关  
	};
	
	struct Activity1207{
		string id;
		string activityPrice;//活动价格
		string activityName;//活动名
		int type;	//活动类型 类型 1金钱补贴 2 多加油补贴
		bool isChoice;//是否必选	
		bool isDefault;//是否默认	
		bool needinvoice;//是否要发票 跟活动优惠信息有关  
		int carType;
		string carTypeName;
	};


	sequence<TankerInfo> TankerInfoSeq;


	//加油站
	struct FillingStation{
		int FillingStationId;
		string fillingStationName;
		string fillingStationaddress;
		string fillingStationTankerCount;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		TankerInfoSeq tankerInfoSeqI;
	};
	sequence<FillingStation> FillingStationSeq;
	

	
	//加油站(因油机改成而更改借口定义参数)
	struct FillingStation200{
		int FillingStationId;
		string fillingStationName;
		string fillingStationaddress;
		string fillingStationTankerCount;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		OilGunSeq oilGunSeqI;//油枪数组
	};
	/** 团购卷产品(包含团购卷包) */
	class GrouponAndPackInfo{
		long startTime;//抢购开始时间
		long endTime;//结束抢购时间
		bool isShow;//是否显示抢购时间  true=显示
		int grouponType;//1=普通团购卷 2=团购卷包
		int groupId;//普通团购卷/团购卷包id
		string grouponName;//团购卷名
		int stationId;//使用油站
		int oilId;//油品id
		int perValue;//单张面值
		string oilCode;//油品编码 
		int price;//总售价 
		int value;//总面额
		int num;//包含团购卷张数数量
		int lastNum;//剩余数量
		string discount;//折扣
		string availableDate;//有效日期		
		bool availableBuy;//是否能够购买 
		string imgType;//图片类型
	};
	/** 具体一个团购卷(团购卷包)  */
	class MyGrouponAndPackInfo extends GrouponAndPackInfo{
		int userGrouponId;//用户团购卷id/团购卷包id
		int userLastNum;//用户总共剩余数量
		int perTimeType;// 1=月 2=周 3=天
		int userPerTimeLastNum;//用户单位时间内剩余数量
		string useDesc;//使用说明多条用#隔开
		bool availableUse;//是否能够使用
		bool isRefund;//是否可退款 true=可退款
		string useTime;//使用时间
		string refundTime;//退款时间
	};
	["java:type:java.util.ArrayList"] sequence <MyGrouponAndPackInfo> MyGrouponAndPackInfoList;

	//订单
	struct CreateOrderInput{
		//公共_参数
		int userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		int fillingStationTankerId;
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
	};
	
	
	
	//创建订单(因油机概念改成油枪，老接口fillingStationTankerId改成oilgunIds)
	struct CreateOrderInput200{
		//公共_参数
		int userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		string oilgunIds;
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
	};
	
	struct CreateOrderInput922{
		//公共_参数
		int userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		string oilgunId;//油枪id
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
		string oilPrice;	//最终价格
		int oilId;		//油的id
		string oilMass;		//油的升数
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string unitPrice;//原单价
	};
	struct CreateOrderInput1101{
		//公共_参数
		int userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		string oilgunId;//油枪id
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
		string oilPrice;	//最终价格
		int oilId;		//油的id
		string oilMass;		//油的升数
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string unitPrice;//原单价
		string cashback;//返现
		int isFilled ;//是否加满 1加满
		string backupOne;//预留字段
		string backupTwo;
		string backupThree;
		string backupFour;
		string backupFive;
	};
	struct CreateOrderInput1014{
		//公共_参数
		int userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		string oilgunId;//油枪id
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
		string oilPrice;	//最终价格
		int oilId;		//油的id
		string oilMass;		//油的升数
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string unitPrice;//原单价
		string cashback;//返现
	};
	
	
	
	//微信Req
	struct WXPayReqOutput{
		string appId;
		string partnerId;
		string prepayId;
		string nonceStr;
		string timeStamp;
		string packageValue;
		string sign;
	};
	
	struct AliPayOutput{
		string tradeNo;//唯一订单号
		string subject;//订单名称
		string toTalFee;//订单总金额
	};

	//修改订单状态
	struct UpdateOrderStatusOutput{
		ReasonOutput reasonOutputI;
		string orderStatus; //订单当前状态
	};
	
	//获取订单信息
	struct UserOrderInfo{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string createTime;
		string payOrderTime;
		string cardPayMoney;
		string userPayMoney;
		string cardRemainBalance;
		string orderId;
		TankerInfo tankerInfoI;
	};
	
	//获取订单信息
	struct UserOrderInfo911{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string cardPayMoney;
		string userPayMoney;
		string cardRemainBalance;
		string orderId;
		TankerInfo tankerInfoI;
	};
	//获取订单信息
	struct UserOrderInfo922{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string cardPayMoney;
		string userPayMoney;
		string cardRemainBalance;
		string orderId;
		TankerInfo tankerInfoI;
		string priceDesc;//价格描述
		string oilMass;//升数
		string originalPrice;//原价
	};
	struct UserOrderInfo1016{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string cardPayMoney;
		string userPayMoney;
		string cardRemainBalance;
		string orderId;
		TankerInfo tankerInfoI;
		string priceDesc;//价格描述
		string oilMass;//升数
		string originalPrice;//原价
		string caskBack;//返现
	};
	
	
	struct UserOrderInfo1216{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string cardPayMoney;
		string userPayMoney;
		string cardRemainBalance;
		string orderId;
		TankerInfo tankerInfoI;
		string priceDesc;//价格描述
		string oilMass;//升数
		string originalPrice;//原价
		string caskBack;//返现
		string point;//返回积分
	};
	
	
	sequence<UserOrderInfo> UserOrderInfoSeq;
	sequence<UserOrderInfo911> UserOrderInfoSeq911;
	sequence<UserOrderInfo922> UserOrderInfoSeq922;
	sequence<UserOrderInfo1016> UserOrderInfoSeq1016;
	
	struct GetUserOrderInfoOutput{
		ReasonOutput reasonOutputI;
		UserOrderInfoSeq UserOrderInfoSeqI;
	};
	
	

	struct GetUserOrderInfoOutput1016{
		ReasonOutput reasonOutputI;
		UserOrderInfoSeq1016 userOrderInfoSeqI1016;
	};
	
	//个人信息
	struct SetUserInfo{
		int userId;
		string userPassword;
		bool passward;
		string userPhoneserial;
		bool serial;
		string userAccount;
		bool account;
		string userPhone;
		bool phone;
		string userCarNumber;
		bool number;
		string invoiceHead;
		bool invoice;
		string opendId;
		bool opFlag;
		string headIsDefault;
		bool headIsDefaultFlag;
	};
	
	struct UserInfo{
		string opendId;
		string userPassward;
		string userPhoneserial;
		string userAccount;
		string userPhone;
		string userCarNumber;
		string invoiceHead;
		string longitude;
		string latitude;
		string coordinatesFrom;
		string locationPrecision;
		string upTime;
		string headIsDefault;//
	};
	
	class UserInfo0707 {
		string opendId;
		string userPassward;
		string userPhoneserial;
		string userAccount;
		string userPhone;
		string userCarNumber;
		string invoiceHead;
		string longitude;
		string latitude;
		string coordinatesFrom;
		string locationPrecision;
		string upTime;
		string headIsDefault;//
		string carType;
		int auditState;//审核状态
	};
	
	class GetUserInfoOutput0707{
		UserInfo0707 UserInfoI;
		ReasonOutput reasonOutputI;
	};
	
	class UserBase{
		string opendId;
		string userId;
		string unionId;
	};
	
	class UserInfo0918 extends UserBase{
		string userName;//昵称
		bool userNameUpd;
		int sex;//性别 0=无 1=男 2=女
		bool sexUpd;
		string birthDate;//生日
		bool birthDateUpd;
		string invoiceHead;//发票抬头
		bool invoiceHeadUpd;
		string carType;//身份(1=私家车 2=出租车 3=货车 5=专车)
		int auditState;//审核状态
		string userCarNumber;//车牌(4.3版本暂时不管)
		bool userCarNumberUpd;//
	};
	

	
	class GetUserInfoOutput0918{
		UserInfo0918 UserInfoI;
		ReasonOutput reasonOutputI;
	};
	
	class AccountInfo0918 extends UserBase{
		string userPhone;//电话
		string smsCode;//验证码
		bool userPhoneUpd;
		string wxUnionID;//微信号
		bool wxUnionIDUpd;//
	};
	
	
	class UserInfo1207{
	    string opendId;
		string userId;
		string unionId;
		string userName;//昵称
		bool userNameUpd;
		int sex;//性别 0=无 1=男 2=女
		bool sexUpd;
		string birthDate;//生日
		bool birthDateUpd;
		string invoiceHead;//发票抬头
		bool invoiceHeadUpd;
		int carType;//身份(1=私家车 2=出租车 3=货车 5=专车)
		string carTypeName;//车身份名称 carType= 1 私家车   carType > 1 其他为营运车辆
		int auditState;//审核状态
		string userCarNumber;//车牌(4.3版本暂时不管)
		bool userCarNumberUpd;//
	};
	
	class UserInfo20170421 extends UserInfo1207{
		string headImg;//头像图片
		bool headImgUpd; 
	};
	
	class IndentShowInfo1207{
		string imgUrl1;
		string detailInfos1;
	};
	
	sequence<IndentShowInfo1207> IndentShowInfoSeq1207;
	//身份返回信息
	class GetUserInfoOutput1207{
		UserInfo1207 UserInfoI;
		ReasonOutput reasonOutputI;
		int   state;  //跳转页面的状态 1 = 我的身份（身份选择） 2=第三方平台  3 = 我的身份审核中的状态
		//以下字段为state为2的时候用到
		string titleInfos; //货拉拉 快狗
		IndentShowInfoSeq1207 indentShowInfoSeq;
	};
	
	
	class GetAccountInfoOutput0918{
		AccountInfo0918 accountInfoI;
		ReasonOutput reasonOutputI;
	};
	
	class WeiXinInfo{
		string nickname;//昵称
		string headimgurl;//头像
		int sex;//性别
		string province;//省份
		string city;//城市
		string country;//家乡
		string unionId;//微信号
	};
	
	class AccountInfo1029 extends UserBase{
		string smsCode;//验证码
		string userPhone;//电话
		bool userPhoneUpd;
		
		WeiXinInfo weiXinInfoI;//微信账号信息
		bool wxUnionIDUpd;//
	};
	
	class GetAccountInfoOutput1029{
		AccountInfo1029 accountInfoI;
		ReasonOutput reasonOutputI;
	};
	
	class AccountInfo20170115 extends UserBase{
		string smsCode;//验证码
		string userPhone;//电话
		bool userPhoneUpd;
		
		WeiXinInfo weiXinInfoI;//微信账号信息
		bool wxUnionIDUpd;//
		int showModifyPwd; // 是否展示修改密码，0为否1为是
		
	};
	
	class AccountInfo20170215 extends UserBase{
		string smsCode;//验证码
		string userPhone;//电话
		bool userPhoneUpd;
		
		WeiXinInfo weiXinInfoI;//微信账号信息
		bool wxUnionIDUpd;//
		int isShowEcardInterface; // 是否展示认证和修改密码入口，0为否1为是
		
		int isHadPassword; // 是否有密码，0 == 没有 1 == 有
		int hadCertification; // 是否实名认证: 1 = 已实名，0 = 未实名
		string name; // 用户名字
		string idCardNo; // 身份证
	};
	
	class GetAccountInfoOutput20170115 {
		AccountInfo20170115 accountInfoI;
		ReasonOutput reasonOutputI;
	};
	
	class GetAccountInfoOutput20170215 {
		AccountInfo20170215 accountInfoI;
		ReasonOutput reasonOutputI;
	};
	
	struct GetUserInfoOutput{
		UserInfo UserInfoI;
		ReasonOutput reasonOutputI;
	};
	
	struct CreateUserInput{
		string opendId;
		string userphoneserial;
		string useraccount;
		string userPhone;
		string password;
	};
	struct CreateUserInput818{
		string opendId;
		string userphoneserial;
		string useraccount;
		string userPhone;
		string password;
		string osType;//1==安卓  2==平台 3==微信
		string appId;//微信多公众平台注册是用的.其他平台不管
	};


	
	
	struct CreateUserIdOutput0120{
		ReasonOutput reasonOutputI;
		string userId;
		string activityType;//1=网页  2=文字
		string activityUrl;	//1=连接  2=文字
		string versionDes;//版本描述
		string version;//版本号
		string isCompelUpdate;//是否强制升级 0表示否 1表示要
		string phoneNumber;//电话号码
	};
	
	
	
	struct UpdateCoord{
		int userId;
		string longitude;
		string latitude;
		string coordinatesFrom;
		string locationPrecision;
		string upTime;//数据库时间 不用填写
	};
	//销售商品油卡
	struct CardProduct{
		int productId;
		string createTime;
		string endTime;
		string oriCharge;
		int fillingStationId;
		string remarks;
		string  productImage;
		string discountCharge;
		string name;
		int buyCount;//购买次数
	};
	sequence<CardProduct> CardProductSeq;
	struct StationInfo{
		string stationName;
		int distance;
		CardProductSeq cardProductSeqI;
	};
	
	//购买油卡订单
	struct CreateCardOrderOutput{
		ReasonOutput reasonOutputI;
		string productOrderId;//订单号
		WXPayReqOutput wxPayReqOutputI;
	};
	struct CreateCardOrderInput{
		int productId;
		int userId;
		int fillingStationId;
		string money;
		int payType;	//1==微信支付2==支付宝支付
		int num;
	};
	//我的油卡
	struct UserBalance{
		int cardId;
		string cardBalance;
		string createTime;
		int fillingStationId;	
		string cardName;
		string cardImage;
	};
	sequence<UserBalance> UserBalanceSeq;
	
	

	//用户建议
	struct UserSuggestionInput
	{
		int mobilePlatform; //1==IOS  2==安卓             
		int userAccount; 
		string versionCode;//版本
		string userSuggestionText;//反馈内容
		
	};
	//问题反馈
	struct UserSuggestionReply
	{
		string suggestionReply;	
		string replyDate;
	};
	sequence<UserSuggestionReply> UserSuggestionReplyI;
	struct UserSuggestionText
	{
		string suggestion;
		string suggestionDate;
		UserSuggestionReplyI userSuggestionReplyISeq;
	};	
	sequence<UserSuggestionText> UserSuggestionI;
	struct UserSuggestionReplyOutput
	{
		ReasonOutput outputI;
		UserSuggestionI userSuggestionISeq;
	};



	//用户最新消息
	struct UserMessage{
		string title;
		string subTitle;
		string context;
		string messageImg;
	};
	sequence<UserMessage> UserMessageSeq;
	struct GetUserMessageOutput{
		UserMessageSeq userMessageSeqI;
		ReasonOutput outputI;
	};
	struct UserMessageUserAccount{
	//user_message_info.id type createTime endTime 
		string userAccount;
		string title;
		string subTitle;
		string context;
		string messageImg;
	};
	//只包含油站的信息
	struct FillingStationOnly{
		int FillingStationId;
		string fillingStationName;
		string fillingStationaddress;
		string fillingStationTankerCount;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		string d;//距离中心点的距离
		int tankerCount;
		int provinceId;
		int cityId;
		int printerNumber;//油站后台打印机
		int townsId;
		string mapPic;
	};
	sequence<FillingStationOnly> FillingStationOnlySeq;
	
	
	sequence<UserMessageUserAccount> AddUserMessageSeq;
	struct GetNewVersionOutput{
		ReasonOutput outputI;
		string version;//版本
		string createDate;//创建时间
		string versionD;//发布描述
		string versionRemarks;//版本备注
		int mobileType;
	};
	struct GetPayStatesOutput{
		ReasonOutput outputI;
		bool payALi; //支付支付宝支付  true
		bool payWeiXin;//支持微信支付 true
	};
	
	
	
	
	struct GetOrderStatusOutput{
		ReasonOutput outputI;
		string orderPayStatus;//支付状态  0 未支付 1 已支付
		string orderPrinterStatus; // 打印状态 0 未打印 1 已打印
		string orderRefundStatus;// 退款状态 0未申请退款 1 退款申请审核 2通过审核退款中 3审核不通过  4 完成退款
	};
	struct GetOrderPrinterStatusOutput{
		ReasonOutput outputI;
		int orderPrinterStatus; // 打印状态 0 未打印 1 已打印
	};
	struct CreateOrderOutput1216{
		ReasonOutput reasonOutputI;
		string orderSign;//订单号
		WXPayReqOutput wxPayReqOutputI;
		//UserOrderInfo911 userOrderInfoI;	//返回当前插入的历史对象
		AliPayOutput aliPayOutputI;//手机网页支付需要的
		string  aliOrderData;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 8.微信手机web支付
		string cardPayMoney;//油卡支付金额
		string userPayMoney;//用户支付金额
		string cardBalance;//支付后油卡余额
		UserOrderInfo1216 userOrderInfo1216I;//返回插入对象的数据
	};
	struct CreateOrderOutput0622{
		ReasonOutput reasonOutputI;
		string orderSign;//订单号
		WXPayReqOutput wxPayReqOutputI;
		string wxWebPayLastMoney;//微信端发起支付的用的钱
		string  aliOrderData;
		int stationId;//油站ID
	};
	//翻翻乐返回结构
	struct TurnHappyOutput{
		ReasonOutput reasonOutputI;
		string turnOrderId;//订单号
		WXPayReqOutput wxPayReqOutputI;
	};
	
	//油枪和油,油价信息
	struct OilGunAndOil{
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
	};
	sequence<OilGunAndOil> OilGunAndOilSeq;

	
	//退款账单信息
	struct RefundableOrder{
		string orderId;//订单号
		string orderSum;//订单金额
		string originalCost;//原总金额
		string oilPrice;//单价
		string unitPrice;//原单价
		string oilMass;//油量
		string payOrderTime;//支付时间
		string oilName;//油品名称
		string oilgunName;//油枪名称
	};
	
	sequence<RefundableOrder> RefundableOrderSeq;
	
	struct GetStationRefundableOrderOutput {
		ReasonOutput reasonOutputI;
		RefundableOrderSeq refundableOrders;
	};
	

		//油枪和油,油价信息
	struct OilGunAndOil1112{
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
	};
	struct OilGunAndOil1207{
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity1207 activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
	};
	
	struct OilGunAndOil0115 {
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity1207 activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
		int pointRule;//每升多少积分
	};
	struct OilGunAndOil0229 {
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity1207 activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
		int pointRule;//每多少积分
		int pointMass;//1|2*升pointRule积分
	};
	struct OilGunAndOil0622 {
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//92#
		string oilCode;//汽油
		string oilId;	//油id
		Activity1207 activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
		int pointRule;//每多少积分
		int pointMass;//1|2*升pointRule积分
		string countryPrice;//国家挂牌家
	};
	
	struct OilGunAndOil20170227 {
		int oilgunId;
		string oilgunCode;
		string oilgunName;
		string price;	//油的原价
		string oilName;	//92#
		string oilCode;//汽油
		string oilId;	//油id
		Activity1207 activityI;	//活动id
		bool serverPrinterState;//后台打印机状态
		bool printerState;//前台打印机状态
		string printerCode;//前台打印机code
		string serverPrinterCode;
		int pointRule;//每多少积分
		int pointMass;//1|2*升pointRule积分
		string countryPrice;//国家挂牌家
		int payType; // 支付类型 22为e卡，20为车队卡，21为个人储值卡，1为微信，2为支付宝
		string balance; // 余额，为储值卡时有值，否则为零
	};
	
	sequence<OilGunAndOil0115> OilGunAndOil0115Seq;
	sequence<OilGunAndOil1207> OilGunAndOil1207Seq;
	sequence<OilGunAndOil1112> OilGunAndOil1112Seq;
	sequence<OilGunAndOil0229> OilGunAndOil0229Seq;
	sequence<OilGunAndOil0622> OilGunAndOil0622Seq;
	sequence<OilGunAndOil20170227> OilGunAndOil20170227Seq;
	class TheCashBackRule{
		string cashBack;//返现
		string limitMoney;//限制金额
	};
	["java:type:java.util.ArrayList"] sequence <TheCashBackRule> CashBackRuleSeq;


	
	/** V 11.17 优惠卷,Vip */
	class ReasonOutputA{
		bool rst;
		string reason;
		string code;
	};
	class VipCard{
		string vipId;
		string vipName;
		int stationId;
		string reducePrice;
	};
	
	class Coupon{
		int staionId;
		string couponId;
		string stationName;
		string startTime;
		string endTime;
		string couponName;//优惠名字
		string fullMoney;//限制金额
		string reducePrice;//优惠的钱
		int type;//类型 1,代金券  2,油价优惠
	};

	
	class OrderInfo{
		string carNumber;
		string stationName;
		string orderId;
		int payType;//1==微信支付2==支付宝支付3==油卡支付4==微信+油卡5==支付宝+油卡
		string money;
		string invoiceHead;//发票抬头
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string userPayMoney;
		string priceDesc;//价格描述
		string oilMass;//升数
		string originalPrice;//原价
		string caskBack;//返现
		
		VipCard vipCardI;//会员卡
		Coupon couponI;//优惠卷
	};
	["java:type:java.util.ArrayList"] sequence <OrderInfo> OrderInfoSeq;
	class GetUserOrderInfoOutputV117{
		ReasonOutput rOutPut;
		OrderInfoSeq OrderInfoList;
	};

	class CreateOrderInputV1117{
		//公共_参数
		string userId;
		int payType;//1==微信客服端支付2==支付宝无线快捷支付3==油卡支付4==微信+油卡5==支付宝+油卡 6.支付宝手机web支付 7支付宝手机web支付 +油卡支付 
		int productType;//商品类型1==加油2==油卡	
		string money;//订单金额
		string invoiceHead;//发票抬头
		int fillingStationId;
		//加油_参数
		string oilgunId;//油枪id
		bool hadInvoice;//是否有抬头	
		string carNumber;//车牌号
		//油卡_参数
		int productId;//油卡商品的Id
		int cardNums;//买卡的数量
		string oilPrice;	//最终价格
		int oilId;		//油的id
		string oilMass;		//油的升数
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string unitPrice;//原单价
		string cashback;//返现
		int isFilled ;//是否加满 1加满
		string backupOne;//预留字段
		string backupTwo;
		string backupThree;
		string backupFour;
		string backupFive;
		
		string vipCardId;//会员卡id
		string couPonId;//优惠卷id
	};
	class Station{
		string stationId;
		string stationName;
		string stationAddress;
		string stationPhone;
	};
	class PointRule{
		string instruction;//会员权益介绍
		string vipImageUrl;//会员卡图片路径
		string integralInstruction;//会员积分规则介绍
	};
	//返回会员卡信息
	class ReturnVipInfoOutPut{
		ReasonOutput rOut;
		PointRule pointRuleOut;//积分规则
	};
	class CreateVipForUserOutPut{
		ReasonOutput rOut;
		string applySuccessWords;//申请成功话术
	};
	class VipInfo{
		string vipId;//会员卡id
		string points;//积分数
		string userId;//用户Id
		string vipImageUrl;//vip图片
		bool isNeocaine;//是否是新卡
	};
	["java:type:java.util.ArrayList"] sequence <VipInfo> VipInfoSeq;
	class QueryUserVipListOutPut{
		ReasonOutput rOut;
		VipInfoSeq vipInfoList;//用户会员卡
	};
	class VipRecord{
		string pointTime;//积分时间
		string points;//积分
		string stationName;//油站名字
	};
	["java:type:java.util.ArrayList"] sequence <VipRecord> VipRecordSeq;
	["java:type:java.util.ArrayList"] sequence <Station> AllianceStationSeq;
	class QueryUserVipDetailOutPut{
		ReasonOutput rOut;
		string points;//现有积分
		string stationName;//油站名字
		PointRule pointRuleOut;//积分规则
		VipRecordSeq VipRecordList;//积分记录
		AllianceStationSeq AllianceStationList;//联盟油站
	};
	class QueryOrderPayInfo{
		string orderId;
		string userId;
		string createTime;
		string stationName;
		string oilGunId;
		string oilGunCode;
		string orderSum;//实际支付
		string originalCost;//原价
		string subsidyMoney;//补贴
		string discountDesc;
		int payStatus;//支付状态
		int type;//  1==使用金钱加油   	2==使用团购卷加油  
	};

	["java:type:java.util.ArrayList"] sequence <QueryOrderPayInfo> QueryOrderPayInfoSeq;
	class QueryOrderPayInfoMoreOut{
		ReasonOutput rOut;
		QueryOrderPayInfoSeq QueryOrderPayInfoList;
	};
	
	class SendVerificationCodeOut{
		ReasonOutput rOut;
		string smsCode;//申请成功话术
	};
	
	class CheckSmsCode1029{
		ReasonOutput rOut;
		int userId;
		int idType;
		bool isNew;//true=新用户
	};
	
	class StationInfo0119{//油站信息（增加团购，会员信息）
		int stationId;//油站id
		string stationName;//油站名称
		string townName;//城市名称
		string areaName;//区域名称
		string distance;//距离
		bool isSupportGroupBuy;//是否支持团购
		bool isSupportVip;//是否支持vip
		bool isVip;//是否是油站vip
	};
	
	



	
	class VipDispalyInfo{
		int vipId;//会员id	
		string instruction;//会员权益介绍
		string vipImageUrl;//会员卡图片路径
	};
	

	
	
	
	class CreateUserInput0120{
		string opendId;
		string userId;//如果有传，没有传空
		string userphoneserial;//手机系列号
		string useraccount;//账户
		string userPhone;//手机号码
		string password;//密码
		string osType;//1==IOS  2==安卓 3==微信
		string appId;//微信多公众平台注册是用的.其他平台不管
		string unionId;//用户统一标识
		string loginType;//1--注册 2--登陆  3--微信三方登陆
	};
	
	
	class ActivityMesssage{
		int messageId;//消息id
		int type;//消息类型 1、新油站上线 2、油价调整 3、团购推荐 4、 油站活动
		string icon;//图标
		string title;//标题
		string desc;//描述
		int userStationId;//使用油站ID
		string url;//链接路劲
		string activityDate;
	};
	
	["java:type:java.util.ArrayList"] sequence <ActivityMesssage> ActivityMesssageList;
	class QueryActivityMessageOutPut{
		ReasonOutput rOut;
		ActivityMesssageList activityMesssageListI;
	};

	class PayOrderByGrouponOutPut{
		ReasonOutput rOut;
		//返回支付成功信息
	};
	
	
	class CreateOrderReturnGrouponInPut{
		int stationId;
		int oilId;
		string oilGunId;
		string userId;
		string price;//油价
		string orderSum;//订单总金额
		ListString userGroupIds;//使用团购卷id
	};

	class PayOrderByGrouponInPut{
		string orderId;
		int stationId;
		ListString useGrouponIds;
		string oilMass;//油量
		string orderSum;//总面值
		string invoiceHead;//发票
	};
	

	class MyCouponInfo{
		string userCouponId;//用户拥有的优惠券id
		string desc; //优惠劵描述
		string limitTime;//有效日期
		string value;//面值
		string limitMoney;//限制金额
	};
	
	class MyCouponInfo0322{
		string userCouponId;//用户拥有的优惠券id
		string desc; //优惠劵描述
		string limitTime;//有效日期
		string value;//面值
		string limitMoney;//限制金额
		bool isDiscount;//是否和优惠叠加
	};
	
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfo> MyCouponInfoList;
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfo0322> MyCouponInfo0322List;
	
	class GetOilgunCouponInfoOuPut{
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id
		Activity activityI;	//活动id
		OilGunAndOil1112Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		CashBackRuleSeq cashBackRuleSeqI;
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string integralRule;//积分规则
		MyCouponInfoList couponInfoListI;//用户拥有的优惠券
	};



	class CreateOrderInput0217{
		int userId;
		string carNumber;//车牌号
		int payType;//1==微信客服端支付 8==微信wap支付 11==团购卷
		int productType;//商品类型1==加油2==团购卷	
		bool hadInvoice;//是否有抬头	
		string invoiceHead;//发票抬头
		int fillingStationId;
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string oilPrice;	//最终价格
		string unitPrice;//原单价
		string oilgunId;//油枪id
		int oilId;		//油的id
		string money;//订单金额
		string oilMass;		//油的升数
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string cashback;//返现
		int isFilled ;//是否加满 1加满
		string userCouponId;//使用优惠劵id
		int reducePoints;//抵扣积分
		string reducePointMoney;//抵扣积分金额(钱)
	};


	class CreateOrderInput0224{
		int userId;
		string carNumber;//车牌号
		int payType;//1==微信客服端支付 8==微信wap支付 11==团购卷
		int productType;//商品类型1==加油2==团购卷	
		bool hadInvoice;//是否有抬头	
		string invoiceHead;//发票抬头
		int fillingStationId;
		string activityId;//参加活动的id 没有参与活动传入"-1"
		string oilPrice;	//最终价格
		string unitPrice;//原单价
		string oilgunId;//油枪id
		int oilId;		//油的id
		string money;//订单金额
		string oilMass;		//油的升数
		string priceDesc;//价格描述
		string originalCost;//订单原价
		string cashback;//返现
		int isFilled ;//是否加满 1加满
		string userCouponId;//使用优惠劵id
		int reducePoints;//抵扣积分
		string reducePointMoney;//抵扣积分金额(钱)
		int carType;//享受改单的优惠车类型
		int osType;//用户平台
		int userDiscountCouponId;//用户折扣券Id
	};
	class CreateOrderInput0622{
		int userId;
		int payType;//1==微信客服端支付 8==微信wap支付 2==支付宝支付
		int productType;//商品类型1==加油2==团购卷---0622没有使用预留字段	
		bool hadInvoice;//是否有抬头	
		string invoiceHead;//发票抬头
		int fillingStationId;
		int oilgunId;//油枪id
		int oilId;		//油的id
		string orderSum;//订单金额
		string originalCost;//用户输入金额
		int userCouponId;//使用优惠劵id
		int createOrderCarType;//下单时候记录该单享受的什么车身份
	};
	
	class CreateOrderInput20170421{
		int userId;
		int payType;//1==微信客服端支付 8==微信wap支付 2==支付宝支付
		int productType;//商品类型1==加油2==团购卷---0622没有使用预留字段	
		bool hadInvoice;//是否有抬头	
		string invoiceHead;//发票抬头
		int fillingStationId;
		int oilgunId;//油枪id
		int oilId;		//油的id
		string orderSum;//订单金额
		string originalCost;//用户输入金额
		int userCouponId;//使用优惠劵id
		int createOrderCarType;//下单时候记录该单享受的什么车身份
		string carNumber;
	};
	
	class TurnHappyParamters{
		int userId;
		string orderId;//订单号
		double payMoney;//支付金额
		string stationId;
		string payTime;//支付时间 
	};
	class UserOrderInfo0217{
		string carNumber;
		string orderSign;
		int payType;//1==微信支付 8==微信wap支付 11==团购卷支付
		bool isAliPayWap;//是不是微信上面,网页支付宝支付 
		string money;
		string invoiceHead;//发票抬头
		bool hadInvoice;//是否有抬头	
		string payStatus;
		string refundStatus;//0==正常订单1==审核中2==同意退款3==不同意退款 4==已退款
		string createTime;
		string payOrderTime;
		string orderId;
		TankerInfo tankerInfoI;
		string priceDesc;//价格描述
		string oilMass;//升数
		string originalPrice;//原价
		string caskBack;//返现
		string points;//该订单积累的积分
		int reductPoints;//抵扣的积分
		string reducPointsMoney;//抵扣积分对应的金额
		string couponValue;//优惠劵面值
		string useBalance;//使用余额
	};
	
	["java:type:java.util.ArrayList"] sequence <UserOrderInfo0217> UserOrderInfo0217List;
	class GetUserOrderInfoOutput0217{
		ReasonOutput reasonOutputI;
		UserOrderInfo0217List userOrderInfo0217ListI;
	};
	
	class QueryOrderPayInfo0217{
		string orderId;
		string userId;
		string createTime;
		string stationName;
		string oilGunId;
		string oilGunCode;
		string orderSum;//实际支付
		string originalCost;//原价
		string subsidyMoney;//补贴
		int reductPoints;//抵扣的积分
		string reducPointsMoney;//抵扣积分对应的金额
		string couponValue;//优惠劵面值
		string useBalance;//使用余额
		int payStatus;//支付状态
		string discountDesc;
		int type;//  1==使用金钱加油   	2==使用团购卷加油  
	};

	["java:type:java.util.ArrayList"] sequence <QueryOrderPayInfo0217> QueryOrderPayInfoList0217;
	class QueryOrderPayInfoMore0217OutPut{
		ReasonOutput rOut;
		QueryOrderPayInfoList0217 queryOrderPayInfoListI;
	};
	
	class GrouponAndTimeInfo {
		int groupId;
		string stationId;
		string stationName;
		int oilId;
		string oilName;
		string value;//面值
		string price;//价格
		int surplusAmount;//剩余数量
		string usedLimt;//使用条款(多条使用@分割)
		long startMillisecond;//开始时间
		long endMillisecond;//截止时间
		long purchaseStartTime;//抢购开始时间
		long purchaseEndTime;//抢购结束时间
	};
	["java:type:java.util.ArrayList"] sequence <GrouponAndTimeInfo> GrouponAndTimeInfoList;
	
	class GrouponAndTimeStationInfo{
		int stationId;
		string stationName;
		int areaId;//地区
		string areaName;
		int territoryId;//地域
		string territoryName;
		string recommendReason;//推荐原因
		GrouponAndTimeInfoList grouponAndTimeInfoListI;
		int distance;	//距离(米)
	};
	["java:type:java.util.ArrayList"] sequence <GrouponAndTimeStationInfo> GrouponAndTimeStationInfoList;
	class QueryAllGrouponAndTimeOutPut{
		ReasonOutput rOut;
		bool isHave;		//用户当前是否有未使用的团购券
		GrouponAndTimeStationInfoList grouponAndTimeStationInfoListI;
	};
	
	class StationDetailAndTimeOutPut{
		ReasonOutput rOut;
		int stationId;//油站id
		string stationName;//油站名称
		string stationAddress;//油站地址
		string phone;//油站电话号码
		string stationUrl;//油站图片
		string introduction;//油站简介
		string longitude;//经度
		string latitude;//纬度
		bool isStationVip;//用户是否是该油站会员
	    GrouponAndTimeInfoList grouponAndTimeInfoListI;
		VipDispalyInfo vipDispalyInfoI;//会员卡展示信息
	};
	
	
	
	class UserBestChoice{
		string cashBack;//用户补贴
		string vipSubsidy;//油价优惠金额
		string pointMoney;//抵扣积分金额
		string useBalance;//使用余额
		string choiceCouponId;//选择优惠劵id
		string choiceCoupoValue;//选择优惠劵金额
	};

	
	class LoginOutPut{
		ReasonOutput reasonOutputI;
		string userId;
	};
	class ChangeUserBindingPhoneOutput{
		ReasonOutput reasonOutputI;
		string userId;
	};
	class StationProject{
		string name;//项目名
		int type;//1==抽奖 2==充值 3==兑换积分
		bool isSupport;//1==支持 2==不支持
	};
	["java:type:java.util.ArrayList"] sequence <StationProject> StationProjectList;
	class QueryStationSupportProjectOutPut{
		ReasonOutput reasonOutputI;
		StationProjectList stationProjectListI;
	};
	class QueryUserPointsOutPut{
		ReasonOutput reasonOutputI;
		string userId;
		string stationName;
		string vipId;
		string stationId;
		string groupId;//默认使用1组
		int surplusPoints;//剩余积分
	};
	class RegisterUserOutput{
		ReasonOutput reasonOutputI;
		string userId;//注册成功返回的userId
	};
	
	
	class RegisterOrLoginOutput extends RegisterUserOutput{
		int idType;//车辆类型
	};
	

	
	class RegisterOrLoginOutput1030 extends RegisterUserOutput{
		int idType;				//车辆类型
		string existingPhone;	//存在的电话号码
		string carNumber;		//车牌号码
	};
 	

	class HomePageAd{
		string url;
		string imgUrl;
		int type;//1 外部链接 2 内部链接  
	};
	["java:type:java.util.ArrayList"] sequence <HomePageAd> HomePageAdList;
	class HomePageInfOutPut{
		ReasonOutput reasonOutputI;
		HomePageAdList homePageAdListI;
		int couponCount;
		int messageId;
	};
	



	class StationDetail{
		ReasonOutput reasonOutputI;
		string stationName;//油站名
		string stationAddress;//油站地址
		string stationDesc;//油站介绍
	}; 
	
	class UserInfoOutput{
		ReasonOutput reasonOutputI;
		string userPhone;//电话号码
		int vipCardNum;//会员卡张数
		int vipCardPoints;//会员卡总积分
		int groupNum;//团购卷数量
		int couponNum;//优惠劵数量
		int fillingNum;//加油次数
	};
	/** code: 020=油站不支持红包  021=订单未支付成功/订单有误  */
	class RedEnvelopeOutPut{
		ReasonOutput reasonOutputI;
		int num;//红包数量
		string userRedEnvelopeId;//用户生成包含数量的红包id
		double saveMoney;//节省金额
		string url;//分享链接
	};
	class RegisterUserSendOutput{
		ReasonOutput reasonOutputI;
		string userId;//注册成功返回的userId
		bool isHave;//是否 有送劵 true=有
		double sValue;//送的卷面值
		int couponId;//送的优惠卷id
	};


	
	
	
	
	

	class CreateGrouponPack{
		int userPackId;//用户团购卷/团购卷包id
		int num;//使用数量
		int grouponType;//1=普通团购卷 2=团购卷包
	};
	class CreateGrouponPackUtil extends CreateGrouponPack{
		int perValue;
		int perPrice;
	};
	
	["java:type:java.util.ArrayList"] sequence <CreateGrouponPack> CreateGrouponPackList;
	class CreateOrderReturnGrouponPackInPut{
		int stationId;
		int oilId;
		string oilGunId;
		string userId;
		string price;//油价
		string orderSum;//订单总金额
		CreateGrouponPackList createGrouponPackListI;//选择的团购卷/包
	};

	class PayOrderByGrouponPackInPut{
		string orderId;
		int stationId;
		CreateGrouponPackList choiceUserGroupIds;
		string oilMass;//油量
		string orderSum;//总面值
		string invoiceHead;//发票
	};
	class ActivityMesssageAndUser{
		int messageId;//消息id
		string userId;
		int type;//消息类型 1、新油站上线 2、油价调整 3、团购推荐 4、 油站活动
		int useMessgeType;//1=红包个人消息 2=新用赠送优惠劵户个人消息 3.审核消息4.优惠券过期消息5.评价消息6.邀请成功消息
		string icon;//图标
		string title;//标题
		string desc;//描述
		int userStationId;//使用油站ID
		string url;//链接路劲
		string activityDate;
	};
	
	["java:type:java.util.ArrayList"] sequence <ActivityMesssageAndUser> ActivityMesssageAndUserList;
	class QueryActivityMessageAndUserOutPut{
		ReasonOutput rOut;
		ActivityMesssageAndUserList activityMesssageAndUserListI;
	};
	class GetMyRedEnvelopesOutput{
		ReasonOutput reasonOutputI;
		string money;//抽到的红包金额
	};
	
	//问题反馈对象
	class UserSuggestionReplyl{
		string suggestionReply;	
		string replyDate;
	};
	["java:type:java.util.ArrayList"] sequence<UserSuggestionReplyl> UserSuggestionReplyList;
	class UserSuggestionTextl{
		string suggestion;
		string suggestionDate;
		UserSuggestionReplyList userSuggestionReplyListI;
	};	
	["java:type:java.util.ArrayList"]  sequence<UserSuggestionTextl> UserSuggestionTextList;
	class UserSuggestionReplylOutput
	{
		ReasonOutput outputI;
		UserSuggestionTextList userSuggestionTextListI;
	};
	class RedEnvelope0525Output extends RedEnvelopeOutPut{ 
		string shareText;//分享文案
		string htmlPicUrl;//展示页面图片地址
		string logoUrl;//展示页面logo图片地址
		string htmlBottomColor;//底部色值
	};
	class GetMyRedEnvelopes0525Output extends GetMyRedEnvelopesOutput{
		string htmlPicUrl;//展示页面图片地址
		string htmlBottomColor;//底部色值
	};
	dictionary<string, string> ParaMap;
	class ActivityMesssageParaMap extends ActivityMesssageAndUser{
		/** key:shareText=分享文案  htmlPicUrl=展示页面图片地址 logoUrl=展示页面logo图片地址 htmlBottomColor=底部色值 */
		ParaMap paraMapI;//消息中返回数据 暂时 红包优化使用
	};
	["java:type:java.util.ArrayList"]  sequence<ActivityMesssageParaMap> ActivityMesssageParaMapList;
	class QueryActivityMessage0525Output{
		ReasonOutput rOut;
		ActivityMesssageParaMapList activityMesssageParaMapListI;
	};

	/** 补贴活动类型 1=分享红包活动 2=抽奖活动 3=直接送优惠劵 */
	class ActivitySubsidy{
		int activityType;//补贴活动类型 -1=支付成功页面 1=分享红包活动 2=抽奖活动 3=直接送优惠劵 4=非油品代金券
		int activityId;//补贴活动id
	};

	class RedEnvelopeActivity extends ActivitySubsidy{
		int num;//红包数量
		string userRedEnvelopeId;//用户生成包含数量的红包id
		double saveMoney;//节省金额
		string url;//分享链接
		string shareText;//分享文案
		string htmlPicUrl;//展示页面图片地址
		string logoUrl;//展示页面logo图片地址
		string htmlBottomColor;//底部色值
	};

	
	class MonthlyOrderActivity extends ActivitySubsidy{
		bool isHadPrize;//是否已经获取奖品
	    string title;//活动标题
		string desc;//活动描述
		string rule;//活动规则
		int joinCount;//用户参加次数
		string limitDate;//活动结束说明
		string userInfo;//活动活动信息
	};	
	
	["java:type:java.util.ArrayList"]  sequence<string> IntArray;
	class DirectCouponActivity extends ActivitySubsidy{
		IntArray intArrayI;//直接送的面值 数组
	};
	
	class DirectCouponInfo{
	   string couponValue;//团购券金额
	   string limitDate;//截止日期
	   string limitDesc;//限制说明
	};
	
	["java:type:java.util.ArrayList"]  sequence<DirectCouponInfo> DirectCouponInfoList;
	
	class DirectCouponLimitInfoActivity extends ActivitySubsidy{
		DirectCouponInfoList DirectCouponInfoListI;//送优惠券信息
	};
	
	["java:type:java.util.ArrayList"]  sequence<ActivitySubsidy> ActivitySubsidyList;
	class QueryActivitySubsidyByOrderIdOutPut{
		ReasonOutput reasonOutputI;
		ActivitySubsidy activitySubsidyI;
	};
	
	class QueryActivitySubsidyByOrderIdAndClientOutPut extends QueryActivitySubsidyByOrderIdOutPut{
		bool isHadActivity;//是否有活动
		string 	activityPath;//活动路径
		IntArray intArrayI;//分享类型
	};
	
	class MyCouponInfoVone extends MyCouponInfo {
		int state;////1=未使用/未过期 2=已经过期 3=已经使用 4==未使用的代金券  5==已过期的代金券
	};
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone> MyCouponInfoVoneList;
	class QueryMyCouponOutput{
		ReasonOutput reasonOutputI;
		MyCouponInfoVoneList myCouponInfoVoneListI;//包含未使用/已经过期  已经过期排最下面
	};

	class MyCouponInfoVone0618 extends MyCouponInfo {
		int state;//1=未使用/未过期 2=已经过期 3=已经使用 4==未使用的代金券  5==已过期的代金券
		string useExplain;//使用说明 
	};
	
	class MyCouponInfoVone0803 extends MyCouponInfoVone0618 {
		int clientType;//1：通用优惠券2：客户端使用优惠券3微信端使用优惠券
	};
	["java:type:java.util.ArrayList"] sequence <string> CouponRuleList;
	class MyCouponInfoVone0918 extends MyCouponInfoVone0803 {
		string color;//优惠券底色
		string limitExplain;
		CouponRuleList couponRuleListI;
		
	};
	
	
	class MyCouponInfoVone0222 extends MyCouponInfoVone0918 {
		int couponType;//1直减金额券2折扣券
		
	};
	
	class MyCouponInfoVone0304 extends MyCouponInfoVone0222 {
		string stationIdstr;//支持油站Id(支持两家以下油站是为空)
	};
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone0618> MyCouponInfoVonePrizeList;
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone0803> MyCouponInfoVonePrizeAndTypeList;
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone0918> MyCouponInfoVonePrizeAllList;
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone0222> MyCouponInfoVonePrizeAndDiscountAllList;
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoVone0304> MyCouponInfoMoreStationAllList;
	class QueryMyCouponOutput0618{
		ReasonOutput reasonOutputI;
		MyCouponInfoVonePrizeList myCouponInfoVonePrizeListI;//包含未使用/已经过期  已经过期排最下面
	};
	
	
	class QueryMyCouponOutput0918{
		ReasonOutput reasonOutputI;
		MyCouponInfoVonePrizeAllList myCouponInfoVonePrizeAllListI;//包含未使用/已经过期  已经过期排最下面
		int maxUserCouponId;
	};
	
	class QueryMyCouponOutput0222{
		ReasonOutput reasonOutputI;
		MyCouponInfoVonePrizeAndDiscountAllList myCouponInfoVonePrizeAndDiscountAllListI;//包含未使用/已经过期  已经过期排最下面
		int maxUserCouponId;
	};
	
	class QueryMyCouponOutput0304{
		ReasonOutput reasonOutputI;
		MyCouponInfoMoreStationAllList MyCouponInfoMoreStationAllListI;//包含未使用/已经过期  已经过期排最下面
		int maxUserCouponId;
	};
	

	class HomePageAdsOutput{
		ReasonOutput reasonOutputI;
		HomePageAdList homePageAdListI;//首页广告链接
	};
	class OilPrice{
		int oilId;//油品id
		string oilCode;//油品编码
		string reducePrice;//减少价格
	};
	["java:type:java.util.ArrayList"] sequence <OilPrice> OilPriceList;

	
	class QueryMyInfoInput{
		string userId;//用户id
		int privateMessageId;//个人消息id
		int publicMessageId;//公共消息id
	};
	
	class QueryMyInfo0730Input extends QueryMyInfoInput{
		int merchandiseId;//优惠券id
	};
	
	class QueryMyInfo20170408Input extends QueryMyInfoInput{
		int merchandiseId;//优惠券id
		string version;//版本
		
	};
	
	class MyInfo {
		int type;// 1=消息中心 2=加油历史  3=会员卡 4=加油劵 5=优惠劵6=优惠券红点7=邀请话术8=营运车注册  10=“省”展示 11="车队卡余额"
		string value;//可能是值/可能是id
	};
	class MessageInfo extends MyInfo{
		int messageType;//1=易加油消息 2=个人消息
	};
	
	class MyUrlInfo extends MyInfo{
		string url;
	};
	
	
	["java:type:java.util.ArrayList"] sequence <MyInfo> MyInfoList;
	class QueryMyInfoOutput{
		ReasonOutput reasonOutputI;
		MyInfoList myInfoListI; 
	};
	
	["java:type:java.util.ArrayList"] sequence <MyUrlInfo> MyUrlInfoList;
	class QueryMyUrlInfoOutput{
		ReasonOutput reasonOutputI;
		MyUrlInfoList myUrlInfoListI;
	};
	
	
	
	/** 优惠项 */
	class PreferenceItem{
		string title;//标题
		string desc;//描述
	};
	/** 活动项 */
	class ActivityItem {
		string title;//标题
		string desc;//描述
		int type;//活动类型
	};
	["java:type:java.util.ArrayList"] sequence <PreferenceItem> PreferenceItemList;
	["java:type:java.util.ArrayList"] sequence <ActivityItem> ActivityItemList;
	
	class StationDetailInfo{
		int stationId;//油站id
		string picUrl;//图片地址
		string longitude;//经度
		string latitude;//纬度
		string starNum;//星星数
		int evaluateNum;//评价总数
		string stationName;//油站名
		StringList oilCodeList;//油品编码list
		string qrCode;//油站对应二维码
		string stationphone;//联系电话
		string stationAddress;//地址
		bool supportEjy;//是否支持易加油支付
		string stationDesc; //油站简介
		string preferential;//优惠描述
		StringList activityList;//活动描述
		OilPriceList oilPriceListI;//优惠价
	};


	class HomePageStation1207{
		int stationId;//油站id
		string picUrl;//图片地址
		string stationName;//油站名称
		string longitude;//经度 
		string latitude;//纬度
		string stationAddress;//油站地址
		string starNum;//星数 >=1
		string distince;//距离
		bool isSupportEJY;//是否支持易加油 
		bool isDiscount;//是否有折扣
		string discount;//折扣
		
		bool isMaxDiscount;//最优惠//H5x需要元素
		bool isMaxNear;//距离最近
		OilPriceList oilPriceListI;//优惠价
		string cnpcMark;//中石油官方油品保证 
		string mySpecialOffer;//我的特惠
		string lowestEnjoy;//最低享受
		string headDesc;//师傅的选择
		string percent;//80%
		StationDetailInfo stationDetailInfoI;
		
	};
	class HomePageStation0314{
		int stationId;//油站id
		string picUrl;//图片地址
		string stationName;//油站名称
		string longitude;//经度 
		string latitude;//纬度
		string stationAddress;//油站地址
		string starNum;//星数 >=1
		string distince;//距离
		bool isSupportEJY;//是否支持易加油 
		bool isDiscount;//是否有折扣
		string discount;//折扣
		
		bool isMaxDiscount;//最优惠//H5x需要元素
		bool isMaxNear;//距离最近
		OilPriceList oilPriceListI;//优惠价
		string cnpcMark;//中石油官方油品保证 
		string mySpecialOffer;//我的特惠
		string lowestEnjoy;//最低享受
		string headDesc;//师傅的选择
		string percent;//80%
		StationDetailInfo stationDetailInfoI;
		string maxDiscountDesc;//巨惠 -描述
		
	};
	
	["java:type:java.util.ArrayList"] sequence <HomePageStation1207> HomePageStationList1207;
	["java:type:java.util.ArrayList"] sequence <HomePageStation0314> HomePageStationList0314;
	class HomePageStationInfoListOutput1207{
		ReasonOutput reasonOutputI;
		int isVerifyFlag;//用于标记私家车是否在审核中，还是没提交过申请私家车 ==1 正在审核的私家===2  0===营运车
		bool isLastPage;//是否是最后一页
		string discountStr;//优惠0.8元
		HomePageStationList1207 homePageStationListI;
	};
	class HomePageStationInfoListOutput0314{
		ReasonOutput reasonOutputI;
		int isVerifyFlag;//用于标记私家车是否在审核中，还是没提交过申请私家车 ==1 正在审核的私家===2  0===营运车
		bool isLastPage;//是否是最后一页
		string discountStr;//优惠0.8元
		HomePageStationList0314 homePageStationListI;
	};
	class Evaluate{
		int evaluateId;
		string nickName;//昵称
		string proudctName;//商品名
		string orderSum;//订单总额
		string createTime;//评价时间
		int starNum;//星星数
		string content;//内容
	};
	class StationEvaluate extends Evaluate{
		string appendTitle;//追加评价标题
		string appendConent;//追加评价
	};
	
	class EvaluateAndReply extends StationEvaluate{
		int type;//1=评价 2=追加评价 3用户回复 4易加油回复 5 油站回复
	};
	
	
	["java:type:java.util.ArrayList"] sequence <StationEvaluate> StationEvaluateList;
	
	["java:type:java.util.ArrayList"] sequence <EvaluateAndReply> EvaluateAndReplyList;
	
	class Evaluates extends Evaluate{
		EvaluateAndReplyList evaluateAndReplyListI;
	};
	
	["java:type:java.util.ArrayList"] sequence <Evaluates> EvaluatesList;
	
	
	/** 评价标题  */
	class EvaluateTitle{
		string tile;//标题
		int id;//评价id
		int relateId;//互斥评价id
		int type;//1=正面 2=负面
		bool isChoice;//是否选中
	};
	
	
	["java:type:java.util.ArrayList"] sequence <EvaluateTitle> EvaluateTitleList;
	class GetEvaluateOutput{
		ReasonOutput reasonOutputI;
		StringList evaluateTitleList;
		StationEvaluateList stationEvaluateListI;
	};
	
	
	
	class GetEvaluateAndReplyOutput{
		ReasonOutput reasonOutputI;
		StringList evaluateTitleList;
		EvaluatesList evaluatesListI;
	};
	
	class CheckEvaluatTitle{
		int titleId;//标题编号
		string titleName;//标题名称
		string titleAmount;//标题数量
	};	
	
	["java:type:java.util.ArrayList"] sequence <CheckEvaluatTitle> CheckEvaluatTitleList;
	
	class GetEvaluatFilterTitleOutput{
		ReasonOutput reasonOutputI;
		EvaluatesList evaluatesListI;
		CheckEvaluatTitleList checkEvaluatTitleListI;
	};
	
	class GetAppendEvaluateOutput{
		ReasonOutput reasonOutputI;
		StringList AppendConentList;
	};

	class UserOrderInfo0625 {
		string orderId;//订单号
		string payTime;//支付时间
		string stationName;//油站名
		string oilCode;//油品编码
		string oilMass;//油量
		string orderSum;//总金额
		string paySum;//支付金额
		string reduceSum;//优惠金额
		double starNum;//星星数
	 	int evaluateType;// 1=去评价 2=追加评价 3=已评价
	 	int evaluateId;//评价id
	 	int refundStatus;//退款状态
	};
	
	class UserOrderInfo0201 extends UserOrderInfo0625{
		string refundDesc;//等待油站审核中
	 	string phoneSourceName;//电话来源(油站柜台电话/易加油客服电话)
		string phone;//油站柜台电话/易加油客服电话
	};
	

	class UserOrderInfo1209 extends  UserOrderInfo0201{
		string invoiceHead;//发票抬头
		string ejiayouDiscount;//易加油优惠
		string merchandisDiscount;//优惠券优惠
		string stationPicUrl;//油站缩略图
	};
	
	["java:type:java.util.ArrayList"] sequence <UserOrderInfo0625> UserOrderInfo0625List;
	class GetUserOrder0625Output{
		ReasonOutput reasonOutputI;
		UserOrderInfo0625List userOrderInfo0625ListI;
	};

	
	
	["java:type:java.util.ArrayList"] sequence <UserOrderInfo0201> UserOrderInfo0201List;
	class GetUserOrder0201Output{
		ReasonOutput reasonOutputI;
		UserOrderInfo0201List userOrderInfo0201ListI;
	};
	
	class GetUserOrder1209Output{
		ReasonOutput reasonOutputI;
		UserOrderInfo1209 userOrderInfo1209I;
	};
	
		/** 评价/追加 提交 */
	class EvaluateInput{
		string orderId;//订单id
		int starNum;//星星数
		string content;//评价/追加内容
		StringList titleIdListI;
		int type;//1=评价 2=追加
	};
	class EvaluateInfo{
		string orderId;
		int type;//1=评价 2=追加评价
		string stationName;//油站名
		string oilCode;//商品名
		string oilMass;//升数
		string orderSum;//订单金额
		string paySum;//支付金额
		string reduceSum;//优惠金额
		int starNum;//星星数量
		string content;//评价内容
		string showAppendConent;//回显追加评价内容
		EvaluateTitleList evaluateTitleListI;//所有标题
	};
	class GetEvaluateInfoBeforeOutput{
		ReasonOutput reasonOutputI;
		EvaluateInfo evaluateInfoI;
	};
	
	
	class EvaluateInfo0729 extends EvaluateInfo{
		EvaluateAndReplyList evaluateAndReplyListI;
	};
	
	class GetEvaluateInfoBefore0729Output{
		ReasonOutput reasonOutputI;
		EvaluateInfo0729 evaluateInfo0729I;
	};
	
	
	

	
	class DicountCoupon{
		 string dicount;
		 string maxDiscountPrice;
	     int userCouponId;
	};
	
	
	class SpecialIdentity{
		int  carType;//车类型
		int userId;//用户编号
		int formSoure;//用户来源
		string realName;//用户真实 姓名
		string carNumber;//车牌号码
		string userHeadImage;//用户
	};
	
	class SpecialIdentity0822{
		int  carTabCode;//前端车标签分类 1=滴滴 2=优步  3=易道 4=神州
		int  carType;//车类型
		int userId;//用户编号
		int formSoure;//用户来源
		string realName;//用户真实 姓名
		string carNumber;//车牌号码
		string userHeadImage;//用户
	};
	
	class ApplySpecialIdentityOutput{
		ReasonOutput reasonOutputI;
		string value;
	};
	
	
	
	class UserIdTypeOutput{
		ReasonOutput reasonOutputI;
		int carType;//1私家车 2 出租车 3 货车
	};
	
	
	
	class BasicInfo{
		int osType;
		int userId;
	}; 
	
	
	class BasicInfov2 extends BasicInfo{
		  string versionId;//版本号
		  int idType;//车类型
	};
	
	
	class InviteAward{
		string userPhone;//电话号码
		int carType;//车类型
		int status;//被邀请用户使用状态
		string desc;//描述
	};
	
	class InviteAwardAndLimit extends InviteAward{
		string headImg;//用户头像
		string nickName;//微信名称
	};
	["java:type:java.util.ArrayList"] sequence <InviteAward> InviteAwardList;
	
	["java:type:java.util.ArrayList"] sequence <InviteAwardAndLimit> InviteAwardAndLimtList;
	
	class InviteFriendOut {
		ReasonOutput reasonOutputI;
		string InviteAwardValue;//邀请奖励金额
		string title;//标题
		string content;//内容
		string couponValue;//优惠券金额
		string shareUrl;//分享链接
		string shareTitle;//分享标题
		string shareContent;//分享内容
		string shareImage;//分享缩略图
		StringList 	inviteRuleListI;//邀请规则	
		InviteAwardList InviteAwardListI;//邀请奖励信息
	};
	
	
	class InviteFriendAndLimitOut extends InviteFriendOut{
	    InviteAwardAndLimtList inviteAwardListAndLimitI;//邀请奖励信息
	};
	class InviteFriendAndQqLimitOut{
		ReasonOutput reasonOutputI;
		string InviteAwardValue;//邀请奖励金额
		string title;//标题
		string content;//内容
		string couponValue;//优惠券金额
		StringList 	inviteRuleListI;//邀请规则	
	  	string shareQqUrl;//QQ分享链接
		string shareQqTitle;//QQ分享标题
		string shareQqContent;//QQ分享内容
		string shareQqImage;//QQ分享缩略图
		string shareWxUrl;//分享链接
		string shareWxTitle;//分享标题
		string shareWxContent;//分享内容
		string shareWxImage;//分享缩略图
		InviteAwardAndLimtList inviteAwardListAndLimitI;//邀请奖励信息
	};
	
	
	class InviteFriendAndAccumulationOut{
		ReasonOutput reasonOutputI;
		string InviteAwardValue;//邀请奖励金额
		string title;//标题
		string content;//内容
		string couponValue;//优惠券金额
		StringList 	inviteRuleListI;//邀请规则	
	  	string shareQqUrl;//QQ分享链接
		string shareQqTitle;//QQ分享标题
		string shareQqContent;//QQ分享内容
		string shareQqImage;//QQ分享缩略图
		string shareWxUrl;//分享链接
		string shareWxTitle;//分享标题
		string shareWxContent;//分享内容
		string shareWxImage;//分享缩略图
		InviteAwardAndLimtList inviteAwardListAndLimitI;//邀请奖励信息
		int activityInviteCount;//活动邀请人数
		string  inviteAwardPrice;//邀请奖励金额（金额）
		string hadActivityAwardPrice;//累加活动获得金额
		string nextActivityAwardPrice;//下一阶段活动奖励金额
	};
	
	
	
	dictionary<string, string> ChannelConfigure;//邀请活动配置信息map（key-value）
	class InviteCodeOut{//邀请活动返回活动配置信息
		ReasonOutput reasonOutputI;
		ChannelConfigure channelConfigureMap;
	};
	
	
	class ExchangeInviteCodeOut{
	   ReasonOutput reasonOutputI;
	   string value;
	};
	
	class GetOilGun0229OutPut{
		int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0229Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		CashBackRuleSeq cashBackRuleSeqI;
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyGrouponAndPackInfoList grouponInfoListI;//用户拥有的团购卷
		MyCouponInfoList couponInfoListI;//用户拥有的优惠卷
		StationProjectList stationProjectListI;	//油站支持项目（如抽奖、充值、兑换积分）
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		DicountCoupon dicountCouponI;
	};
	
	class GetOilGun0322OutPut{
		int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0229Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		CashBackRuleSeq cashBackRuleSeqI;
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyGrouponAndPackInfoList grouponInfoListI;//用户拥有的团购卷
		MyCouponInfo0322List couponInfoListI0322;//用户拥有的优惠卷
		StationProjectList stationProjectListI;	//油站支持项目（如抽奖、充值、兑换积分）
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		DicountCoupon dicountCouponI;
	};
	
	class MyCouponInfoToPay{
		string color;//优惠券底色
		string limitExplain;//通用优惠券，或者限制使用油站
		CouponRuleList couponRuleListI;//不与任何优惠叠加，满100元可用
		int couponType;//1满减金额券  2折扣券
		string userCouponId;//用户拥有的优惠券id
		string limitTime;//有效日期
		string value;//面值
		string limitMoney;//限制金额
		bool addOnEjiayou;  //1表示 能叠加    0 表示不能叠加
	};
	
	class MyCouponInfoToPay201611{
		string name;//通用优惠券
		string color;//优惠券底色
		string limitTime;//有效期
		int couponType;//1现金券  2折扣券
		string userCouponId;//优惠券id
		string value;//面值
		string limitMoney;//限制金额
		string limitText;//限制说明,满200元可用，不与任何优惠叠加，限专车/快车、易到使用等
		string limitStationText;//限制油站说明,全部油站可用
		bool addOnEjiayou;  //true表示 能叠加    false 表示不能叠加
	};	
	
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoToPay> MyCouponInfoToPayList;
	["java:type:java.util.ArrayList"] sequence <MyCouponInfoToPay201611> MyCouponInfoToPayList201611;
	
	class GetOilGun0622OutPut{
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
	};
	
	class GetOilGun20161201OutPut{
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
		
		string discountLabel; // 展示文案
	};
	
	dictionary<string, string> contentMap;
	class AdverDialogKeyWord {
		string keyWord;
		string color;
	};
	
	["java:type:java.util.ArrayList"]  sequence<AdverDialogKeyWord> keyWordList;
	class AdvertDialog {
		string title; // 广告名称
		contentMap content; // 弹框内容
		keyWordList keyWords; // 关键字及显示颜色
		string img; // 图片
	};
	
	class GetOilGun20161216OutPut{
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
		
		string discountLabel; // 展示文案
		AdvertDialog stationAdverDialog; // 油站广告
		AdvertDialog payAdverDialog; // 支付广告
	};
	
	class GetOilGun20170109OutPut {
	
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
		
		string discountLabel; // 展示文案
		AdvertDialog stationAdverDialog; // 油站广告
		AdvertDialog payAdverDialog; // 支付广告
	
		int payFleet; // 是否支持车队卡 1= 可见， 2 = 不可见， 3 = 可见不可用
		string fleetPayDescription; // 描述
		string fleetBalance; // 车队卡余额
		
		int payPerson; // 是否个人支付，1= 可见， 2 = 不可见， 3 = 可见不可用
		string personPayDescription; // 描述
		string personBalance; // 车队卡余额
	};
	
	class GetOilGun20170214OutPut {
	
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		
		string discountLabel; // 展示文案
		AdvertDialog stationAdverDialog; // 油站广告
		AdvertDialog payAdverDialog; // 支付广告
		
		int isNeedPrintInvoice; // 是否需要打印发票 0 == 否, 1 == 是
	};
	
	class GetOilGun201611OutPut{
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
	};
	
	class GetOilGun0820OutPut{
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil0622Seq oilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
	};
	
	class GetOilGun20170227OutPut {
	    int userType;//2=出租车 3=小货车 4=车队
		bool isNeedPrompt;//是否需要提示
		string promptContent;//提示内容
		bool isNeedLogin;//是否需要登录
		bool isNeedAlertNotife;//是否需要弹出告知
		string alertNotifeContent;//提示告知内容
		bool isNeedAlertDiscount;//是否需要弹出优惠框
		string alertPlatformName;//第三平台名称
		string discountPrice;//折扣金额
		ReasonOutput reasonOutputI;
  		string price;	//油的原价
		string oilName;	//油品名
		string oilId;	//油id 1=92 2=95 3=0 4=98
		Activity1207 activityI;	//活动id
		OilGunAndOil20170227Seq nOilGunAndOils;
		string fillingStationName;
		string fillingStationAddress;
		string fillingLongitude;//经度
		string fillingLatitude;//纬度
		int stationId;//油站Id
		bool isPassUserLimitCount;//是否通过 用户每天次数限制 
		bool isVip;//是否是VIP
		string vipWelcome;//欢迎语句
		string pointMoney;//积分可抵扣的金额
		bool isSupportPointMoney;//是否支持积分抵扣钱
		int points;//剩余总积分
		string userBalance;//用户余额
		MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
		int limitMoney;//半价限制最高支付金额
		string limitTitle;//限制半价活动弹框标题
		string limitDesc;//半价限制活动弹框描述
		int isHalf;//1=有半价活动但是享受了半价2=有半价活动但是没有享受半价0=没有半价这个活动
		string oilstr;//拼接享受半价的油品，前台所选油品包含了就需要弹框=1,2
		string stationPicUrl;
		bool isHadInvoice;//是否可以享受优惠
		bool payALi;//是否支持支付宝支付
		bool payWeiXin;//是否支持微信支付
		string commonCountMoneyJs;//计算金额JS字符串
		string oilgunPanelStationPic;//油站页面油站图片
		string confirmPayPanelStationPic;//确认支付页面油站图片
		
		string discountLabel; // 展示文案
		AdvertDialog stationAdverDialog; // 油站广告
		AdvertDialog payAdverDialog; // 支付广告
		
		int isNeedPrintInvoice; // 是否需要打印发票 0 == 否, 1 == 是
		string pointsJson; // 积分字段
	};

	class ShopGoods{
		int goodsId;//商品编号
		string goodsName;//商品名字
		string originalPrice;//原价
		string preferentialPrice;//优惠价
		string goodsUrl;//商品图片路径 
	};
	
	["java:type:java.util.ArrayList"] sequence <ShopGoods> ShopGoodsList;
	
	
	class ShopGoodsOut{
		ReasonOutput reasonOutputI;
		ShopGoodsList shopGoodsListI;//商品对象
	};
	
	class PaySuccessActivityPathOut{
		ReasonOutput reasonOutputI;
		string path;//活动请求路径
	};
	// H5页面
	class StationEntity{
		int stationId;//油站id
		string picUrl;//图片地址
		string stationName;//油站名称
		string longitude;//经度 
		string latitude;//纬度
		string stationAddress;//油站地址
		string starNum;//星数 >=1
		string distince;//距离
		bool isSupportEJY;//是否支持易加油 
		bool isMaxDiscount;//最优惠
		bool isMaxNear;//距离最近
		OilPriceList oilPriceListI;//优惠价
		string cnpcMark;//中石油官方油品保证 
		string mySpecialOffer;//我的特惠
		string lowestEnjoy;//最低享受
		string headDesc;//师傅的选择
		string percent;//80%
	};
	["java:type:java.util.ArrayList"] sequence <StationEntity> StationList;
	class StationInfoListOutput{
		ReasonOutput reasonOutputI;
		string headImage;
		string partnerName;
		StationList stationListI;
	};
	class LoginOutPutSupportThirdPlatfrom{
		ReasonOutput reasonOutputI;
		string userId;
		bool isNormalUser;//false的时候不支持
	};
	
	class MonthlyOrderActivityInfoOutput{
		ReasonOutput reasonOutputI;
		string title;//活动标题
		string desc;//活动描述
		string rule;//活动规则
		int joinCount;//用户参加次数
		string limitDate;//活动结算说明
		string userInfo;//活动活动信息
	};
	class PayOverCommercialsOutput{
		ReasonOutput reasonOutputI;
		string shareOverPic;//isShare==1如果支持分享那么有值，isShare==0没有内容
		string commercialsPic;//广告主图
		int isShare;//是否分享1=出现分享按钮0不出现分享按钮
		string shareTitle;
		string shareDesc;
		string shareIco;
		string shareUrl;
		int type;//1==图片2==连接
	};
	class PayOverCommercialstV2Output{
		ReasonOutput reasonOutputI;
		string shareOverPic;//isShare==1如果支持分享那么有值，isShare==0没有内容
		string commercialsPic;//广告主图
		int isShare;//是否分享1=出现分享按钮0不出现分享按钮
		string shareTitle;
		string shareDesc;
		string shareIco;
		string shareUrl;
		int type;//1==图片2==连接
		string commercialsPicUrl;//广告主图URL
	};
	class HomeQuickStation{
		int stationId;//油站id
		string picUrl;//图片地址
		string stationName;//油站名称
		string longitude;//经度 
		string latitude;//纬度
		string stationAddress;//油站地址
		string distince;//距离
		string qrCode;//扫码
		string townsName;//地区名字
	};
	["java:type:java.util.ArrayList"] sequence <HomeQuickStation> HomeQuickStationList;
	class HomeQuickStationListOutput{
		ReasonOutput reasonOutputI;
		HomeQuickStationList homeQuickStationListI;
	};
	class HomeQuickStationV2{
		int stationId;//油站id
		string picUrl;//要暂时两个图片地址
		string scanStationPic;//单个图片展示的时候用这个
		string stationName;//油站名称
		string longitude;//经度 
		string latitude;//纬度
		string stationAddress;//油站地址
		string distince;//距离
		string qrCode;//扫码
		string townsName;//地区名字
	};
	["java:type:java.util.ArrayList"] sequence <HomeQuickStationV2> HomeQuickStationListV2;
	class HomeQuickStationV2ListOutput {
		bool isShowDoubleStation;//false的时候不显示
		ReasonOutput reasonOutputI;
		HomeQuickStationListV2 homeQuickStationListI;
	};
	class HomeCouponStationListOutput{
		ReasonOutput reasonOutputI;
		string couponDesc;//支持券的描述信息
		HomeQuickStationList homeQuickStationListI;
	};
	
	
	/**油站列表*/
	class StationList0312{
		string title;
		HomePageStationList1207 homePageStationListI;
	};
	
	["java:type:java.util.ArrayList"] sequence <StationList0312> StationLists0312;
	
	/**油站列表返回值*/
	class StationInfoListOutput0312{
		ReasonOutput reasonOutputI;
		StationLists0312 lists;
	};
	

	class CheckSmsCode0405{
		ReasonOutput rOut;
		int userId;
		int idType;
		bool isNew;//true=新用户
		bool isGrey;
	};
	
	class GetUserInfoOutput0405{
		UserInfo1207 UserInfoI;
		ReasonOutput reasonOutputI;
		int   state;  //跳转页面的状态 1 = 我的身份（身份选择） 2=第三方平台  3 = 我的身份审核中的状态
		//以下字段为state为2的时候用到
		string titleInfos; //货拉拉 快狗
		IndentShowInfoSeq1207 indentShowInfoSeq;
		bool isGrey;
	};
	
	class GetUserInfoOutput20170113{
		UserInfo1207 UserInfoI;
		ReasonOutput reasonOutputI;
		int   state;  //跳转页面的状态 1 = 我的身份（身份选择） 2=第三方平台  3 = 我的身份审核中的状态
		//以下字段为state为2的时候用到
		string titleInfos; //货拉拉 快狗
		IndentShowInfoSeq1207 indentShowInfoSeq;
		int hadCertification; // 是否实名认证: 1 = 已实名，0 = 未实名
		string name; // 用户名字
		string idCardNo; // 身份证
		bool isGrey;
	};
	//返回新增的头像
	class GetUserInfoOutput20170421{
		UserInfo20170421 UserInfoI;
		ReasonOutput reasonOutputI;
		int   state;  //跳转页面的状态 1 = 我的身份（身份选择） 2=第三方平台  3 = 我的身份审核中的状态
		//以下字段为state为2的时候用到
		string titleInfos; //货拉拉 快狗
		IndentShowInfoSeq1207 indentShowInfoSeq;
		int hadCertification; // 是否实名认证: 1 = 已实名，0 = 未实名
		string name; // 用户名字
		string idCardNo; // 身份证
		bool isGrey;
	};


	class RegisterUserWithCarNumberOutput extends RegisterUserOutput{
		int idType;//车辆类型
		bool isExists;//车牌号是否存在 
		string waringInfo;// 提示信息
	};
	
	class HistoryOrderInfo {
		string orderId;
		string stationName; // 油站名称
		string stationPic; // 油站图片
		string payTime; // 支付时间
		string orderSum; // 实付金额
		string reduceSum; // 优惠金额
		int orderState; // 订单状态，1为待评价，2为已完成，3为退款中，4已退款
		float star; // 评分值
		int hasStationPhone;  // 是否有油站联系方式
		string stationPhone; // 油站联系方式
	};
	
	["java:type:java.util.ArrayList"] sequence <HistoryOrderInfo> historyOrderInfos;
	class UserHistoryOrder {
		string consumeTimes; // 消费次数
		string allPaySum; // 共支付
		string saveMoney; // 共节省
		historyOrderInfos orderList;
		int orderQuantity; // 订单数
		int currentPageNum; // 当前页
		int allPageNum; // 总页数
		ReasonOutput reasonOutputI;
	};

    class UserHistoryOrder20170405 extends UserHistoryOrder {
        string joinEjiayouDay; // 加入易加油天数
        string headUrl; // 微信头像
        string nickName; // 微信昵称
        string centerPicUrl; // 中心图片地址
        string globalPicUrl; // 整图模块地址
    };
	
	class RefundTimeOut{
		int timeOutState; //是否超时 0是不能退款，1是还能退款
		string headDes; //头部信息
		string tailDes; //底部信息
		string phone; //客服电话
		ReasonOutput reasonOutputI;
	};
	
	
	
	class RechargeOrderOutput{
		ReasonOutput reasonOutputI;
		string orderSign;//订单号
		WXPayReqOutput wxPayReqOutputI;
		string wxWebPayLastMoney;//微信端发起支付的用的钱
		string  aliOrderData;
	};
	class PayFleetOrderInfo {
		string orderId; // 订单号
		bool isPaySuccess; // 是否支付成功
		string showMsg; // 支付消息，支付失败时，弹这个消息
		ReasonOutput resonOutPut;
		
	};
	class PayFleetOrderInfo20170215 {
		string orderId; // 订单号
		bool isPaySuccess; // 是否支付成功
		string showMsg; // 支付消息，支付失败时，弹这个消息
		int frozeState; // 冻结状态，0==未冻结，1==已冻结
		ReasonOutput resonOutPut;
	};
	
	class PersonBalanceInfo {
		int hadCertification; // 是否实名认证: 1 = 已实名，0 = 未实名
		string balance; // 余额
		int hadPwd; // 是否有支付密码：1 = 存在， 0 = 未设置
		string rate; // 比率
		StringList defualtRechangeList;
		ReasonOutput resonOutPut;
	};
	
	class UserBalanceRecord {
		string desc; // 出入账描述
		string value; // 值，自带加减号
		string time; // 创建时间
	};
	
	["java:type:java.util.ArrayList"] sequence <UserBalanceRecord> UserBalanceRecordI;
	
	class UserBalanceRecords {
		ReasonOutput resonOutPut;
		int pageSize;
		int currentPageNum;
		UserBalanceRecordI userBalanceRecordList;
	};
	
	class IdentityAuditState {
		int state; // 1 存在审核数据，0 不存在在审数据
		ReasonOutput resonOutPut;
	};
	
	class UserPaymentState {
		string userId;
		int hadCertification; // 是否实名认证: 1 = 已实名，0 = 未实名
		int hadPwd; // 是否有支付密码：1 = 存在， 0 = 未设置
		ReasonOutput resonOutPut;
	};
	
	class AppPaymentState {
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
		
		int payFleet; // 是否支持车队卡 1= 可见， 2 = 不可见， 3 = 可见不可用
		string fleetPayDescription; // 描述
		string fleetBalance; // 车队卡余额
		
		int payPerson; // 是否个人支付，1= 可见， 2 = 不可见， 3 = 可见不可用
		string personPayDescription; // 描述
		string personBalance; // 车队卡余额
		ReasonOutput resonOutPut;
	};
	
	class AppPaymentInputVo {
		int stationId; // 油站id
		int oilgunId; // 油枪号
		int oilId; // 油品
		string originalCost; // 用户输入的金额
		int useCouponId; // 使用优惠券的id，不使用为0 
		string userPhoneSerial;
		int carType;
	};
	
	class AppPaymentState20170227 {
		int aliState; // 阿里支付状态
		int wxState; // 微信支付状态
		int defaultPayType; // 默认支付类型 
		
		int payFleet; // 是否支持车队卡 1= 可见， 2 = 不可见， 3 = 可见不可用
		string fleetPayDescription; // 描述
		string fleetBalance; // 车队卡余额
		
		int payPerson; // 是否个人支付，1= 可见， 2 = 不可见， 3 = 可见不可用
		string personPayDescription; // 描述
		string personBalance; // 车队卡余额
		ReasonOutput resonOutPut;
		
		int eCardState;
		string eCardPayDescription; // 描述
		string eCardBalance; // ecard余额
		
		string defualtPayAmount; // 默认待支付金额
		string fleetPayAmount; // 车队卡待支付金额
		string payPersonAmount; // 个人储值卡待支付金额
		string eCardPayAmount; // eCard待支付金额
		
		string personPayNoticeMsg; // 个人储值卡支付提醒
		string personPayNoticeKey; // 个人储值卡支付提醒关键字
	};

    class AppPaymentState20170503 extends AppPaymentState20170227 {
        int cqPersonPay; // 重庆油卡
        string cqPersonPayDescrtipion; // 重庆油卡描述
        string cqPersonPayAmount; // 重庆山城油卡待支付金额
        string cqPersonPayBalance; // 重庆山城油卡余额
    };

	/** 2017-03-16 扫码 start **/
	class ScanCodeVo {
		string qrCode;
		string longitude;
		string latitude;
		string fromSource;
		string userPhoneSerial;
	};
	struct Activity20170316{
        string activityPrice;//活动价格
        int carType;
    };
    
    struct OilGunAndOil20170316 {
        int oilgunId;
        string oilgunCode;
        string price;	//油的原价
        string oilName;	//92#
        string oilCode;//汽油
        string oilId;	//油id
        Activity20170316 activityI;	//活动id
        string countryPrice;//国家挂牌家
        int payType; // 支付类型
        string balance; // 余额，为储值卡时有值，否则为零
    };
    sequence<OilGunAndOil20170316> OilGunAndOil20170316Seq;
	class GetOilGun20170316OutPut {
        bool isNeedPrompt;//是否需要提示
        string promptContent;//提示内容
        ReasonOutput reasonOutputI;
        OilGunAndOil20170316Seq nOilGunAndOils;
        string fillingStationName;
        int stationId;//油站Id
        bool isNotDiscount;//否为没有优惠，true为没有优惠，false为有优惠
        MyCouponInfoToPayList201611 couponInfoToPayListI;//用户拥有的优惠卷
        string stationPicUrl;
        string commonCountMoneyJs;//计算金额JS字符串
        string oilgunPanelStationPic;//油站页面油站图片
        string confirmPayPanelStationPic;//确认支付页面油站图片

        string discountLabel; // 展示文案
        AdvertDialog stationAdverDialog; // 油站广告
        AdvertDialog payAdverDialog; // 支付广告

        int isNeedPrintInvoice; // 是否需要打印发票 0 == 否, 1 == 是
        string pointsJson; // 积分字段
    };	
	/** 2017-03-16 扫码 end **/

	/** 2017-03-30 扫码 start **/
    class GetOilGun20170330OutPut extends GetOilGun20170316OutPut{
        string maxOrderSum; // 最大输入金额
        string minOrderSum; // 最小输入金额
    };
	/** 2017-03-30 扫码end **/

    /** 2017-04-21 扫码 start **/
    class WechatOutPut {
        string alertPlatformName;
        bool isNeedAlertDiscount;

        string alertNotifeContent;
        bool isNeedAlertNotife;

        bool payWeiXin;
        bool isNeedLogin;
    };
    class GetOilGun20170421OutPut extends GetOilGun20170330OutPut {
        int isFleetUser; // 是否为车队用户， 0为否，1为是
        WechatOutPut wechatVo;
    };
    /** 2017-04-21 扫码 end **/

    /** 2017-05-03 扫码 start**/
    class PaymentSelectEntity {
        int payTypeId; // 支付类型id
        string balance; // 余额
        string name; // 支付类型名称
        int state; // 支付状态是否可用
    };
    sequence<PaymentSelectEntity> PaymentSelectSeq;

    class PaymentSelectDialog {
        bool isShowDialog; // 是否展示选择支付类型
        string title; // 标题
        string notice; // 提示信息
        PaymentSelectSeq paymentSelectList; // 支付类型数组
    };

    class GetOilGun20170503OutPut extends GetOilGun20170330OutPut {
         PaymentSelectDialog paySelectDialog;
         WechatOutPut wechatVo;
    };
    /** 2017-05-03 扫码 start**/

	/** 2017-03-17 创建订单接口 start **/
	class OrderCreatedParamVo {
		string payType;//1==微信客服端支付 8==微信wap支付 2==支付宝支付
		string productType;//商品类型1==加油2==团购卷---0622没有使用预留字段	
		bool hadInvoice;//是否有抬头	
		string invoiceHead;//发票抬头
		string fillingStationId;
		string oilgunId;//油枪id
		string oilId;		//油的id
		string orderSum;//订单金额
		string originalCost;//用户输入金额
		string userCouponId;//使用优惠劵id
		string createOrderCarType;//下单时候记录该单享受的什么车身份
		string userPhoneSerial; // 手机序列号
	};
	/** 2017-03-17 创建订单接口 start **/
	
	interface Yijiayouinterface{
		
		//改订单支付状态
		ReasonOutput	updateOrderStatus(string orderSign,int orderType);
	
		//编辑个人信息
		ReasonOutput updateUserInfo(SetUserInfo setUserInfoI);
		
		//获取用户个人信息
		GetUserInfoOutput getUserInfo(int userId);
	

		//用户建议反馈
		ReasonOutput userSuggestion(UserSuggestionInput userSuggestionInputI);
		//115问题反馈<返回list>
		UserSuggestionReplyOutput userSuggestionReply(int userAccount);

		//获得最新的版本 mobileType 1==ios 2==安卓
		GetNewVersionOutput	GetNewVersion(int mobileType);
	
		
		//返回支持支付的方式
		GetPayStatesOutput getPayState();
		
		//更新用户 极光推送相关信息
		ReasonOutput updateJPOfUser(string userId,string jpushTag,string jpushAlias,string jpushRegistrationId);
		
		//返回订单状态
		GetOrderStatusOutput getOrederStatus(string orderId);
		
		//获取用户可退款订单
		GetUserOrderInfoOutput getUserRefundableOrder(int userId);
		
		//创建订单退款申请
		ReasonOutput CreateRefundApply(string orderId,string reason);
		
		//返回订单打印状态
		GetOrderPrinterStatusOutput getOrederPrinterStatus(string orderId);
		
		
	
		//20141016 返回添加原价
		GetUserOrderInfoOutput1016 getUserOrder1016(int userId,long orderId);

		//获取油站退款订单 type(0、所有订单 1、待处理订单2、已经处理过的订单) 
		GetStationRefundableOrderOutput getStationRefundableOrder(int stationId,int type);


		// 订单补加发票抬头,用户添加默认发票抬头
		ReasonOutput addInvoiceForUserOrder(string orderId,string invoice);
		
		//获取订单接口
		GetUserOrderInfoOutputV117 getUserOrderV1117(string userId,long orderId);
		
		/** 会员卡和异常信息开始 */
	
		//异常扫码查询更多
		QueryOrderPayInfoMoreOut queryOrderPayInfoMore(string userId);
		//短信验证码发送接口
		SendVerificationCodeOut   sendVerificationCode(string phoneNum);
		//补单小票
		ReasonOutput clientSupplementSingle(string orderId,int type);
		/** 会员卡和异常信息结束 */
	
	
		//用户注册接口
		CreateUserIdOutput0120 createUser0120(CreateUserInput0120 createUserInputI);
		//获取活动消息(page传0获取50条最新数据;platform 平台类型 1、IOS 2、android 3、微信公众号 )
		QueryActivityMessageOutPut queryActivityMessage(int page,int platform);
		
	
	
		
		/** 客服端支付成功时间 */
		ReasonOutput insertPaySuccessTime(string orderId,long time);

	
		/** 用户加油历史扩展返回优惠劵 抵扣积分 余额 */
		GetUserOrderInfoOutput0217 getUserOrder0217(int userId,long orderId);
		/** 异常扫码扩展返回优惠劵 抵扣积分 余额 */
		QueryOrderPayInfoMore0217OutPut  queryOrderPayInfoMore0217(string userId);
		/** 异常扫码扩展返回优惠劵 抵扣积分 余额 */
		GetUserOrderInfoOutput0217 getUserRefundableOrder0217(int userId);
	
		/** 用户手机号登录 */
		LoginOutPut loginByUserPhone(string userIdIn,string userPhoneIn,string verifyNumber,bool isUser);
		/** 油站支持的项目(抽奖,兑换积分,充值) */
		QueryStationSupportProjectOutPut queryStationSupportProject(string stationId);
		/** 查询用户剩余积分 */
		QueryUserPointsOutPut queryUserPoints(string stationId,string userId);
		/** 验证验证码并扣除积分 */
		ReasonOutput mainServerDeductPointsOpt(string deuctPoints,string userId,string vipId,string stationId,string groupId,string verify);
		/** 注册用户(只有本地没有userId的情况才调用) userPhoneSerial:android-设备号,ios-token */
		RegisterUserOutput registerUser(string userPhoneSerial,int osType);
		/** 更换用户绑定手机号 */		
		//ChangeUserBindingPhoneOutput changeUserBindingPhone(string userId,string oldPhone,string newPhone,string newPhoneVerifyNumber);
		
		//获取油站详细信息(团购券列表添加发放时间)
		StationDetailAndTimeOutPut queryStationDetailAndTimeInfo(int stationId, int userId);
		
		
		/** 查询用户个人相关的基础信息 */
		UserInfoOutput queryUserInfo(string userId);
		
		/** 查询用户支付成功订单红包 */
	  	RedEnvelopeOutPut getRedEnvelope(string orderId);
		/** 注册新用户送优惠劵  */
		RegisterUserSendOutput registerUserSend(string userPhoneSerial,int osType);
		/** 获取新用户赠送优惠劵 */	  
	  	ReasonOutput getNewUserSendGroupon(int couponId,string userId);
	  	
	  
		ReasonOutput refundByGrouponAndPack(string userGrouponOrderId,int grouponTyep);
	
		
		
		//获取活动消息(page传0获取50条最新数据;platform 平台类型 1、IOS 2、android 3、微信公众号 )
		QueryActivityMessageAndUserOutPut queryActivityMessageAndUser(int page,int platform,string userId);
		/** ice 拆红包接口/分享成功通知接口 userRedEnvelopeId:用户创建红包id */
		GetMyRedEnvelopesOutput getMyRedEnvelopes(string userRedEnvelopeId);
	
		/** 个人消息,优化红包 返回个性化展示和分享信息 */
	  	RedEnvelope0525Output getRedEnvelope0525(string orderId);
  		/** 个人消息,优化红包 返回个性化展示和分享信息 */
		GetMyRedEnvelopes0525Output getMyRedEnvelopes0525(string userRedEnvelopeId);
	  	/** 消息中心返回包含优化红红包*/
		QueryActivityMessage0525Output queryActivityMessage0525(int page,int platform,string userId);
		
		/** 我的优惠劵 type: 2=未使用 1=已使用  nextPage:下页页数 */
		QueryMyCouponOutput queryMyCoupon(string userId,int type,int nextPage);

		/** 我的优惠劵 type: 2=未使用 1=已使用  nextPage:下页页数 ----  包含新增非油品奖品*/
		QueryMyCouponOutput0618 queryMyCoupon0618(string userId,int type,int nextPage);
		/** 提交抽奖结果(prizeType =1 正常支付抽优惠券  prizeType =3抽非油品 ,userId用户Id , batch=批次，isBigPrize==控制抽大奖true) ---包含新增非油品奖品修改状态 */
		ReasonOutput submitLotteryActivity0618(string orderId,int prizeId,int actityType,int userId,int batch,bool isBigPrize,int prizeType);
		
		//暂不使用
		/** 获取查看追加评价 evaluateId=评价id */
		GetAppendEvaluateOutput getAppendEvaluate(int evaluateId,int nextPage);
		
	
		/** 我相关的信息查看/红点 */
		QueryMyInfoOutput queryMyInfo(QueryMyInfoInput queryMyInfoInputI);
		
	
		/** 获取油站评价/筛选  */
		GetEvaluateOutput getEvaluate(int stationId,int nextPage);
		
		/** 添加/追加 评价执之前查询  evaluateId=评价订单id  type=1.添加/2.追加/3.已评价回显 */
		GetEvaluateInfoBeforeOutput getEvaluateInfoBefore(string orderId,int type);		
		/** 提交/追加评价内容  */
		ReasonOutput insertEvaluate(EvaluateInput evaluateInputI);
		
		
		// 2015-06-23 首页/评价 修改 ------>结束------------------------------------
		
		
		
		//用户登录与注册
		RegisterOrLoginOutput loginOrRegisterUserSend(string userPhoneSerial,int osType,int userId,string jpushId,string userPhoneIn,string verifyNumber,int idType);
		
		//获取用户个人信息
		GetUserInfoOutput0707 getUserInfo0707(int userId);
		
		
		//获取用户当前身份类型（以支付享受为准）
		UserIdTypeOutput getUserIdType(int userId); 
		
		
		/**评价功能添加用户、商户回复功能(开始4.1.0)*/
		/** 获取油站评价  */
		GetEvaluateAndReplyOutput getEvaluateAndReply(int stationId,int nextPage,BasicInfov2 basicInfoIn);
		/** 添加/追加 评价执之前查询  evaluateId=评价订单id  type=1.添加/2.追加/3.用户回复4.已评价回显. */
		GetEvaluateInfoBefore0729Output getEvaluateInfoBefore0729(string orderId,int type,BasicInfov2 basicInfoIn);		
		/** 我相关的信息查看/红点 (增加优惠券红点设置)返回增加type=6(返回优惠券未读张数大于0则显示红点) type=7(好友邀请title)*/
		QueryMyInfoOutput queryMyInfo0730(QueryMyInfo0730Input queryMyInfoInputI);
		/** 好友邀请  */
		InviteFriendOut inviteFriend(BasicInfov2 basicInfoIn);

		/**评价功能添加用户、商户回复功能(结束4.1.0)*/
		
		
		/**邀请码换取优惠券功能（开始）*/
		 InviteCodeOut validateInviteCode(string inviteCode,int channel,BasicInfov2 basicInfoIn);
	  	 ExchangeInviteCodeOut exchangeInviteCode(string inviteCode,int channel,string userPhone,string identifyingCode,BasicInfov2 basicInfoIn);
		/**邀请码换取优惠券功能（结束）*/
		
		
		/**(开始4.2.2)*/
		/** 好友邀请 (增加活动领取金额上限) */
		InviteFriendAndLimitOut inviteFriendAddLimit(BasicInfov2 basicInfoIn);
		/** 轮播图（增加版本控制） */
		HomePageAdsOutput homePageAdsByVersion(BasicInfov2 basicInfoIn);
		/** 获取非油商品 */
		ShopGoodsOut getShopGoodsByStaionId(BasicInfov2 basicInfoIn,int stationId);
		
		/**(开始4.2.3)*/
		/** 消息中心增加版本控制*/
		QueryActivityMessage0525Output queryActivityMessageByClientType(int page,int platform,string userId,BasicInfov2 basicInfoIn);
		/** 获取油站评价  (增加标签选取) title=-1(代表全部)*/
		GetEvaluatFilterTitleOutput getEvaluateByTitile(int stationId,int nextPage,BasicInfov2 basicInfoIn,int titleId);
	
		/**获取活动链接*/
		PaySuccessActivityPathOut  getPaySuccessActivityPath(string orderId,BasicInfov2 basicInfoIn);
	
		/**(结束4.2.3)*/
		
		/**(开始4.3)*/
		//获取用户个人信息(basicInfoIn.userId必须)
		GetUserInfoOutput0918 getUserInfo0918(BasicInfov2 basicInfoIn);
		//修改用户个人信息(basicInfoIn.userId必须)
		ReasonOutput updateUserInfo0918(UserInfo0918 userInfo , BasicInfov2 basicInfoIn);
		//获取账号信息(basicInfoIn.userId必须)
		GetAccountInfoOutput0918 getAccountInfo0918(BasicInfov2 basicInfoIn);
		//修改手机获取验证码
		SendVerificationCodeOut	sendVerificationCodeAfterChecked(string phoneNum);
		//修改账号信息(basicInfoIn.userId必须)
		ReasonOutput updateUserAccountInfo0918(AccountInfo0918 accountInfo , BasicInfov2 basicInfoIn);
		//兑换码兑换优惠券(basicInfoIn.userId必须,channel=2)
	  	ExchangeInviteCodeOut exchangeInviteCode0918(string inviteCode,int channel,BasicInfov2 basicInfoIn);
		//我的优惠券
		/** 我的优惠劵 nextPage:下页页数 ----  (新增返回一个最大的优惠券id)合并是否失效优惠券*/
		QueryMyCouponOutput0918 queryMyCoupon0918(string userId,int nextPage);
		/** 邀请好友分享QQ**/
		InviteFriendAndQqLimitOut inviteFriendAddLimit0918(BasicInfov2 basicInfoIn);
		
		/**(开始4.5)*/
		//验证码校验
		CheckSmsCode1029 checkSmsCode(string phoneNum,string smsCode,BasicInfov2 basicInfoIn);
	
		//获取账号信息(basicInfoIn.userId必须)
		GetAccountInfoOutput1029 getAccountInfo1029(BasicInfov2 basicInfoIn);
		//修改账号信息(basicInfoIn.userId必须)
		ReasonOutput updateUserAccountInfo1029(AccountInfo1029 accountInfo , BasicInfov2 basicInfoIn);
		
		/**v4.6第三方的HTM5的油站列表接口**/
		StationInfoListOutput getStationListPartner(int partnerId,string longitude,string latitude,int nextPage, BasicInfov2 basicInfoIn,int level);
		
		//短信验证码发送接口,4.6.0版本登录页面--手机获取验证码接口更新
		SendVerificationCodeOut   sendVerificationCode151117(string phoneNum);
		//支持第三方平台登录接口
		LoginOutPutSupportThirdPlatfrom loginByUserPhoneSupportThirdPlatfrom(string userIdIn,string userPhoneIn,string verifyNumber,bool isUser,int stationId,BasicInfov2 basicInfoIn);
		/** 4.6.5 接口 **/
	
		/**获取用户个人信息(basicInfoIn.userId必须)*/
		GetUserInfoOutput1207 getUserInfo1207(BasicInfov2 basicInfoIn);
		/** 油站列表 **/
		HomePageStationInfoListOutput1207 homePageStationInfoList1207(string longitude,string latitude,StringList filterTypeList,int carType,int nextPage,BasicInfov2 basicInfoIn,bool isNewView);
		
		/**第三方的HTM5的油站列表接口(只展示广州油站)**/
		StationInfoListOutput getStationListPartner1224(int partnerId,string longitude,string latitude,int nextPage, BasicInfov2 basicInfoIn,int level,int cityId,string stationList , bool isPage);
		
		/**每月冲单用户详细信息**/
		MonthlyOrderActivityInfoOutput getMonthlyOrderActivityInfo(BasicInfov2 basicInfoIn,int activityId);
		
		/** 查询订单享有的所有补贴活动（增加冲单活动）*/
		QueryActivitySubsidyByOrderIdAndClientOutPut  queryActivitySubsidyByOrderId0108(string orderId,BasicInfov2 basicInfoIn,bool isAddAcivity);
		

		
		/** 邀请好友(增加累加活动信息)**/
		InviteFriendAndAccumulationOut inviteFriendAddLimit0215(BasicInfov2 basicInfoIn);
		
		/** 4.7.5 接口 **/
		/** 历史订单,扩展客服电话*/
		GetUserOrder0201Output getUserOrder0201(int userId,long orderId);
		
		/**  type=7(好友邀请title增加加载路径)*/
		QueryMyUrlInfoOutput queryMyInfo0215(QueryMyInfo0730Input queryMyInfoInputI);
		/** 支付完成的广告弹框内容**/
		PayOverCommercialsOutput  getPayOverCommercialsInfo(BasicInfov2 basicInfoIn,int stationId);
		/** 我的优惠劵 支持折扣券的展示*/
		QueryMyCouponOutput0222 queryMyCoupon0222(string userId,int nextPage);
		/** 创建订单 增加订单carType类型*/
		CreateOrderOutput1216 createOrderUser0224(CreateOrderInput0224 createOrderInput0224Input);
		/** v4.7.7 一键加油最近4个油站**/
		HomeQuickStationListOutput getQuickStation(BasicInfov2 basicInfoIn,string longitude,string latitude);
		/**  type=7(好友邀请title增加加载路径)*/
		QueryMyUrlInfoOutput queryMyInfo0226(QueryMyInfo0730Input queryMyInfoInputI);
		
		/**  type=7(好友邀请title增加加载路径)*/
		QueryMyUrlInfoOutput queryMyInfo20170204(QueryMyInfo0730Input queryMyInfoInputI);
		/**  type=7(好友邀请title增加加载路径)*/
		QueryMyUrlInfoOutput queryMyInfo20170408(QueryMyInfo20170408Input queryMyInfoInputI);
		
		
		/** 支持东平每2升3积分**/
		GetOilGun0229OutPut getOilgunAddDicountCoupon0229(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource);
		
		/** 我的优惠劵 支持多有油站分时段*/
		QueryMyCouponOutput0304 queryMyCoupon0304(int userId,int nextPage);
		/**优惠券支持的油站信息 **/
		HomeCouponStationListOutput getCouponStation(BasicInfov2 basicInfoIn,string statioinIdStr,string flag);
		/**向合作伙伴展示优惠油站*/
		StationInfoListOutput0312 getStationListPartner0312(int partnerId,string longitude,string latitude,int cityId);
		/** 油站列表 增加巨惠**/
		HomePageStationInfoListOutput0314 homePageStationInfoList0314(string longitude,string latitude,StringList filterTypeList,int carType,int nextPage,BasicInfov2 basicInfoIn,bool isNewView);
		/** 地图油站列表**/
		HomePageStationInfoListOutput0314 homePageStationInfoListForMap(string longitude,string latitude,int carType,BasicInfov2 basicInfoIn,bool isCooperate);
		/** 增加优惠券是否与其他优惠叠加控制**/
		GetOilGun0322OutPut getOilgunPreferentialOverlay(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource);

		
		/** 校验验证码接口，加入灰名单控制**/
		CheckSmsCode0405 checkSmsCodeAndGrey0405(string phoneNum,string smsCode,BasicInfov2 basicInfoIn);
		/** 获取个人信息，是否存在灰名单**/
		GetUserInfoOutput0405 getUserInfo0405(BasicInfov2 basicInfoIn);
		/** 获取个人信息，增加是否认证字段 2017-01-13 lvguixing**/
		GetUserInfoOutput20170113 getUserInfo20170113(BasicInfov2 basicInfoIn);
		
	    //用户登录和注册 灰名单的用户需要提交车牌号
		RegisterUserWithCarNumberOutput loginOrRegisterUserSendWithCarNumber(string userPhoneSerial,int osType,int userId,string jpushId,string userPhoneIn,string verifyNumber,int idType,string carNumber);
		
		/** 增加优惠券是否与其他优惠叠加控制**/
		GetOilGun0322OutPut getOilgunbackListLimitCash(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 创建订单  4.8.2 增加限制黑名单无优惠**/
		CreateOrderOutput1216 createOrderUser0406(CreateOrderInput0224 createOrderInput0224Input,string userPhoneSerial,BasicInfov2 basicInfoIn);
		/** v4.8.6 一键加油最近4个油站-顶部两个油站**/
		HomeQuickStationV2ListOutput getQuickStationV2(BasicInfov2 basicInfoIn,string longitude,string latitude);
		/** 检查服务器 数据库连接 和　redis是否可用**/
		ReasonOutput opsCheckConnection(bool isCheckDb,bool isCheckRedis);
		string opsControllerMethodCount(int type);
		string opsServiceStatus();
		/** 支付完成的广告弹框内容-- v4.8.7 增加广告图URL**/
		PayOverCommercialstV2Output  getPayOverCommercialsInfoV2(BasicInfov2 basicInfoIn,int stationId);
		
		string testAilPay();
		
		/** 扫码接口  重构用户感知 5.0版**/
		GetOilGun0622OutPut getOilgunbackListLimitCash0622(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 创建订单 重构用户感知优惠 5.0版本 **/
		CreateOrderOutput0622 createOrderUser0622(CreateOrderInput0622 createOrderInput0622Input,string userPhoneSerial,BasicInfov2 basicInfoIn);
		
		/**翻翻乐信息写入数据库接口**/
		TurnHappyOutput turnHappyActivity(TurnHappyParamters turnHappyParamInput ,BasicInfov2 basicInfoIn);
		
		/**接口调用情况*/
		string opsControllerMethodCount0725();
		string getFuncMsg();
		
		/**令牌剩余情况*/
		string getTokenMsg();
		/**重新加载令牌桶配置*/
		string reloadTokenCfg();
		/**查询报警手机号*/
		string getArarmMobiles();
		
		/**查询IP名单*/
		string getIpAllList();
		/**重新加载IP拦截规则*/
		string reloadIpCfg();
		/**重新加载白名单*/
		string reloadIpWhiteList();

		/***重载模块功能开关(para:ip,token)  */
		string reloadManagerStatus(string managerName);
		/***查询模块功能开关状态  */
		string getManagerStatus();
		/**查询IP名单*/
		string changeIpSwitch();
		/**查询Token名单*/
		string changeTokenSwitch();
		
		/** v5.0.5版本使用一键加油，轮换图片改造**/
		HomeQuickStationV2ListOutput getQuickStationV3(BasicInfov2 basicInfoIn,string longitude,string latitude);
		/** 扫码接口  重构用户感知 5.0.5版**/
		GetOilGun0820OutPut getOilgunbackListLimitCash0820(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** v5.04版本 申请特殊身份,新增车类型标签页 **/
		ApplySpecialIdentityOutput applySpecialIdentity0822(SpecialIdentity0822 specialIdentityInfo); 
		/** 获取个人信息，是否存在灰名单 V5.05**/
		GetUserInfoOutput0405 getUserInfo0901(BasicInfov2 basicInfoIn);
		/** ICE连接数 **/
		string getRedisNumActive();
		
		/** 扫码接口  重构优惠券功能5.2.2版**/
		GetOilGun201611OutPut getOilgunbackListLimitCash201611(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 扫码接口  新接口可取出私家车优惠数据5.2.3版**/
		GetOilGun20161201OutPut getOilgunbackListLimitCash20161201(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);

		/** 扫码接口  新接口可取出私家车优惠数据5.3.1版**/
		GetOilGun20161216OutPut getOilgunbackListLimitCash20161216(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 扫码接口  增加车队卡数据5.3.2版**/
		GetOilGun20170109OutPut getOilgunbackListLimitCash20170109(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 扫码接口  增加车队卡数据5.3.5版**/
		GetOilGun20170214OutPut getOilgunbackListLimitCash20170214(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);
		/** 扫码接口  增加E卡数据5.3.8版**/
		GetOilGun20170227OutPut getOilgunbackListLimitCash20170227(string QRCode,string userId,string longitude,string latitude,BasicInfov2 basicInfoIn,int fromSource,string userPhoneSerial);

		/** 用户加油历史 5.2.4版本  **/
		UserHistoryOrder getUserHistoryOrder20161209(BasicInfov2 basicInfoIn, int pageNum);
		/** 用户加油历史版本-查询指定油站及其集团加油历史  **/
		UserHistoryOrder getUserHistoryOrder20170314(BasicInfov2 basicInfoIn, int pageNum, string stationIds);
		/** 用户加油历史版本 5.4.0版本  **/
        UserHistoryOrder20170405 getUserHistoryOrder20170405(BasicInfov2 basicInfoIn, string pageNum, string stationIds);

		/** 2016-12-09 订单详情 **/
		GetUserOrder1209Output getUserOrderDetail1209(int userId,long orderId,BasicInfov2 basicInfoIn);
		
		/** 2016-12-14**/
		RefundTimeOut getRefundTimeOut(long orderId,BasicInfov2 basicInfoIn);
		/** v5.3.4版本使用---充值 **/
		RechargeOrderOutput createRechargeOrder(int userId,int payType,string money,BasicInfov2 basicInfoIn);
		
		/** 2017-01-09 车队卡支付信息 **/
		PayFleetOrderInfo payFleetOrder(string userId, string orderId, string password, int type, BasicInfov2 basicInfoIn);
		/** 余额 **/
		PersonBalanceInfo getPersonBalanceInfo(BasicInfov2 basicInfoIn);
		/** 2017-01-13 支付密码变更 type: 1 == 设置密码，2 == 变更密码 **/
		ReasonOutput updatePassWord(string oldPwd, string newPwd, int type, BasicInfov2 basicInfoIn);
		/** 2017-01-13 重设密码上传证件照,  frontPhoto=正面照 oppositePhoto=反面照 **/
		ReasonOutput uploadIdCard(string frontPhoto, string oppositePhoto, BasicInfov2 basicInfoIn);
		/** 2017-01-14 验证身份证 **/
		ReasonOutput checkIdCard(string name, string idCardNo, BasicInfov2 basicInfoIn);
		/** 2017-01-15 获取用户充值消费记录 **/
		UserBalanceRecords getUserBalanceRecord(int nextPageNo, BasicInfov2 basicInfoIn);
		/** 2017-01-15 获取账号信息,增加是否展示修改密码 **/
		GetAccountInfoOutput20170115 getAccountInfo20170115(BasicInfov2 basicInfoIn);
		/** 2017-01-16 获取审核状态 **/
		IdentityAuditState checkIdentityAuditState(BasicInfov2 basicInfoIn);
		
		/** 2017-02-14 获取用户的是否设置初始密码、身份证认证、是否展示修改密码 **/
		UserPaymentState checkUserPaymentState(BasicInfov2 basicInfoIn);
		/** 2017-02-14 获取app支付的所有类型及状态 **/
		AppPaymentState getAppPaymentState(int stationId, BasicInfov2 basicInfoIn);
		
		/** 2017-02-15 获取账号信息,增加是否展示修改密码 **/
		GetAccountInfoOutput20170215 getAccountInfo20170215(BasicInfov2 basicInfoIn);
		/** 2017-02-15 车队卡支付信息 **/
		PayFleetOrderInfo20170215 payFleetOrder20170215(string userId, string orderId, string password, int type, BasicInfov2 basicInfoIn);
		
		/** 2017-02-27 获取app支付的所有类型,状态,待支付金额 **/
		AppPaymentState20170227 getAppPaymentState20170227(AppPaymentInputVo vo, BasicInfov2 basicInfoIn);
		/** 2017-04-21 获取app支付的所有类型,状态,待支付金额
         * type == 1 所有支付方式
         * type == 2 选择个人支付方式
         * type == 3 选择车队卡支付方式
		**/
		AppPaymentState20170227 getAppPaymentState20170421(AppPaymentInputVo vo,string type, BasicInfov2 basicInfoIn);
		/** 2017-04-21 获取app支付的所有类型,状态,待支付金额
         ** type == 1 所有的支付类型
         ** 其它值来自于扫码所选择的id
		**/
		AppPaymentState20170503 getAppPaymentState20170503(AppPaymentInputVo vo,string type, BasicInfov2 basicInfoIn);
		
		/** 2017-03-16 新版的扫码接 **/
		GetOilGun20170316OutPut getOilgunbackListLimitCash20170316(ScanCodeVo vo, BasicInfov2 basicInfoIn);
		/** 2017-03-30 5.4.0 新版的扫码接 **/
		GetOilGun20170330OutPut getOilgunbackListLimitCash20170330(ScanCodeVo vo, BasicInfov2 basicInfoIn);
		/** 创建订单 增加车牌  5.4.1版本 **/
		CreateOrderOutput0622 createOrderUser20170421(CreateOrderInput20170421 createOrderInput20170421Input,string userPhoneSerial,BasicInfov2 basicInfoIn);

		/** 2017-04-21 新的上传个人信息接口 **/
		ReasonOutput updateUserInfo20170421(UserInfo20170421 userInfo , BasicInfov2 basicInfoIn);
		/** 2017-04-21 新加头像 **/
		GetUserInfoOutput20170421 getUserInfo20170421(BasicInfov2 basicInfoIn);

		/** 2017-04-21 5.4.1 新版的扫码接
         * type == 1 表示判断是否需要强框
         * type == 2 选择个人支付方式
         * type == 3 选择车队卡支付方式
		**/
		GetOilGun20170421OutPut getOilgunbackListLimitCash20170421(ScanCodeVo vo, string type, BasicInfov2 basicInfoIn);
		/** 2017-04-21 5.4.1 新版的扫码接
          * type == -1 表示需要返回支付类型选择窗口
        **/
        GetOilGun20170503OutPut getOilgunbackListLimitCash20170503(ScanCodeVo vo, string type, BasicInfov2 basicInfoIn);
	};
	
	/** 	
		code:
			000	 程序正常
			001	 程序综合异常
			
			010 RFId卡不存在			011	RFId卡已经被其他用户绑定了			012	该用户已经绑定了RFId卡
			021 该类型团购券包已经购买未使用完
			100  未录入的电话号码											110  团购卷存在问题(综合原因)
			101  团购卷已售完													111  未查询到用户.
			102  团购卷未到购买时间 										112	优惠劵已经被使用
			103 	 今天已经使用过团购券了.								113	抵扣积分出错
																							114 验证码错误
																							115 用户登录失败
																					
			200	加油金额大于优惠劵金额
	*/
	};