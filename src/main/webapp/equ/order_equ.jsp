<%--预约实验室窗口--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var move_equ_uid_auth = getCookie("uid");
        var move_equ_token_auth = getCookie("token");
        if (move_equ_uid_auth == null || move_equ_token_auth == null) {
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }

        var order_equ_eid = lems.getDialogParam('enorder_equ_list_dialog', 'order_equ_eid');
        $("#order_equ_id").val(lems.getDialogParam('enorder_equ_list_dialog', 'order_equ_id'));
        $("#order_equ_ename").val(lems.getDialogParam('enorder_equ_list_dialog', 'order_equ_ename'));

        $("#order_equ_reset_btn").click(order_equ_reset);
        $("#order_equ_btn").click(order_equ);

        function order_equ_reset() {
            $("#order_lab_stime").val("");
            $("#order_lab_etime").val("");
            $("#order_lab_user").val("");
            $("#order_lab_tel").val("");
        }

        function order_equ() {
            var order_equ_stime = $("#order_equ_stime").datetimebox('getValue');
            var order_equ_etime = $("#order_equ_etime").datetimebox('getValue');
            var order_equ_user = $("#order_equ_user").val().trim();
            var order_equ_tel = $("#order_equ_tel").val().trim();
            $.ajax({
                url: "./equ/order_equ.do",
                type: "post",
                data: {
                    "eid": order_equ_eid,
                    "starttime": order_equ_stime,
                    "endtime": order_equ_etime,
                    "sname": order_equ_user,
                    "stel": order_equ_tel,
                    "auth_uid": move_equ_uid_auth,
                    "auth_token": move_equ_token_auth
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
                    $.messager.alert('警告', "预约实验室异常");
                },
                async: true
            });
        }
    });
</script>
<div id="order_lab_dialog">
    <form method="post">
        <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
            <h3 style="text-align: center">设备预约</h3>
            <hr>
            <tr>
                <th>设备编号</th>
                <td>
                    <input id="order_equ_id" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>设备名称</th>
                <td>
                    <input id="order_equ_ename" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>起始时间</th>
                <td>
                    <input id="order_equ_stime" placeholder="请输入预约起始时间" class="easyui-datetimebox"
                           data-options="required:true" editable="false"><%--,showSeconds:false--%>
                </td>
            </tr>
            <tr>
                <th>截止时间</th>
                <td>
                    <input id="order_equ_etime" placeholder="请输入预约截止时间" class="easyui-datetimebox"
                           data-options="required:true" editable="false"><%--,showSeconds:false--%>
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="order_lab_etime_msg"></span>
                </td>
            </tr>
            <tr>
                <th>预约人</th>
                <td>
                    <input id="order_equ_user" type="text" placeholder="请输入预约人" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>联系方式</th>
                <td>
                    <input id="order_equ_tel" type="text" placeholder="请输入联系方式" class="easyui-validatebox">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="order_equ_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="order_equ_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">预约</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>