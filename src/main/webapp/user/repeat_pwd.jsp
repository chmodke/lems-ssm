<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        //读取登录框中的登录名
        $("#rep_user_pwd_unamebox").val(lems.getDialogParam('login_repeat','repuname'));


        var user_flag = false;//本地存储用户名校验状态,减少ajax次数
        var vali_flag = false;
        $("#rep_user_passwd_btn").click(rep_user_passwd);//重置用户密码按钮事件绑定
        $("#rep_user_passwd_reset_btn").click(rep_user_passwd_reset);
        $("#send_vali_code_btn").click(send_vali_code);
        $("#rep_user_passbox1").keyup(vali_passwd_box);//校验密码一致
        $("#rep_user_passbox2").keyup(vali_passwd_box);//校验密码一致
        $("#rep_user_pwd_unamebox").blur(validation_rep_pqsswduser);//校验用户名是否存在

        //模拟一次单击事件，一次失去焦点事件，触发用户名校验
        $("#rep_user_pwd_unamebox").focus();
        $("#rep_user_pwd_unamebox").blur();

        //当用户名框获得焦点时，移除错误信息
        $("#rep_user_pwd_unamebox").focus(function () {
            $("#rep_user_pwd_unamebox_msg").text("");
        });

        //当验证码框失去焦点时校验验证码
        $("#rep_user_pwd_valibox").blur(function () {
            var rep_valiCode=$("#rep_user_pwd_valibox").val()
            if(rep_valiCode==""||rep_valiCode==null){
                return;
            }else {
                vali_valiCode();
            }
        });

        /**
         * 注册页面回车键事件绑定
         */
        $("#rep_user_passbox2").keydown(function (event) {
            var keyCode = event.keyCode;
            if (keyCode == 13) {
                rep_user_passwd();
            }
        });

        //验证用户名是否注册
        function validation_rep_pqsswduser() {
            user_flag = false;
            vali_flag = false;
            var rep_user_pwd_unamebox = $("#rep_user_pwd_unamebox").val();
            if (rep_user_pwd_unamebox != null && rep_user_pwd_unamebox != "") {
                $.ajax({
                    url: "./user/useradd_validation.do",//利用添加用户逻辑中的用户名校验方法
                    type: "post",
                    data: {"uname": rep_user_pwd_unamebox},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            $("#rep_user_pwd_unamebox_msg").text(result.message);
                            user_flag = false;//将校验状态保存至本地减少ajax次数
                        } else {
                            user_flag = true;
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "校验用户名异常");
                        user_flag = false;
                    },
                    async: true
                });
            }
        }

        /**
         * 校验两次输入的密码是否一致
         */
        function vali_passwd_box() {
            var rep_user_passwd1 = $("#rep_user_passbox1").val();
            var rep_user_passwd2 = $("#rep_user_passbox2").val();
            if (!(rep_user_passwd1 === rep_user_passwd2)) {
                $("#rep_user_pwd_passwdbox2_msg").text("两次输入密码不一致");
                return false;
            } else if (rep_user_passwd1 == "" || rep_user_passwd2 == "" || rep_user_passwd1 == null || rep_user_passwd2 == null) {
                $("#rep_user_pwd_passwdbox2_msg").text("密码不可为空");
                return false;
            } else {
                $("#rep_user_pwd_passwdbox2_msg").text("");
                return true;
            }
        }

        /**
         * 请求发送验证邮件
         */
        function send_vali_code() {
            if (user_flag) {
                var rep_user_pwd_uname = $("#rep_user_pwd_unamebox").val();
                $.ajax({
                    url: "./user/send_vali_code.do",
                    type: "post",
                    data: {"uname": rep_user_pwd_uname},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            $.messager.alert("提示", "验证邮件已发送，请前往邮箱查收(注意：请勿重复点击获取按钮)");
                            $("#rep_user_pwd_unamebox").attr("disabled","disabled");//在发送验证码后禁止修改用户名
                        } else {
                            $.messager.alert('警告', "系统异常请稍后重试");
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "请求验证码异常");
                    },
                    async: true
                });
            } else {
                $.messager.alert("警告", "检查用户名");
            }
        }

        /**
         * 验证输入的验证码是否匹配
         * @returns
         */
        function vali_valiCode() {
            if (user_flag) {
                var rep_user_pwd_vali_code = $("#rep_user_pwd_valibox").val();
                var rep_user_pwd_uname = $("#rep_user_pwd_unamebox").val();
                $.ajax({
                    url: "./user/vali_vali_code.do",
                    type: "post",
                    data: {"uname":rep_user_pwd_uname,"valiCode": rep_user_pwd_vali_code},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            vali_flag = true;
                        } else {
                            $.messager.alert('警告', result.message);
                            vali_flag = false;
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "校验验证码异常");
                        vali_flag = false;
                    },
                    async: false//需要同步请求
                });
            } else {
                $.messager.alert("警告", "检查用户名");
                vali_flag = false;
            }
        }

        //重置密码
        function rep_user_passwd() {
            var rep_user_pwd_uname = $("#rep_user_pwd_unamebox").val();
            var rep_user_passwd1 = $("#rep_user_passbox1").val();
            if (vali_passwd_box() && vali_flag && user_flag) {
                var rep_user_passwd_msg = rep_user_pwd_uname + ":" + rep_user_passwd1;
                var base64_rep_user_passwd_msg = Base64.encode(rep_user_passwd_msg);

                $.ajax({
                    url: "./user/rep_user_pwd.do",
                    type: "post",
                    // data:{"uname":name,"passwd":pwd},
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("Authorization_rep_user_passwd", "Basic " + base64_rep_user_passwd_msg);
                    },
                    success: function (result) {
                        if (result.status == 0) {
                            $.messager.alert('提示', result.message);
                            $("#login_repeat").dialog('destroy');
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
            } else {
                $.messager.alert('警告', "填写信息有误");
            }
        }

        //重置输入框的内容
        function rep_user_passwd_reset() {
            $("#rep_user_pwd_unamebox").val("");
            $("#rep_user_pwd_valibox").val("");
            $("#rep_user_passbox1").val("");
            $("#rep_user_passbox2").val("");
            $("#rep_user_pwd_unamebox_msg").text("");
            $("#rep_user_pwd_passwdbox2_msg").text("");
            user_flag = false;
            vali_flag = false;
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
                    <input id="rep_user_pwd_unamebox" type="text" placeholder="请输入登录名" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td style="width:100px;margin-left: 20px">
                    <span style="color:red;margin-left: 10px" id="rep_user_pwd_unamebox_msg"></span>
                </td>
            </tr>
            <tr>
                <th>验证码</th>
                <td>
                    <input id="rep_user_pwd_valibox" type="text" placeholder="请输入验证码" class="easyui-validatebox"
                           data-options="">
                </td>
                <td>
                    <a id="send_vali_code_btn" href="javascript:;" class="easyui-linkbutton" alt="发送验证码邮件到邮箱">发送验证码</a>
                </td>
            </tr>
            <tr>
                <th>新密码</th>
                <td>
                    <input id="rep_user_passbox1" type="password" placeholder="请输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td></td>
            </tr>
            <tr>
                <th>重复密码</th>
                <td>
                    <input id="rep_user_passbox2" type="password" placeholder="请再次输入密码" class="easyui-validatebox"
                           data-options="required:true">
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="rep_user_pwd_passwdbox2_msg"></span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="rep_user_passwd_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="rep_user_passwd_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">重置密码</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>