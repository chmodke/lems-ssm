<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var loginDialog = $("#loginDialog");
        $("#login_btn").click(login);//登录按钮事件绑定
        $("#reset_login_btn").click(reset_login);//重置按钮事件绑定
        $("#repeatpwd_btn").click(function () {//忘记密码按钮事件绑定
            $('#login_repeat').dialog({
                title: '重置密码',
                width:'650px',
                height:'435px',
                closed: false,
                cache: false,
                href: './user/repeat_pwd.jsp',
                queryParams: {'repuname': $("#login_namebox").val() },//传递参数
                modal: true
            });
        });



        //绑定回车键事件
        $("#login_passbox").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                login();
            }
        });

        var uid=getCookie("uid");
        var token=getCookie("token");

        if(uid==null||token==null){
            $("#index_username").text("***");//初始显示用户名称
            $("#index_userrole").text("***");//初始显示用户角色
        }else {
            loginDialog.dialog('destroy');//销毁登录框

            $("#index_username").text(getCookie("uname"));//显示用户名称
            //TODO 显示用户角色
            $("#index_userrole").text(getCookie("uname"));//显示用户角色

            $("#index_logout").html('<a href="javascript:;">安全退出</a>');//显示退出按钮

        }
        //用户登录
        function login() {
            var login_uname = $("#login_namebox").val();
            var login_passwd = $("#login_passbox").val();
            if(login_uname==""||login_uname==""){
                $.messager.alert('警告','用户名为空');
                return;
            }
            if(login_passwd==""||login_passwd==""){
                $.messager.alert('警告','密码为空')
                return;
            }
            var login_msg = login_uname + ":" + login_passwd;
            var base64_login_msg = Base64.encode(login_msg);

            $.ajax({
                url: "./user/login.do",
                type: "post",
                // data:{"uname":name,"passwd":pwd},
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization_login", "Basic " + base64_login_msg);
                },
                success: function (result) {
                    if (result.status == 0) {
                        addCookie("uid", result.data.uid, -1);//添加Cookie
                        addCookie("token",result.data.token,-1);
                        addCookie("uname",result.data.uname,-1);
                        loginDialog.dialog('destroy');
                        $.messager.show({
                            title: '提示',
                            msg: result.data.uname+"，欢迎您，"+result.message+"。",
                            timeout: 5000,
                            showType: 'slide'
                        });
                        $("#index_username").text(getCookie("uname"));//显示用户名称
                        //TODO 显示用户角色
                        $("#index_userrole").text(getCookie("uname"));//显示用户角色

                        $("#index_logout").html('<a href="javascript:;">安全退出</a>')//显示退出按钮
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "登录异常");
                },
                async: true
            });
        }

        function reset_login() {
            $("#login_namebox").val("");
            $("#login_passbox").val("");
        }
    });

</script>
<div id="login_repeat">
<div id="loginDialog" class="easyui-dialog"
     style="width: 315px;height: 210px;overflow: hidden; margin:0px;padding: 10px;padding-bottom: 0px"
     data-options="title: '登录',resizable:false,modal:true,closable:false,closed:false">
    <form method="post">
        <table class="table table-hover table-condensed">
            <tr>
                <th>登录名</th>
                <td>
                    <input id="login_namebox" type="text" placeholder="请输入登录名" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>密码</th>
                <td>
                    <input id="login_passbox" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="repeatpwd_btn" class="l-btn">
                            <span class="l-btn-left">
                                <span class="l-btn-text">忘记密码</span>
                            </span>
                        </a>
                        <a id="reset_login_btn" class="l-btn">
                            <span class="l-btn-left">
                                <span class="l-btn-text">清空</span>
                            </span>
                        </a>
                        <a id="login_btn" class="l-btn" >
                            <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                <span class="l-btn-text">登录</span>
                            </span>
                        </a>

                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
</div>