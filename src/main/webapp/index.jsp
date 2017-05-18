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
    <%--换用bootstrap样式--%>
    <link id="easyuiTheme" rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/bootstrap/easyui.css" type="text/css">

    <script type="text/javascript" src="jslib/lems/cookie_util.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/lems/base64.js" charset="UTF-8"></script>

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

            /*
            * 查询模块
            */
            $("#labsearch_link").click(lab_search_list_tab_add);//实验室列表菜单事件绑定
            $("#search_ordered_equ_link").click(ordered_equ_tab_add);//已预约设备列表菜单事件绑定
            $("#search_ordered_lab_link").click(ordered_lab_tab_add);//已预约实验室列表菜单事件绑定
            $("#search_user_list_link").click(search_user_list_tab_add);//用户列表菜单事件绑定


            /*
             * 设备模块
             */
            $("#equlist_link").click(equ_list_tab_add);//设备列表菜单事件绑定
            $("#equadd_link").click(equ_add_tab_add);//添加设备菜单事件绑定
            $("#equ_move_link").click(equ_list_tab_add);//设备列表菜单事件绑定
            $("#equ_remove_link").click(equ_list_tab_add);//设备列表菜单事件绑定
            $("#equ_break_link").click(equ_list_tab_add);//设备报修菜单事件绑定
            $("#equ_break_list_link").click(break_equ_list_tab_add);//报修设备列表菜单事件绑定

            /*
             * 实验室模块
             */
            $("#lablist_link").click(lab_list_tab_add);//实验室列表菜单事件绑定
            $("#labadd_link").click(lab_add_tab_add);//添加实验室菜单事件绑定
            $("#lab_remove_link").click(lab_list_tab_add);//实验室列表菜单事件绑定
            $("#labmgr_link").click(lab_mgr_tab_add);//实验室负责人管理菜单事件绑定

            /*
             * 设备日程模块
             */
            $("#enorder_equ_link").click(enorder_equ_tab_add);//设备预约管理菜单事件绑定
            $("#ordered_equ_link").click(ordered_equ_tab_add);//已预约设备列表菜单事件绑定

            /*
             * 实验室日程模块
             */
            $("#enorder_lab_link").click(enorder_lab_tab_add);//可预约实验室菜单事件绑定
            $("#ordered_lab_link").click(ordered_lab_tab_add);//已预约实验室列表菜单事件绑定

            /*
            * 角色模块
            */
            $("#roleadd_link").click(role_add_tab_add);//添加角色菜单事件绑定
            /*
             * 用户模块
             */
            $("#userlist_link").click(user_list_tab_add);//用户列表菜单事件绑定
            $("#useradd_link").click(user_add_tab_add);//添加用户菜单事件绑定
            $("#user_remove_link").click(user_list_tab_add);//删除用户菜单事件绑定
            $("#mod_user_role_link").click(user_list_tab_add);//删除用户菜单事件绑定
            /*
             * 用户个人管理模块
             */
            $("#modify_user_info_link").click(modify_user_info_tab_add);//添加用户信息修改菜单事件绑定
            $("#modify_user_pwd_link").click(modify_user_pwd_tab_add);//添加用户密码修改菜单事件绑定


            /**
             * 退出按钮单击事件处理
             */
            function index_logout(){
                delCookie("uid");
                delCookie("token");
                delCookie("uname");
                delCookie("role");
                //window.open('about:blank','_self').close();//关闭当前页面
                window.location.reload();
            }

            /**
             * 单击添加用户菜单事件
             */
            function user_add_tab_add(){
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
            function equ_add_tab_add(){
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
            function lab_add_tab_add(){
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
            function role_add_tab_add(){
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
            function user_remove_tab_add(){
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
            function user_list_tab_add(){
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
             * 查询用户列表菜单事件
             */
            function search_user_list_tab_add(){
                if($("#index_tt").tabs("exists","查询用户")){
                    $("#index_tt").tabs("select","查询用户");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"查询用户",
                        closable:true,
                        href:"./user/search_user.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 实验室列表菜单事件
             */
            function lab_list_tab_add(){
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

            /**
             * 实验室搜索菜单事件
             */
            function lab_search_list_tab_add(){
                if($("#index_tt").tabs("exists","实验室/设备查询")){
                    $("#index_tt").tabs("select","实验室/设备查询");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"实验室/设备查询",
                        closable:true,
                        href:"./lab/search_lab.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 实验室负责人管理菜单事件
             */
            function lab_mgr_tab_add(){
                if($("#index_tt").tabs("exists","实验室负责人管理")){
                    $("#index_tt").tabs("select","实验室负责人管理");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"实验室负责人管理",
                        closable:true,
                        href:"./lab/mgr_lab.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 实验室负责人管理菜单事件
             */
            function equ_list_tab_add(){
                if($("#index_tt").tabs("exists","设备列表")){
                    $("#index_tt").tabs("select","设备列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"设备列表",
                        closable:true,
                        href:"./equ/list_equ.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 可预约实验室管理菜单事件
             */
            function enorder_lab_tab_add(){
                if($("#index_tt").tabs("exists","实验室预约")){
                    $("#index_tt").tabs("select","实验室预约");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"实验室预约",
                        closable:true,
                        href:"./lab/enorder_lab_list.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 实验室已预约列表菜单事件
             */
            function ordered_lab_tab_add(){
                if($("#index_tt").tabs("exists","已预约实验室列表")){
                    $("#index_tt").tabs("select","已预约实验室列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"已预约实验室列表",
                        closable:true,
                        href:"./lab/ordered_lab_list.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 设备报修菜单事件
             */
            function break_equ_tab_add() {
                if($("#index_tt").tabs("exists","设备报修")){
                    $("#index_tt").tabs("select","设备报修");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"设备报修",
                        closable:true,
                        href:"./equ/break_equ.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 报修设备列表菜单事件
             */
            function break_equ_list_tab_add() {
                if($("#index_tt").tabs("exists","报修设备列表")){
                    $("#index_tt").tabs("select","报修设备列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"报修设备列表",
                        closable:true,
                        href:"./equ/break_equ_list.jsp",
                        fit:true
                    });
                }
            }

            /**
             * 可预约设备管理菜单事件
             */
            function enorder_equ_tab_add(){
                if($("#index_tt").tabs("exists","设备预约")){
                    $("#index_tt").tabs("select","设备预约");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"设备预约",
                        closable:true,
                        href:"./equ/enorder_equ_list.jsp",
                        fit:true
                    });
                }
            }
            /**
             * 设备已预约列表菜单事件
             */
            function ordered_equ_tab_add(){
                if($("#index_tt").tabs("exists","已预约设备列表")){
                    $("#index_tt").tabs("select","已预约设备列表");
                }else{
                    $("#index_tt").tabs('add',{
                        title:"已预约设备列表",
                        closable:true,
                        href:"./equ/ordered_equ_list.jsp",
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
    <div data-options="region:'north',split:false,collapsible:false" style="height:70px;">
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
    <div data-options="region:'east',title:'备注',split:true,collapsible:true,resizable:true," closed="true"  style="width:100px;">

    </div>
    <div data-options="region:'west',title:'功能导航',split:false,collapsible:true" style="width:150px;">
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div title="基础功能" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="labsearch_link" href="javascript:;">实验室<b>/</b>设备查询</a></li>
                    <li><a id="search_ordered_equ_link" href="javascript:;">已预约设备查询</a></li>
                    <li><a id="search_ordered_lab_link" href="javascript:;">已预约实验室查询</a></li>
                    <li><a id="search_user_list_link" href="javascript:;">用户查询</a></li>
                </ul>
            </div>
            <div title="设备管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="equlist_link" href="javascript:;">设备列表</a></li>
                    <li><a id="equadd_link" href="javascript:;">设备采购(添加)</a></li>
                    <li><a id="equ_move_link" href="javascript:;" title="已经在列表中实现">设备转移(分配)</a></li>
                    <li><a id="equ_remove_link" href="javascript:;" title="已经在列表中实现">设备注销</a></li>
                    <li><a id="equ_break_link" href="javascript:;" title="已经在列表中实现">设备报修</a></li>
                    <li><a id="equ_break_list_link" href="javascript:;">报修设备列表</a></li>
                </ul>
            </div>
            <div title="实验室管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="lablist_link" href="javascript:;">实验室列表</a></li>
                    <li><a id="labadd_link" href="javascript:;">实验室添加</a></li>
                    <li><a id="lab_remove_link" href="javascript:;" title="已经在列表中实现">实验室移除</a></li>
                    <li><a id="labmgr_link" href="javascript:;">实验室负责人</a></li>
                </ul>
            </div>
            <div title="设备日程管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="enorder_equ_link" href="javascript:;">设备预约</a></li>
                    <li><a id="ordered_equ_link" href="javascript:;">已预约列表</a></li>
                </ul>
            </div>
            <div title="实验室日程管理" data-options="border:false,iconCls:'anchor'">
                <ul>
                    <li><a id="enorder_lab_link" href="javascript:;">实验室预约</a></li>
                    <li><a id="ordered_lab_link" href="javascript:;">已预约列表</a></li>
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
                    <li><a id="user_remove_link" href="javascript:;" title="已经在列表中实现">用户删除</a></li>
                    <li><a id="mod_user_role_link" href="javascript:;" title="已经在列表中实现">用户授权管理(角色)</a></li>
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