<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var mod_userinfo_uid_auth = getCookie("uid");
        var mod_userinfo_token_auth = getCookie("token");
        if(mod_userinfo_uid_auth==null||mod_userinfo_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }

        $("#mod_userinfo_btn").click(moduserinfo);//添加用户按钮事件绑定
        $("#moduserinfo_reset_btn").click(moduserinfo_reset)
        moduserinfo_load();

        /**
         * 用户信息修改页面回车键事件绑定
         */
        $("#moduserinfo_officephone").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                moduserinfo();
            }
        });
        //用户信息显示
        function moduserinfo_load() {
            var moduserinfo_uid=getCookie("uid");
            $.ajax({
                url: "./user/getuserinfo.do",
                type: "post",
                data:{
                    "uid":moduserinfo_uid,
                    "auth_uid": mod_userinfo_uid_auth,
                    "auth_token": mod_userinfo_token_auth
                },
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $("#moduserinfo_namebox").val(result.data.uname);
                        $("#moduserinfo_truenamebox").val(result.data.tureName);
                        $("#moduserinfo_emailbox").val(result.data.email);
                        $("#moduserinfo_officeaddress").val(result.data.officeAddress);
                        $("#moduserinfo_officephone").val(result.data.officePhone);
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "获取用户信息异常");
                },
                async: true
            });
        }
        //用户信息修改
        function moduserinfo() {
            var moduserinfo_uid=getCookie("uid");
            if(moduserinfo_uid==null){
                $.messager.alert('警告', "非法操作");
            }

            var moduserinfo_emailbox = $("#moduserinfo_emailbox").val();
            var moduserinfo_officeaddress = $("#moduserinfo_officeaddress").val();
            var moduserinfo_officephone=$("#moduserinfo_officephone").val();

            $.ajax({
                url: "./user/modfifyuserinfo.do",
                type: "post",
                data:{
                    "uid":moduserinfo_uid,
                    "email":moduserinfo_emailbox,
                    "officeAddress":moduserinfo_officeaddress,
                    "officePhone":moduserinfo_officephone,
                    "auth_uid": mod_userinfo_uid_auth,
                    "auth_token": mod_userinfo_token_auth
                },
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                        moduserinfo_reset();
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "修改用户信息异常");
                },
                async: true
            });
        }

        function moduserinfo_reset() {
            $("#moduserinfo_emailbox").val("");
            $("#moduserinfo_officeaddress").val("");
            $("#moduserinfo_officephone").val("");
        }
    });

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">用户信息变更</h3>
        <hr>
        <tr>
            <th>登录名</th><%--显示，不可修改--%>
            <td>
                <input id="moduserinfo_namebox" type="text" disabled="disabled" class="easyui-validatebox"
                       data-options="required:true" style="color: red">
            </td>
        </tr>
        <tr>
            <th>真实姓名</th><%--显示，普通用户不可修改，管理员可以修改--%>
            <td>
                <input id="moduserinfo_truenamebox" type="text" disabled="disabled" class="easyui-validatebox"
                       data-options="required:true" style="color: red">
            </td>
        </tr>
        <tr>
            <th>邮箱</th>
            <td>
                <input id="moduserinfo_emailbox" type="text" placeholder="请输入邮箱" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>办公室</th>
            <td>
                <input id="moduserinfo_officeaddress" type="text" placeholder="请输入办公室地址" class="easyui-validatebox"
                       data-options="">
            </td>
        </tr>
        <tr>
            <th>联系电话</th>
            <td>
                <input id="moduserinfo_officephone" type="text" placeholder="请输入联系电话" class="easyui-validatebox"
                       data-options="">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dialog-button">
                    <a id="moduserinfo_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="mod_userinfo_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">修改</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>