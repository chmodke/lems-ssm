<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var mod_user_uid_auth = getCookie("uid");
        var mod_user_token_auth = getCookie("token");
        if(mod_user_uid_auth==null||mod_user_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }

        var mod_role_uid = lems.getDialogParam('user_dialog', 'mod_role_uid');
        $("#mod_user_role_namebox").val(lems.getDialogParam('user_dialog', 'mod_role_uname'));

        $("#mod_user_role_btn").click(mod_user_role);//添加用户按钮事件绑定
        $("#mod_user_role_reset_btn").click(mod_user_role_reset);

        //动态装载下拉菜单
        $.ajax({
            url: './role/get_all_role.do',
            dataType: 'json',
            data:{
                "auth_uid": mod_user_uid_auth,
                "auth_token": mod_user_token_auth
            },
            cache: false,
            success: function (result) {
                var data = result.data;
                var dataList, rid, rname;
                dataList = [];
                for(var i=0;i<data.length;i++){
                    rid = data[i].rid;
                    rname = data[i].rname;
                    dataList.push({"id": rid, "text": rname});
                }
                $("#mod_user_role_rolebox").combobox("loadData", dataList);
            },
            error: function () {
                $.messager.alert('警告', "获取角色列表异常");
            },
            async: true
        });

        //用户角色修改
        function mod_user_role() {

            var mod_user_role=$("#mod_user_role_rolebox").combobox('getValue');

            $.ajax({
                url: "./user/mod_user_role.do",
                type: "post",
                data:{
                    "uid":mod_role_uid,
                    "rid":mod_user_role,
                    "auth_uid": mod_user_uid_auth,
                    "auth_token": mod_user_token_auth
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
                    $.messager.alert('警告', "修改用户角色异常");
                },
                async: true
            });
        }

        function mod_user_role_reset() {

        }
    });

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">修改用户角色</h3>
        <hr>
        <tr>
            <th>登录名</th>
            <td>
                <input id="mod_user_role_namebox" type="text" placeholder="请输入登录名" class="easyui-validatebox"
                       data-options="required:true" editable="false">
            </td>
        </tr>
        <tr>
            <th>角色</th>
            <td>
                <select id="mod_user_role_rolebox" class="easyui-combobox easyui-validatebox" placeholder="请选择角色"
                        data-options="valueField:'id', textField:'text',panelHeight:'auto'"></select>
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dialog-button">
                    <a id="mod_user_role_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="mod_user_role_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">修改</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>