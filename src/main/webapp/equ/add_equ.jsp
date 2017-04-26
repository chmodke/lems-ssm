<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    /*$(function () {
        var add_user_btn = $("#add_user_btn");
        var adduser_reset_btn = $("#adduser_reset_btn");

        add_user_btn.click(add_user);//添加用户按钮事件绑定
        adduser_reset_btn.click(adduser_reset);

//        $("#adduser_namebox").blur(validation_adduser());
        //暂时不启用

        /!**
         * 注册页面回车键事件绑定
         *!/
        $("#adduser_emailbox").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                add_user();
            }
        });
        //验证用户名是否被占用
        function validation_adduser() {
            var adduser_uname = $("#adduser_namebox").val();
            $.ajax({
                url: "./user/useradd_validation.do",
                type: "post",
                data:{"uname":adduser_uname},
                dataType: "json",
                success: function (result) {
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "校验用户名异常");
                },
                async: true
            });
        }
        //用户登录
        function add_user() {
            var adduser_uid=getCookie("uid");
            var adduser_token=getCookie("token");

            if(adduser_uid==null||adduser_token==null){
                $.messager.alert('警告', "非法操作");
            }

            var adduser_uname = $("#adduser_namebox").val();
            var adduser_passwd = $("#adduser_passbox").val();
            var adduser_trueName=$("#adduser_truenamebox").val();
            var adduser_email=$("#adduser_emailbox").val();

            var adduser_msg = adduser_uname + ":" + adduser_passwd + ":"+adduser_trueName+ ":" + adduser_email+":"+adduser_uid;
            var base64_adduser_msg = Base64.encode(adduser_msg);

            $.ajax({
                url: "./user/useradd.do",
                type: "post",
                // data:{"uname":name,"passwd":pwd},
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization_adduser", "Basic " + base64_adduser_msg);
                },
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                        adduser_reset();
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "添加用户异常");
                },
                async: true
            });
        }

        function adduser_reset() {
            $("#adduser_namebox").val("");
            $("#adduser_passbox").val("");
            $("#adduser_truenamebox").val("");
            $("#adduser_emailbox").val("");
        }
    });*/

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">采购设备</h3>
        <hr>
        <tr>
            <th>设备编号</th>
            <td>
                <input id="addequ_serial" type="text" placeholder="请输入设备编号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备名称</th>
            <td>
                <input id="addequ_name" type="text" placeholder="请输入设备名称" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备型号</th>
            <td>
                <input id="addequ_type" type="text" placeholder="请输入设备型号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>采购时间</th>
            <td>
                <input id="addequ_time" type="text" placeholder="请输入采购时间" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>备注</th>
            <td>
                <input id="addequ_remark" type="text" placeholder="请输入备注" class="easyui-validatebox">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dialog-button">
                    <a id="addequ_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="add_equ_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">添加</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>