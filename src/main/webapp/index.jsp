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

    <%--<link rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/default/easyui.css">--%><%--换用bootstrap样式--%>
    <link id="easyuiTheme" rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/bootstrap/easyui.css" type="text/css">

    <script type="text/javascript" src="jslib/cookie_util.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/base64.js" charset="UTF-8"></script>

<%--    <!-- 引入my97日期时间控件 -->
    <script type="text/javascript" src="jslib/My97DatePicker4.8b3/My97DatePicker/WdatePicker.js" charset="utf-8"></script>--%>

    <script type="text/javascript" src="jslib/lems/lems-util.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/lems/index.js" charset="UTF-8"></script>
    <script>
        $(function(){
            if(!navigator.cookieEnabled){//判断浏览器是否支持cookie
                $.messager.alert('警告', "你的浏览器未启用Cookie功能，如需使用本系统请开启浏览器Cookie",'info');
            }

            $("#index_logout").click(index_logout);//退出按钮事件绑定
            $("#useradd_link").click(useradd_tab_add);//添加用户菜单事件绑定
            $("#equadd_link").click(equadd_tab_add);//添加设备菜单事件绑定
            $("#labadd_link").click(labadd_tab_add);//添加实验室菜单事件绑定
            $("#modify_user_info_link").click(modify_user_info_tab_add);//添加用户信息修改菜单事件绑定
            $("#modify_user_pwd_link").click(modify_user_pwd_tab_add);//添加用户密码修改菜单事件绑定
            $("#roleadd_link").click(roleadd_tab_add);//添加角色菜单事件绑定
            $("#userremove_link").click(userremove_tab_add);//删除用户菜单事件绑定
            $("#userlist_link").click(userlist_tab_add);//用户列表菜单事件绑定
            $("#lablist_link").click(lablist_tab_add);//用户列表菜单事件绑定



            /**
             * 退出按钮单击事件处理
             */
            function index_logout(){
                delCookie("uid");
                delCookie("token");
                delCookie("uname");
                delCookie("role");
                window.location.reload();
            }

            /**
             * 单击添加用户菜单事件
             */
            function useradd_tab_add(){
                //防止重复添加tab
                if($("#index_tt").tabs("exists","用户添加")){
                    $("#index_tt").tabs("select","用户添加");
                }else{
                    //单击添加用户菜单事件
                    $("#index_tt").tabs('add',{
                        title:"用户添加",
                        closable:true,
                        href:'user/add_user.jsp',
                        fit:true
                    });
                }
            }

            /**
             * 单击添加设备菜单事件
             */
            function equadd_tab_add(){
                if($("#index_tt").tabs("exists","设备采购")){
                    $("#index_tt").tabs("select","设备采购");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"设备采购",
                        closable:true,
                        href:"equ/add_equ.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 单击添加实验室菜单事件
             */
            function labadd_tab_add(){
                if($("#index_tt").tabs("exists","添加实验室")){
                    $("#index_tt").tabs("select","添加实验室");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"添加实验室",
                        closable:true,
                        href:"lab/add_lab.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 用户信息修改菜单事件
             */
            function modify_user_info_tab_add(){
                if($("#index_tt").tabs("exists","用户信息变更")){
                    $("#index_tt").tabs("select","用户信息变更");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"用户信息变更",
                        closable:true,
                        href:"user/modify_user_info.jsp",
                        fit:true
                    });
                }
            }
            /**
             * 用户密码修改菜单事件
             */
            function modify_user_pwd_tab_add(){
                if($("#index_tt").tabs("exists","用户密码变更")){
                    $("#index_tt").tabs("select","用户密码变更");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"用户密码变更",
                        closable:true,
                        href:"user/modify_user_pwd.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 添加角色菜单事件
             */
            function roleadd_tab_add(){
                if($("#index_tt").tabs("exists","角色添加")){
                    $("#index_tt").tabs("select","角色添加");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"角色添加",
                        closable:true,
                        href:"./role/add_role.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 删除用户菜单事件
             */
            function userremove_tab_add(){
                if($("#index_tt").tabs("exists","用户删除")){
                    $("#index_tt").tabs("select","用户删除");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"用户删除",
                        closable:true,
                        href:"./user/remove_user.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 用户列表菜单事件
             */
            function userlist_tab_add(){
                if($("#index_tt").tabs("exists","用户列表")){
                    $("#index_tt").tabs("select","用户列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"用户列表",
                        closable:true,
                        href:"./user/list_user.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 用户列表菜单事件
             */
            function lablist_tab_add(){
                if($("#index_tt").tabs("exists","实验室列表")){
                    $("#index_tt").tabs("select","实验室列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"实验室列表",
                        closable:true,
                        href:"./lab/list_lab.jsp",
                        fit:true
                    });
                }
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
        a:visited{
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
                    <li><a id="equadd_link" href="javascript:;">设备采购(添加)</a></li>
                    <li>设备报修</li>
                    <li>设备转移(分配)</li>
                    <li>设备注销</li>
                </ul>
            </div>
            <div title="实验室管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="lablist_link" href="javascript:;">实验室列表</a></li>
                    <li><a id="labadd_link" href="javascript:;">实验室添加</a></li>
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
            <div title="角色管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="roleadd_link" href="javascript:;">角色添加</a></li>
                    <li>角色删除</li>
                    <li>角色权限管理(资源)</li>
                </ul>
            </div>
            <div title="用户管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="userlist_link" href="javascript:;">用户列表</a></li>
                    <li><a id="useradd_link" href="javascript:;">用户添加</a></li>
                    <li><a id="userremove_link" href="javascript:;">用户删除</a></li>
                    <li>用户授权管理(角色)</li>
                </ul>
            </div>
            <div title="用户个人信息管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="modify_user_info_link" href="javascript:;">用户信息变更</a></li>
                    <li><a id="modify_user_pwd_link" href="javascript:;">用户密码变更</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;">
        <jsp:include page="user/login.jsp"></jsp:include>
        <div id="index_tt" class="easyui-tabs" fit="true" style="overflow:hidden;padding: 0px">
            <div title="欢迎" data-options="closable:false" fit="true" style="overflow:hidden;display:none;">
                <jsp:include page="welcome.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</body>
</html>
