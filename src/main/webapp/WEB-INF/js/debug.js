/**
 * @author liuke
 */
var load_jsmind = function () {
    var mind = {
        "meta": {
            "name": "demo",
            "author": "hizzgdev@163.com",
            "version": "0.2",
        },
        "format": "node_array",
        "data": [
            {"id": "root", "isroot": true, "topic": "data"},

        ]
    };
    var options = {
        container: 'jsmind_container',
        editable: true,
        theme: 'orange',
        mode: 'side'
    }
    var jm = jsMind.show(options, mind);
    // jm.set_readonly(true);
    // var mind_data = jm.get_data();
    // alert(mind_data);
}

// 载入 参数集 的思维导图容器
$(document).ready(load_jsmind);

// 载入接口列表
$(document).ready(function () {

    $.ajax({
        url: "/ejiayouauto/interfacelist",
        dataType: "json",
        data: {},
        success: function (json) {
            console.log("接口列表请求成功");
            // 把接口列表写入select标签
            console.log(json);
            var length = json.length;  //responseJSON
            if (length > 0) {
                for (var i = 0; i < length; i++) {
                    var row = document.createElement("option");
                    row.setAttribute("value", json[i]);
                    row.innerHTML = json[i];
                    $("#list").append(row);
                }
            }
            console.log(json.length);
            // 在jmind容器里展开参数列表
            showParameterList();
        },
        err: function () {
            console.log("请求错误");
        },
        complete: function () {
            console.log("请求完成")
        }
    });

});

// 载入测试记录目录
$(document).ready(function () {
    $.ajax({
        url: "/ejiayouauto/plans",
        dataType: "json",
        data: {},
        success: function (json) {
            console.log("测试用例目录接口请求成功");
            $("#test_module").empty();
            var row = document.createElement("div");
            row.setAttribute("class", "module_title");
            var cell = document.createElement("span");
            cell.innerHTML = "测试计划目录";
            row.appendChild(cell);
            $('#test_module').append(row);
            var length = json.length;
            if(length > 0){
                for(var i = 0; i < length; i++){
                    var row = document.createElement("div");
                    row.setAttribute("class", "test_plan");
                    row.setAttribute("module_id", json[i].id);
                    var cell = document.createElement("span");
                    cell.innerHTML = json[i].name;
                    row.appendChild(cell);
                    cell = document.createElement("ul");
                    cell.setAttribute("class", "case_list");
                    cell.setAttribute("style", "display: none");
                    row.appendChild(cell);
                    row.onclick = showTestCases;
                    $('#test_module').append(row);

                }
            }
        },
        err: function () {
            
        },
        complete: function () {
            
        }
    })
})

//  接口名称变化时，重新载入参数
$(document).ready(function () {
    $('#list').change(showParameterList);
});

// 获取ice接口返回值
var getResult = function () {

    var types = getTypes();
    var values = getParamValues();
    console.log(values);

    $.ajax({
        url: "/ejiayouauto/result",
        dataType: "json",
        type: "post",
        traditional: true,
        data: {
            interfaceName: $("#list").val(),
            paramTypeList: types,
            params: values
        },
        success: function (json) {
            console.log("接口请求成功");
            $("#result").val("");
            $("#result").val(JSON.stringify(json, null, '\t'));
        },
        err: function () {
            console.log("请求错误");
        },
        complete: function (json) {

        }
    });
    return false;
};

