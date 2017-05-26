/**
 * 注意:
 * 	1)代码中不能使用单引号，因为微信中使用eval('')操作
 * 	2)代码最好去掉所有空格，使用压缩工具:http://tool.oschina.net/jscompress
 *  3)算法配置在:ejiayou_count_money表中
 *  selectMerchandiseJson = {"merchandiseId" : "1" , "merchandiseType" : "1" , "merchandiseValue" : "5" , "limitMoney" : "20" ,"addOnEjiayou" : "1" }
 *	merchandiseJsonList = [ {"merchandiseId" : "1" , "merchandiseType" : "1" , "merchandiseValue" : "5" , "limitMoney" : "20" , "addOnEjiayou" : "1"} , {"merchandiseId" : "2" , "merchandiseType" : "2" , "merchandiseValue" : "0.65" , "limitMoney" : "10"  , "addOnEjiayou" : "1"} ]
 */

function getInfoByInput( inputMoney , countryPrice , stationPrice , ejiayouPrice , merchandiseJsonList , selectMerchandiseJson , isPassUserLimitCount ,  userWantedCoupon){
	Number.prototype.toFixed = function(len)
	{
		var add = 0;
		var s,temp;
		var s1 = this + "";
		var start = s1.indexOf(".");
		if(start>0){
			if(s1.substr(start+len+1,1)>=5)add=1;
		}
		var temp = Math.pow(10,len);
		s = Math.floor(numMulti(this, temp)) + add;
		return s/temp;
	};
	
	var changeTwoDecimal_f = function(x) {
	    var f_x = parseFloat(x);
	    if (isNaN(f_x)) {
	        return false;
	    }
	    var f_x = Math.round(x * 100) / 100;
	    var s_x = f_x.toString();
	    var pos_decimal = s_x.indexOf(".");
	    if (pos_decimal < 0) {
	        pos_decimal = s_x.length;
	        s_x += ".";
	    }
	    while (s_x.length <= pos_decimal + 2) {
	        s_x += "0";
	    }
	    return s_x;
	};
	
	var numMulti = function(num1, num2) {
		var baseNum = 0; 
		try { 
		baseNum += num1.toString().split(".")[1].length; 
		} catch (e) { 
		} 
		try { 
		baseNum += num2.toString().split(".")[1].length; 
		} catch (e) { 
		} 
		return Number(num1.toString().replace(".", "")) * Number(num2.toString().replace(".", "")) / Math.pow(10, baseNum); 
	};
	
	var checkParam = function(target){
		if( !target || null == target || undefined == target || "" == target || "null" == target ){
			return false;
		}
		return true;
	};
	
	var getMerchandise = function(list , select , inputValue , isAuto){
		
		if(checkParam(select) && select.merchandiseType == 1 && inputValue >= parseFloat(select.limitMoney) ){
			return select;
		}
		
		if(checkParam(select) && select.merchandiseType == 2 ){
			return select;
		}
		
		//是否自动赛选
		if( isAuto != 1 ){
			return null;
		}
		
		select = null;
		var resultSelect = null;
		for(var i = 0 ; i < list.length ; i++){
			select = list[i];
			if(select.merchandiseType == 2){
				resultSelect = select;
				break;
			}
			if(select.merchandiseType == 1 && inputValue >= parseFloat(select.limitMoney)){
				resultSelect = select;
				break;
			}
		}
		
		return resultSelect;

	};
	
	var result = {
			oilMass : "0",
			countryPrice : "",
			stationReduce : "",
			ejiayouReduce : "",
			merchandiseReduce : "",
			merchandiseSelect : {},	
			orderSum : "0"
	};
	
	try{
	
		
		if( !checkParam(countryPrice) || isNaN(countryPrice) ){
			return JSON.stringify( result );
		}
		if( !checkParam(stationPrice) || isNaN(stationPrice) ){
			return JSON.stringify( result );
		}
		if( !checkParam(inputMoney) || isNaN(inputMoney) || inputMoney <= 0 ){
			return JSON.stringify( result );
		}
		if( !checkParam(ejiayouPrice) || isNaN(ejiayouPrice) || ejiayouPrice <= 0){
			ejiayouPrice = stationPrice;
		}
		if(ejiayouPrice == stationPrice || parseFloat(ejiayouPrice) == parseFloat(stationPrice) ){
			isPassUserLimitCount = 0;
		}
		
		var inputMoney = parseFloat( (inputMoney + "").trim() );
		var countryPrice = parseFloat( (countryPrice + "").trim() );
		var stationPrice = parseFloat( (stationPrice + "").trim() );
		var ejiayouPrice = parseFloat( (ejiayouPrice + "").trim() );
		var merchandiseJsonList = ( checkParam(merchandiseJsonList) ? JSON.parse(merchandiseJsonList) : [] );
		var selectMerchandiseJson = ( checkParam(selectMerchandiseJson) ? JSON.parse(selectMerchandiseJson) : null );
		
		//计算升数
		var mass = changeTwoDecimal_f(inputMoney/stationPrice);
		result.oilMass = mass;
		
		//计算国家价金额
		var countryValue = numMulti(mass , countryPrice);
		var stationReduce = countryValue - inputMoney;
		countryValue = countryValue.toFixed(2);
		stationReduce = stationReduce.toFixed(2);
		if( stationReduce > 0  &&  parseFloat(countryPrice) > parseFloat(stationPrice)){
			result.countryPrice = "国家价" + countryValue + "元，本站直降" ; 
			result.stationReduce = "￥" + stationReduce ; 
		}
		
		//计算易加油优惠
		var ejiayouValue = numMulti(mass , ejiayouPrice);
		var ejiayouReduce = inputMoney - ejiayouValue;
		ejiayouReduce = ejiayouReduce.toFixed(2);
		if( ejiayouReduce > 0 && stationPrice > ejiayouPrice){
			result.ejiayouReduce = "-"+ ejiayouReduce +"元";
		}
		
		//计算优惠券优惠
		var merchandise = getMerchandise(merchandiseJsonList , selectMerchandiseJson , inputMoney , userWantedCoupon);
		var mvalue = 0;
		var addOnEjiayou = 1;
		var orderSum = 0;
		
		if(checkParam(merchandise)){
	
			if(merchandise.merchandiseType == 1){
				mvalue = parseFloat(merchandise.merchandiseValue);
			}else{
				var discount = (merchandise.merchandiseValue)/10;
				discount = 1 - discount;
				discount = discount.toFixed(2);
				mvalue = numMulti( discount , inputMoney);
				mvalue = mvalue.toFixed(2);
				mvalue = (  mvalue > merchandise.limitMoney ? merchandise.limitMoney : mvalue );
			}
			
			addOnEjiayou = merchandise.addOnEjiayou;
			result.merchandiseReduce = "-"+mvalue+"元";
			result.merchandiseSelect = merchandise;
		}
		
		//如果用户每天优惠次数达上线,则不能再享受易加油优惠
		if( isPassUserLimitCount == 0 ){
			result.ejiayouReduce = "";
			var orderSum = inputMoney - mvalue;
			result.orderSum = orderSum.toFixed(2) + "";
			return JSON.stringify( result );
		}
		
		//如果用户今天还能享受优惠
		else{
			
			//如果优惠券不能与其他优惠叠加
			if( addOnEjiayou == 0){
				result.ejiayouReduce = "";
				var orderSum = inputMoney - mvalue;
				result.orderSum = orderSum.toFixed(2) + "";
			}
			
			//优惠券能与其他优惠叠加
			else{
				var orderSum = inputMoney - mvalue - ejiayouReduce;
				result.orderSum = orderSum.toFixed(2) + "";
			}
			
			return JSON.stringify( result );
		
		}
	
	}catch(e){
		JSON.stringify( result );
	}
	
}

