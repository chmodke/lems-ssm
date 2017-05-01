<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var add_role_btn = $("#add_role_btn");
        var addrole_reset_btn = $("#addrole_reset_btn");

        add_role_btn.click(add_role);//添加用户按钮事件绑定
        addrole_reset_btn.click(addrole_reset);

        $("#addrole_namebox").blur(validation_addrole);
        $("#addrole_namebox").focus(function(){
            $("#addrole_namebox_msg").text("");
        });
        //暂时不启用

        /**
         * 注册页面回车键事件绑定
         */
        $("#addrole_remarkbox").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                add_role();
            }
        });
        //验证用户名是否被占用
        function validation_addrole() {
            var addrole_name = $("#addrole_namebox").val();
            $.ajax({
                url: "./role/roleadd_validation.do",
                type: "post",
                data:{"rname":addrole_name},
                dataType: "json",
                success: function (result) {
                    if (result.status != 0) {
                        $("#addrole_namebox_msg").text(result.message);
//                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "校验角色异常");
                },
                async: true
            });
        }
        //用户添加
        function add_role() {
            var addrole_uid=getCookie("uid");
            var addrole_token=getCookie("token");

            if(addrole_uid==null||addrole_token==null){
                $.messager.alert('警告', "非法操作");
            }

            var addrole_name = $("#addrole_namebox").val();
            var addrole_remark = $("#addrole_remarkbox").val();

            $.ajax({
                url: "./role/roleadd.do",
                type: "post",
                data:{"rname":addrole_name,"remark":addrole_remark},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                        addrole_reset();
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "添加角色异常");
                },
                async: true
            });
        }

        function addrole_reset() {
            $("#addrole_namebox").val("");
            $("#addrole_remarkbox").val("");
        }
    });

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">添加角色</h3>
        <hr>
        <tr>
            <th>角色名</th>
            <td>
                <input id="addrole_namebox" type="text" placeholder="请输入角色名" class="easyui-validatebox"
                       data-options="required:true">
            </td>
            <td style="width:130px;margin-left: 80px">
                <span style="color:red;margin-left: 10px" id="addrole_namebox_msg"></span>
            </td>
        </tr>
        <tr>
            <th>角色注释</th>
            <td>
                <input id="addrole_remarkbox" type="text" placeholder="请输入角色注释" class="easyui-validatebox"
                       data-options="required:true">
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="dialog-button">
                    <a id="addrole_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="add_role_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">添加</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>