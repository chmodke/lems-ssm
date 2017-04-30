<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LEMS_WELCOME</title>
    <%--<script type="text/javascript" src="./jslib/jquery-easyui-1.5.1/jquery.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="./jslib/jquery-easyui-1.5.1/jquery.easyui.min.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" href="./jslib/jquery-easyui-1.5.1/themes/default/easyui.css">
    <script src="./jslib/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" charset="UTF-8"></script>
    <script type="text/javascript" src="jslib/lems-util.js" charset="UTF-8"></script>--%>
    <script type="text/javascript" charset="utf-8">
        $(function() {
            /**
             * 初始化日历组件
             */
            $('#layout_east_calendar').calendar({
                fit : false,
                current : new Date(),
                border : false,
                onSelect : function(date) {
                    $(this).calendar('moveTo', new Date());
                }

            });
        });
        /**
         * 显示本地时钟
         */
        function time() {
            var date=new Date();
            var hours=date.getHours();
            var minutes=date.getMinutes();
            var seconds=date.getSeconds();
            if(seconds<10&&minutes<10){
                $("#time").text(hours+":0"+minutes+":0"+seconds);//时间
            }else if(seconds<10){
                $("#time").text(hours+":"+minutes+":0"+seconds);//时间
            }else if(minutes<10){
                $("#time").text(hours+":0"+minutes+":"+seconds);//时间
            }else{
                $("#time").text(hours+":"+minutes+":"+seconds);//时间
            }
        }
        setInterval("time()",1000);//使用字符串执行方法
    </script>
</head>
<body>
    <div style="width:100%">
        <div style="float: left;margin-left: 5px">
            <h1>欢迎使用实验室设备管理系统(LEMS)</h1>
        </div>
        <div id="clock" style="float: right" >
            <div id="layout_east_time" style="width:220px;height: 40px;">
                <h2 id="time" align="center"></h2>
            </div>
            <div id="layout_east_calendar" style="width:230px;height: 180px;margin-right: 5px"></div>
        </div>
    </div>
</body>
</html>
