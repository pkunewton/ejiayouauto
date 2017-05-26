/**
 * 
 */

// 添加子节点
var add_node = function(){
	var selected = jsMind.current.get_selected_node();
	if(!selected){
		alert("请选择父节点!!!");
		return;
	}
	console.log('jmnode[nodeid='+selected.id+']');
	$.ajax({
		url: '/ejiayouauto/checkParam',
		type: 'get',
		dataType: 'json',
		data: {
			fieldType : $('jmnode[nodeid='+selected.id+']').attr("name")
		},
	})
	.done(function(json) {
		console.log("success:code="+json.code);
		if(json.code == 0){
			// 非
			alert("请选择一个正确的参数！");
			return;
		}else if(json.code == 1){
			// 基本数据类型或者字符串
	        var length = selected.children.length;
	        if(!length){
		        var nodeid = selected.id + '_child_1' ;
		        var topic = selected.id + '_child_1' ;
	        }
	
	        var nodeid = selected.id + '_child_' + (length+1) ;
            var topic = selected.id + '_child_' + (length+1) ;
            var node = jsMind.current.add_node(selected, nodeid, "insert value");
		}else if(json.code == 4){
			// 参数是对象
			$.ajax({
				url: '/ejiayouauto/fieldlist',
				type: 'get',
				dataType: 'json',
				data: {
					fieldType : $('jmnode[nodeid='+selected.id+']').attr("name")
				},
			})
			.done(function(json) {
				console.log("success");
				if(!isEmptyObject(json)){
				var str = JSON.stringify(json);
				var params = str.substring(1,str.length-1).split(",");
				var max = params.length;
				for (var i = 0; i < max; i++) {
					console.log(params[i]);
					var param = params[i].split(":");
					var key = param[0].substring(1,param[0].length-1);
					var value = param[1].substring(1,param[1].length-1);
					var node = 
						jsMind.current.add_node(selected.id,key, key, {"background-color":"red"});
					$("jmnode[nodeid="+key+"]").attr("name",value);
				}
			}
			})
			.fail(function() {
				console.log("error");
			})
			.always(function() {
				console.log("complete");
			});
			
		}
	})
	.fail(function() {
		console.log("error");
		alert('请选择一个正确的参数！');
	})
	.always(function() {
		console.log("complete");
	});

}
// 删除子节点
var remove_node = function(){
	var selected = jsMind.current.get_selected_node();
	if(!selected){
		alert("请选择要删除的节点!!!");
		return;
	}
	jsMind.current.remove_node(selected)
}

