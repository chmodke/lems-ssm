<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var break_equ_uid_auth = getCookie("uid");
        var break_equ_token_auth = getCookie("token");
        if (break_equ_uid_auth == null || break_equ_token_auth == null) {
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }

        var break_equ_eid = lems.getDialogParam('equ_list_dialog', 'break_equ_eid');
        $("#break_equ_id").val(lems.getDialogParam('equ_list_dialog', 'break_equ_id'));
        $("#break_equ_ename").val(lems.getDialogParam('equ_list_dialog', 'break_equ_ename'));


        $("#break_equ_btn").click(break_equ);//添加用户按钮事件绑定
        $("#break_equ_reset_btn").click(break_equ_reset);


        //设备添加
        function break_equ() {
            var break_equ_bid = $("#break_equ_bid").val().trim();
            var break_equ_breason = $("#break_equ_breason").val().trim();
            $.ajax({
                url: "./equ/break_equ.do",
                type: "post",
                data: {
                    "eid": break_equ_eid,
                    "id": break_equ_bid,
                    "breason": break_equ_breason,
                    "auth_uid": break_equ_uid_auth,
                    "auth_token": break_equ_token_auth
                },
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "设备报修异常");
                },
                async: true
            });
        }

        function break_equ_reset() {
            $("#break_equ_bid").val("");
            $("#break_equ_breason").val("");
        }
    });

</script>
<form method="post" id="add_equ_form">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">设备报修</h3>
        <hr>
        <tr>
            <th>设备编号</th>
            <td>
                <input id="break_equ_id" type="text" placeholder="请输入设备编号" class="easyui-validatebox" editable="false"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备名称</th>
            <td>
                <input id="break_equ_ename" type="text" placeholder="请输入设备名称" class="easyui-validatebox"
                       editable="false"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>故障编号</th>
            <td>
                <input id="break_equ_bid" type="text" placeholder="请输入故障编号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>故障原因</th>
            <td>
                <input id="break_equ_breason" type="text" placeholder="请输入故障原因" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="dialog-button">
                    <a id="break_equ_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="break_equ_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">报修</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>
