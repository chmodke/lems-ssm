<%--
  Created by IntelliJ IDEA.
  User: hao
  Date: 2017/04/21
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    var loginDialog;
    var login_btn;
    var reset_btn;
    $(function () {
        loginDialog = $("#loginDialog");
        login_btn = $("#login_btn");
        reset_btn = $("#reset_btn");

        login_btn.click(login);
        reset_btn.click(reset);
        var uid=getCookie("uid");
        var token=getCookie("token");
        if(uid!=null&&token!=null){
            loginDialog.dialog('destroy');
        }


        function login() {
            var name = $("#namebox").val();
            var pwd = $("#passbox").val();

            var msg = name + ":" + pwd;
            var base64_msg = Base64.encode(msg);

            $.ajax({
                url: "user/login.do",
                type: "post",
                // data:{"uname":name,"passwd":pwd},
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization", "Basic " + base64_msg);
                },
                success: function (result) {
                    if (result.status == 0) {
                        var uid = result.data.uid;
                        var token=result.data.token;
                        addCookie("uid", uid, );
                        addCookie("token",token,)
                        loginDialog.dialog('destroy');
                        $.messager.show({
                            title: '提示',
                            msg: result.message,
                            timeout: 5000,
                            showType: 'slide'
                        });
                    }
                    if (result.status == 1) {
                        $.messager.alert('警告', result.message);
                    }
                    if (result.status == 2) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    alert("登录异常");
                },
                async: true
            });
        }

        function reset() {
            $("#namebox").val("");
            $("#passbox").val("");
        }
    });

</script>
<div id="loginDialog" class="easyui-dialog"
     style="width: 310px;height: 210px;overflow: hidden; margin:0px;padding: 10px;padding-bottom: 0px"
     data-options="title: '登录',resizable:false,modal:true,closable:false,closed:false">
    <form method="post">
        <table class="table table-hover table-condensed">
            <tr>
                <th>登录名</th>
                <td>
                    <input id="namebox" type="text" placeholder="请输入登录名" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>密码</th>
                <td>
                    <input id="passbox" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="login_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">登录</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>