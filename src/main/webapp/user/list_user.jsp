<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#user_list').datagrid({
            url: './user/user_list.do',
            pagination: true,
            fit: true,
            fitColumns: true,
            idField: 'uid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            columns:[[
                {field: 'uname', title: '用户名', width: 100},
                {field: 'tureName', title: '真实姓名', width: 100},
                {field: 'officeAddress', title: '办公室', width: 100},
                {field: 'officePhone', title: '电话', width: 100},
                {field: 'email', title: '邮箱', width: 100},
                {field: 'userRole',
                    title: '角色',
                    width: 100,
                    formatter:function(userRole, rec, index) {
                    if (userRole.role) {
                        return userRole.role.rname;
                    }
                },
                fixed : true
                },
                {field: 'createtime',
                    title: '创建时间',
                    width: 160,
                    formatter:function(createtime, rec, index) {
                    if (createtime!=null) {
                        var unixTimestamp = new Date(createtime);
                        return unixTimestamp.toLocaleString();
                    }
                },
                fixed : true
                }
            ]]
        });
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>
            <table id="user_serach" class="table table-hover table-condensed">
                <tr>
                    <th style="text-align: right">登录名查询</th>
                    <td>
                        <input class="easyui-validatebox">
                    </td>
                </tr>
                <tr>
                    <th style="text-align: right">创建时间查询查询</th>
                    <td>
                        <input class="easyui-datetimebox" data-options="required:true" editable="false" >至
                        <input class="easyui-datetimebox" data-options="required:true" editable="false">
                    </td>
                </tr>
                <tr>
                    <th style="text-align: right">角色查询</th>
                    <td>
                        <input class="easyui-validatebox">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <input type="button" value="清空">&emsp;
                        <input type="button" value="查询">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <table id="user_list"></table>
    </div>
</div>
