<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#dg').datagrid({
            title:"可用用户列表",
            url:'datagrid_data.json',
            columns:[[
                {field:'code',title:'用户名',width:100},
                {field:'name',title:'角色',width:100},
                {field:'price',title:'真实姓名',width:100},
                {field:'price',title:'操作',width:100}
            ]],
            singleSelect:true,
            collapsible:false,
            method:'get'
        });
    });
</script>
<form method="post">
    <table id="dg" title="可用用户列表" style="width:700px;height:250px">
    </table>

</form>