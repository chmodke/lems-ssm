<%--预约实验室窗口--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var mod_mgr_lab_uid_auth = getCookie("uid");
        var mod_mgr_lab_token_auth = getCookie("token");
        if(mod_mgr_lab_uid_auth==null||mod_mgr_lab_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        var mod_mgr_lab_lid = lems.getDialogParam('mgr_lab_dialog', 'mod_mgr_lab_lid');
        $("#mod_mgr_lab_id").val(lems.getDialogParam('mgr_lab_dialog', 'mod_mgr_lab_id'));
        $("#mod_mgr_lab_lname").val(lems.getDialogParam('mgr_lab_dialog', 'mod_mgr_lab_lname'));

        $("#mod_mgr_lab_reset_btn").click(mod_mgr_lab_reset);
        $("#mod_mgr_lab_btn").click(mod_mgr_lab);

        $.ajax({
            url: './user/get_all_user.do',
            dataType: 'json',
            data:{
                "auth_uid": mod_mgr_lab_uid_auth,//认证条件
                "auth_token": mod_mgr_lab_token_auth//认证条件
            },
            timeout: 1000,
            cache: false,
            success: function (result) {
                var data = result.data;
                var dataList, uid, uname;
                dataList = [];
                for(var i=0;i<data.length;i++){
                    uid = data[i].uid;
                    uname = data[i].uname;
                    dataList.push({"id": uid, "text": uname});
                }
                $("#mod_mgr_lab_user").combobox("loadData", dataList);
            },
            error: function () {
                $.messager.alert('警告', "获取实验室管理员异常");
            },
            async: true
        });



        function mod_mgr_lab_reset() {
            $("#order_lab_user").val("");
        }

        function mod_mgr_lab() {
            var mod_mgr_lab_uid_combox=$("#mod_mgr_lab_user").combobox('getValue');
            $.ajax({
                url: "./lab/mod_mgr_lab.do",
                type: "post",
                data: {
                    "lid": mod_mgr_lab_lid,
                    "uid": mod_mgr_lab_uid_combox,
                    "auth_uid": mod_mgr_lab_uid_auth,//认证条件
                    "auth_token": mod_mgr_lab_token_auth//认证条件
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
                    $.messager.alert('警告', "修改实验室管理员异常");
                },
                async: true
            });
        }
    });
</script>
<div id="mod_mgr_lab_dialog">
    <form method="post">
        <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
            <h3 style="text-align: center">实验室管理人修改</h3>
            <hr>
            <tr>
                <th>实验室编号</th>
                <td>
                    <input id="mod_mgr_lab_id" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>实验室名称</th>
                <td>
                    <input id="mod_mgr_lab_lname" type="text" class="easyui-validatebox" editable="false"
                           data-options="required:true">
                </td>
            </tr>
            <tr>
                <th>管理人</th>
                <td>
                    <select id="mod_mgr_lab_user" class="easyui-combobox easyui-validatebox" placeholder="请选择用户"
                            data-options="valueField:'id', textField:'text',panelHeight:'auto'"></select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="dialog-button">
                        <a id="mod_mgr_lab_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                        </a>
                        <a id="mod_mgr_lab_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">修改</span>
                                    </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>