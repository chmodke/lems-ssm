<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var vali_flag = false;
        $("#mod_user_passwd_btn").click(mod_user_passwd);//修改用户密码按钮事件绑定
        $("#mod_user_passwd_reset_btn").click(mod_user_passwd_reset);
        $("#mod_user_passbox1").keyup(vali_passwd_box);//校验密码一致
        $("#mod_user_passbox2").keyup(vali_passwd_box);//校验密码一致

        /**
         * 注册页面回车键事件绑定
         */
        $("#mod_user_passbox2").keydown(function (event) {
            var keyCode = event.keyCode;
            if (keyCode == 13) {
                mod_user_passwd();
            }
        });

        /**
         * 校验两次输入的密码是否一致
         */
        function vali_passwd_box() {
            var mod_user_passwd1 = $("#mod_user_passbox1").val();
            var mod_user_passwd2 = $("#mod_user_passbox2").val();
            if (!(mod_user_passwd1 === mod_user_passwd2)) {
                $("#mod_user_pwd_passwdbox2_msg").text("两次输入密码不一致");
                return false;
            } else if (mod_user_passwd1 == "" || mod_user_passwd2 == "" || mod_user_passwd1 == null || mod_user_passwd2 == null) {
                $("#mod_user_pwd_passwdbox2_msg").text("密码不可为空");
                return false;
            } else {
                $("#mod_user_pwd_passwdbox2_msg").text("");
                return true;
            }
        }


        /**
         * 验证输入的原密码是否匹配
         * @returns
         */
        function vali_valiOpwd() {
            var mod_user_pwd_uname=getCookie("uname");
            var mod_user_pwd_opwd = $("#mod_user_pwd_opwd").val();
            var mod_user_pwd_msg = mod_user_pwd_uname + ":" + mod_user_pwd_opwd;
            var base64_mod_user_pwd_msg = Base64.encode(mod_user_pwd_msg);
            $.ajax({
                url: "./user/login.do",
                type: "post",
                //data: {"opwd": base64_mod_user_pwd_msg},
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization_login", "Basic " + base64_mod_user_pwd_msg);
                },
                success: function (result) {
                    if (result.status == 0) {
                        vali_flag = true;
                    } else {
                        $.messager.alert('警告','原密码错误');
                        vali_flag = false;
                    }
                },
                error: function () {
                    $.messager.alert('警告', "校验原密码异常");
                    vali_flag = false;
                },
                async: false
            });
        }

        //重置密码
        function mod_user_passwd() {
            var mod_user_pwd_uname =getCookie("uname");
            var mod_user_passwd1 = $("#mod_user_passbox1").val();
            if(vali_passwd_box()){
                vali_valiOpwd();
                if (vali_flag) {
                    var mod_user_passwd_msg = mod_user_pwd_uname + ":" + mod_user_passwd1;
                    var base64_mod_user_passwd_msg = Base64.encode(mod_user_passwd_msg);

                    $.ajax({
                        url: "./user/rep_user_pwd.do",
                        type: "post",
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("Authorization_rep_user_passwd", "Basic " + base64_mod_user_passwd_msg);
                        },
                        success: function (result) {
                            if (result.status == 0) {
                                $.messager.alert('提示', result.message,"info",function(){
                                    $("#index_logout").click();//模拟单击事件,实现退出重新登录
                                });
                            }
                            if (result.status != 0) {
                                $.messager.alert('警告', result.message);
                            }
                        },
                        error: function () {
                            $.messager.alert('警告', "修改密码异常");
                        },
                        async: true
                    });
                } /*else {
                 $.messager.alert('警告', "填写信息有误");
                 }*/
            }
        }

        function mod_user_passwd_reset() {
            $("#mod_user_pwd_opwd").val("");
            $("#mod_user_passbox1").val("");
            $("#mod_user_passbox2").val("");
            $("#mod_user_pwd_passwdbox2_msg").text("");
            vali_flag = false;
        }
    });
</script>
<div id="modeat_dialog">
    <form method="post">
        <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
            <h3 style="text-align: center">修改密码</h3>
            <hr>
            <tr>
                <th>原密码</th>
                <td>
                    <input id="mod_user_pwd_opwd" type="password" placeholder="请输入原密码" class="easyui-validatebox"
                           data-options="">
                </td>
            </tr>
            <tr>
                <th>新密码</th>
                <td>
                    <input id="mod_user_passbox1" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>重复密码</th>
                <td>
                    <input id="mod_user_passbox2" type="password" placeholder="请再次输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="mod_user_pwd_passwdbox2_msg"></span>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="dialog-button">
                        <a id="mod_user_passwd_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="mod_user_passwd_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">修改密码</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>