<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/jsmind.css"/>
    <script type="text/javascript" src="./js/jquery-3.2.0.js"></script>
    <script type="text/javascript" src="./js/jsmind.js"></script>
    <script type="text/javascript" src="./js/debug.js"></script>
    <script type="text/javascript" src="./js/jmindutil.js"></script>
    <style type="text/css">
        #test_module {
            width: 250px;
            height: 600px;
            border: solid 1px #ccc;
            /*background:#f4f4f4;*/
            float: left;
        }
        #jsmind_container {
            float: left;
            border: 1px solid #ccc;
            width: 800px;
            height: 600px;
            background: #f4f4f4;
        }
        #result_zone {
            float: left;
            border: 1px solid #ccc;
        }

        #list {
            background: transparent;
            width: 268px;
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            height: 34px;
            -webkit-appearance: none; /*for chrome*/
        }

        button {
            color: #0000FF;
            background: #d58512;
        }
    </style>
    <title>Ice接口调试</title>
</head>
<body>
<h1 align="center">Ice接口调试</h1>
<form id="getResult">
    <p>接口名称 : <select id="list" name="interfaceName"></select></p><br>
    <button type="button" onclick="getResult()">submit</button>
    <button type="button" onclick="saveTestCase()">save</button>
</form>
<div id="test_module">
    <div class="module_title"><span>测试计划目录</span></div><br>
    <div class="test_plan">
        <span>测试计划一</span>
        <ul class="case_list" style="display: none">
            <li>case 1</li>
            <li>case 2</li>
        </ul>
    </div>
    <div class="test_plan">
        <span>测试计划二</span>
        <ul class="case_list" style="display: none">
            <li>case 1</li>
            <li>case 2</li>
        </ul>
    </div>
</div>
<div id="jsmind_container">
    <button type="button" onclick="add_node()">添加子节点</button>
    <br>
    <button type="button" onclick="remove_node()">删除节点</button>
</div>
<div id="result_zone"><textarea id="result" rows="40" cols="80"></textarea></div>
</body>
</html>