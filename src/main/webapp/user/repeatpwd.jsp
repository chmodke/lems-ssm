<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var vali_code="";//验证码
        var flag=false;//本地存储用户名校验状态
        $("#moduser_passwd_btn").click(moduser_passwd);//添加用户按钮事件绑定
        $("#moduser_passwd_reset_btn").click(moduser_passwd_reset);
        $("#send_vali_code_btn").click(send_vali_code);
        $("#moduser_passbox2").keyup(vali_passwd_box);//校验密码一致
        $("#moduser_pwd_unamebox").blur(validation_modpqsswduser);//校验用户名是否存在

        $("#moduser_pwd_unamebox").focus(function(){
            $("#moduser_pwd_unamebox_msg").text("");
        });

        /**
         * 注册页面回车键事件绑定
         */
        $("#adduser_emailbox").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                moduser_passwd();
            }
        });
        //验证用户名是否注册
        function validation_modpqsswduser() {
            flag= false;
            var moduser_pwd_unamebox = $("#moduser_pwd_unamebox").val();
            if(moduser_pwd_unamebox!=null&&moduser_pwd_unamebox!=""){
                $.ajax({
                    url: "./user/useradd_validation.do",
                    type: "post",
                    data:{"uname":moduser_pwd_unamebox},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            $("#moduser_pwd_unamebox_msg").text(result.message);
                            flag= false;//将校验状态保存至本地减少ajax次数
                        }else {
                            flag= true;
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "校验用户名异常");
                    },
                    async: true
                });
            }
        }
        /**
         * 校验两次输入的密码是否一致
         */
        function vali_passwd_box(){
            var moduser_passwd1=$("#moduser_passbox1").val();
            var moduser_passwd2=$("#moduser_passbox2").val();
            if(!(moduser_passwd1===moduser_passwd2)){
                $("#moduser_pwd_passwdbox2_msg").text("两次输入密码不一致");
                return false;
            }else {
                $("#moduser_pwd_passwdbox2_msg").text("");
                return true;
            }
        }
        /**
         * 请求发送验证邮件
         */
        function send_vali_code() {
            if(flag){
                vali_code="";
                var moduser_pwd_uname = $("#moduser_pwd_unamebox").val();
                $.ajax({
                    url: "./user/send_vali_code.do",
                    type: "post",
                    data:{"uname":moduser_pwd_uname},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            vali_code=result.data;//将返回的验证码填入全局变量vali_coed中
                        }else {
                            $.messager.alert('警告', "系统异常请稍后重试");
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "请求验证码异常");
                    },
                    async: true
                });
                $.messager.alert("提示","验证邮件已发送，请前往邮箱查收(注意：请勿重复点击获取按钮)");
            }else {
                $.messager.alert("警告","检查用户名");
            }
        }

        /**
         * 验证输入的验证码是否匹配
         * @returns {boolean}
         */
        function vali_valicode() {
            var moduser_pwd_vali_code = $("#moduser_pwd_valibox").val();
            if(vali_code===moduser_pwd_vali_code&&vali_code!=null&&vali_code!=""){
                return true;
            }else {
                return false;
            }
        }
        //重置密码
        function moduser_passwd() {
            var moduser_pwd_uname = $("#moduser_pwd_unamebox").val();
            var moduser_passwd1=$("#moduser_passbox1").val();
            if(vali_passwd_box()&&vali_valicode()&&flag){
                var moduser_passwd_msg = moduser_pwd_uname + ":" + moduser_passwd1;
                var base64_adduser_msg = Base64.encode(moduser_passwd_msg);

                $.ajax({
                    url: "./user/moduser_pwd.do",
                    type: "post",
                    // data:{"uname":name,"passwd":pwd},
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("Authorization_moduser_passwd", "Basic " + base64_adduser_msg);
                    },
                    success: function (result) {
                        if (result.status == 0) {
                            $.messager.alert('提示', result.message);
                            moduser_passwd_reset();
                            vali_code="";
                            //$("#repeat_dialog").dialog('destroy');
                        }
                        if (result.status != 0) {
                            $.messager.alert('警告', result.message);
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "重置密码异常");
                    },
                    async: true
                });
            }else {
                $.messager.alert('警告', "填写信息有误");
            }
        }

        function moduser_passwd_reset() {
            $("#moduser_pwd_unamebox").val("");
            $("#moduser_pwd_valibox").val("");
            $("#moduser_passbox1").val("");
            $("#moduser_passbox2").val("");
            $("#moduser_pwd_unamebox_msg").text("");
            $("#moduser_pwd_passwdbox2_msg").text("");
            vali_code="";
            flag=false;
        }
    });
</script>
<div id="repeat_dialog">
    <form method="post">
        <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
            <h3 style="text-align: center">重置密码</h3>
            <hr>
            <tr>
                <th>登录名</th>
                <td>
                    <input id="moduser_pwd_unamebox" type="text" placeholder="请输入登录名" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="moduser_pwd_unamebox_msg"></span>
                </td>
            </tr>
            <tr>
                <th>验证码</th>
                <td>
                    <input id="moduser_pwd_valibox" type="text" placeholder="请输入验证码" class="easyui-validatebox"
                           data-options="">
                </td>
                <td>
                    <a id="send_vali_code_btn" href="javascript:;" class="easyui-linkbutton" alt="发送验证码邮件到邮箱">发送验证码</a>
                </td>
            </tr>
            <tr>
                <th>新密码</th>
                <td>
                    <input id="moduser_passbox1" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>重复密码</th>
                <td>
                    <input id="moduser_passbox2" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="moduser_pwd_passwdbox2_msg"></span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="moduser_passwd_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="moduser_passwd_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">重置密码</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>