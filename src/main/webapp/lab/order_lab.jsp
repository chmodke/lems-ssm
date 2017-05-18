<%--预约实验室窗口--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var order_lab_uid_auth = getCookie("uid");
        var order_lab_token_auth = getCookie("token");
        if(order_lab_uid_auth==null||order_lab_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }

        var order_lab_lid = lems.getDialogParam('enorder_lab_dialog', 'order_lab_lid');
        $("#order_lab_id").val(lems.getDialogParam('enorder_lab_dialog', 'order_lab_id'));
        $("#order_lab_lname").val(lems.getDialogParam('enorder_lab_dialog', 'order_lab_lname'));

        $("#order_lab_reset_btn").click(order_lab_reset);
        $("#order_lab_btn").click(order_lab);

        function order_lab_reset() {
            $("#order_lab_stime").val("");
            $("#order_lab_etime").val("");
            $("#order_lab_user").val("");
            $("#order_lab_tel").val("");
        }

        function order_lab() {
            var order_lab_stime = $("#order_lab_stime").datetimebox('getValue');
            var order_lab_etime = $("#order_lab_etime").datetimebox('getValue');
            var order_lab_user = $("#order_lab_user").val().trim();
            var order_lab_tel = $("#order_lab_tel").val().trim();
            $.ajax({
                url: "./lab/order_lab.do",
                type: "post",
                data: {
                    "lid": order_lab_lid,
                    "starttime": order_lab_stime,
                    "endtime": order_lab_etime,
                    "sname": order_lab_user,
                    "stel": order_lab_tel,
                    "auth_uid": order_lab_uid_auth,//认证条件
                    "auth_token": order_lab_token_auth//认证条件

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
            <h3 style="text-align: center">实验室预约</h3>
            <hr>
            <tr>
                <th>实验室编号</th>
                <td>
                    <input id="order_lab_id" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>实验室名称</th>
                <td>
                    <input id="order_lab_lname" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>起始时间</th>
                <td>
                    <input id="order_lab_stime" placeholder="请输入预约起始时间" class="easyui-datetimebox"
                           data-options="required:true" editable="false"><%--,showSeconds:false--%>
                </td>
            </tr>
            <tr>
                <th>截止时间</th>
                <td>
                    <input id="order_lab_etime" placeholder="请输入预约截止时间" class="easyui-datetimebox"
                           data-options="required:true" editable="false"><%--,showSeconds:false--%>
                </td>
                <td style="width:130px;margin-left: 80px">
                    <span style="color:red;margin-left: 10px" id="order_lab_etime_msg"></span>
                </td>
            </tr>
            <tr>
                <th>预约人</th>
                <td>
                    <input id="order_lab_user" type="text" placeholder="请输入预约人" class="easyui-validatebox"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>联系方式</th>
                <td>
                    <input id="order_lab_tel" type="text" placeholder="请输入联系方式" class="easyui-validatebox">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="order_lab_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="order_lab_btn" class="l-btn">
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