// 展示接口参数列表
var showParameterList = function () {
    $.ajax({
        url: "/ejiayouauto/paramlist",
        dataType: "json",
        data: {
            interfaceName: $("#list").val()
        },
        success: function (json) {
            console.log("接口列表请求成功");
            // 情况原参数列表
            var nodes = jsMind.current.get_root().children;
            if (nodes != null) {
                var len = nodes.length;
                for (var i = len - 1; i >= 0; i--) {
                    console.log(nodes[i]);
                    jsMind.current.remove_node(nodes[i]);
                }
            }
            // 参数列表不为空时
            if (!isEmptyObject(json)) {
                console.log(json[1]);
                console.log(JSON.stringify(json[0]));
                var names = json[0];
                var types = json[1];
                var max = names.length;

                for (var i = 0; i < max; i++) {
                    var key = names[i]
                    var value = types[i];
                    var node =
                        jsMind.current.add_node("root", key, key, {"background-color": "red"});
                    $("jmnode[nodeid=" + key + "]").attr("name", value);
                }
            }
        },
        err: function () {

        },
        complete: function (json) {

        }
    });
};

// 判断对象是否为空
function isEmptyObject(e) {
    var t;
    for (t in e)
        return !1;
    return !0
};

// 获取参数列表的参数类型 
function getTypes() {
    var types = [];
    var nodes = jsMind.current.get_root().children;
    if (nodes != null) {
        var len = nodes.length;
        for (var i = len - 1; i >= 0; i--) {
            var type = $('jmnode[nodeid=' + nodes[i].id + ']').attr('name');
            types.push(type);
        }
    }
    // 调整参数参数传入顺序，确保和方法参数列表一致
    return types.reverse();
};


// 获取参数值列表
function getParamValues() {
    var paramValues = [];
    var nodes = jsMind.current.get_root().children;
    if (nodes) {
        var len = nodes.length;
        for (var i = len - 1; i >= 0; i--) {
            var value = getValue(nodes[i]);
            if (!(/^[\{\[]/.test(value))) {
                paramValues.push(value);
            } else {
                paramValues.push(JSON.stringify(value));
            }
        }
    }
    // 调整参数参数传入顺序，确保和方法参数列表一致
    return paramValues.reverse();
};

// 获取参数值
function getValue(node) {
    var value;
    var type = $('jmnode[nodeid=' + node.id + ']').attr("name");
    if (!type) {
        alert("参数 ：" + node.topic + " 没有取值");
    } else if (type == "int" || type == "java.lang.String" || type == "long" || type == "float"
        || type == "double") {
        value = node.children[0].topic;
    } else {
        value = {};
        var childnodes = node.children;
        if (childnodes) {
            var len = childnodes.length;
            for (var i = len - 1; i >= 0; i--) {
                var name = childnodes[i].topic;
                value[name] = getValue(childnodes[i]);
            }
        }
    }
    return value;
};


// 保存 测试用例
var saveTestCase = function () {
    var types = getTypes();
    var values = getParamValues();
    console.log(values);

    $.ajax({
        url: "/ejiayouauto/addTestCase",
        dataType: "json",
        type: "post",
        traditional: true,
        data: {
            interfaceName: $("#list").val(),
            paramTypeList: types,
            params: values,
            moduleId: 2,
            caseDescription: "ajax desc",
            existParams: 1
        },
        success: function (json) {
            console.log("保存成功");
            alert("用例保存成功")
        },
        err: function () {
            console.log("请求错误");
        },
        complete: function (json) {

        }
    });
};

var showTestCases = function () {
        if($(this).find('ul').css("display") == "block"){
            $(this).find('ul').slideToggle();
        }else {
            console.log("显示用例列表！");
            var ul = $(this).find("ul");
            ul.empty();
            $.ajax({
                url: "testCases",
                dataType: "json",
                data: {
                    moduleId: $(this).attr("module_id")
                },
                success: function (test_cases) {
                    var case_num = test_cases.length;
                    if(case_num > 0 ) {

                        for(var j = 0; j < case_num; j++){
                            var cell = document.createElement("li");
                            cell.setAttribute("case_id", test_cases[j].caseId);
                            cell.innerHTML = test_cases[j].interfaceName;
                            console.log(ul.css("display"));
                            ul.append(cell);
                        }
                    }
                }
            })

            $(this).find("ul").css("display", "block");
        }

        // $(this).find('ul').slideToggle();
};
