<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LEMS</title>
    <%--<jsp:include page="inc.jsp"></jsp:include>--%>
    <script type="text/javascript" src="./jslib/jquery-easyui-1.5.1/jquery.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="./jslib/jquery-easyui-1.5.1/jquery.easyui.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="./jslib/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/icon.css">
    <link href="./jslib/bootstrap-2.3.1/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <%--<link rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/default/easyui.css">--%>

    <link id="easyuiTheme" rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/bootstrap/easyui.css" type="text/css">
    <script type="text/javascript" src="jslib/cookie_util.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/base64.js" charset="UTF-8"></script>

    <!-- 引入my97日期时间控件 -->
    <script type="text/javascript" src="jslib/My97DatePicker4.8b3/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

    <script type="text/javascript" src="jslib/lems/lems-util.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/lems/index.js" charset="UTF-8"></script>
    <script>
        $(function(){
            if(!navigator.cookieEnabled){//判断浏览器是否支持cookie
                $.messager.alert('警告', "你的浏览器未启用Cookie功能，如需使用本系统请开启浏览器Cookie",'info');
            }

            $("#index_logout").click(index_logout);//退出按钮事件绑定
            $("#useradd_link").click(useradd_tab_add);//添加用户菜单事件绑定

            /**
             * 退出按钮单击事件处理
             */
            function index_logout(){
                delCookie("uid");
                delCookie("token");
                delCookie("uname");
                window.location.reload();
            }

            /**
             * 单击添加用户菜单事件
             */
            function useradd_tab_add(){
                $("#index_tt").tabs('add',{
                    title:"用户添加",
                    closable:true,
                    href:'user/add_user.jsp',
                    fit:true
                });
            }
        });
    </script>
    <style>
        a{
            text-decoration:none;
        }
        a:hover{
            text-decoration:none;
        }
    </style>
</head>
<body>
<div id="cc" class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:false" style="height:80px;">
        <div style="width:100%;height: 100%">
            <div style="width:80%;float: left;margin-top: 20px;margin-bottom: auto">
                <b style="font-size: 48px;color: #0E76CB">Laboratory Equipment Management System</b>
            </div>
            <div style="width: 20%;float: left;text-align: left;margin-bottom: auto">
                <b>[</b><span id="index_username"></span><b>]您好</b><br>
                <b>欢迎使用实验室设备管理系统</b><br>
                <b>[</b><span id="index_userrole"></span><b>]角色&emsp;</b><span id="index_logout"></span>
            </div>
        </div>
    </div>
    <div data-options="region:'south',split:false,collapsible:false" style="height:75px;">
        <div style="text-align: center;margin-left: auto;margin-right: auto;margin-top: 10px">
            <b>柯昊</b><br>
            <b>西安工程大学·计算机科学学院</b><br>
            <b>暂无备案</b>
        </div>
    </div>
    <div data-options="region:'east',title:'备注',split:true,collapsible:true,resizable:true"  style="width:100px;">

    </div>
    <div data-options="region:'west',title:'功能导航',split:false,collapsible:true" style="width:150px;">
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div title="基础功能" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>设备查询</li>
                    <li>实验室查询</li>
                </ul>
            </div>
            <div title="设备管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>设备采购(添加)</li>
                    <li>设备报修</li>
                    <li>设备转移(分配)</li>
                    <li>设备采购</li>
                    <li>设备保修</li>
                    <li>设备转移</li>
                </ul>
            </div>
            <div title="实验室管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>实验室添加</li>
                    <li>实验室移除</li>
                    <li>实验室负责人管理</li>
                </ul>
            </div>
            <div title="设备日程管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>设备借出</li>
                    <li>设备归还</li>
                    <li>设备预约</li>
                </ul>
            </div>
            <div title="实验室日程管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>设实验室预约</li>
                </ul>
            </div>
            <div title="用户管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="useradd_link" href="javascript:;">用户添加</a></li>
                    <li>用户删除</li>
                    <li>用户授权管理</li>
                </ul>
            </div>
            <div title="用户个人信息管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li>用户信息变更</li>
                    <li>用户密码变更</li>
                </ul>
            </div>
        </div>
    </div>
    <div data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;">
        <jsp:include page="user/login.jsp"></jsp:include>
        <div id="index_tt" class="easyui-tabs" style="width:99.5%;height:99.5%;padding: 0px">
            <div title="欢迎" data-options="closable:false" style="overflow:auto;display:none;">
                <jsp:include page="welcome.jsp"></jsp:include>
            </div>
            <%--<div title="添加用户" data-options="closable:true" style="overflow:auto;display:none;" >
                <jsp:include page="user/add_user.jsp"></jsp:include>
            </div>--%>
        </div>
    </div>
</div>
</body>
</html>
