<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#user_list').datagrid({
            url: './user/user_list.do',
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect:false,
            idField: 'uid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'uname',
            sortOrder: 'asc',
            columns: [[
                {field:'ck',checkbox:"true"},
                {field: 'uname', title: '用户名', width: 100, sortable: true},
                {field: 'tureName', title: '真实姓名', width: 100, sortable: true},
                {field: 'officeAddress', title: '办公室', width: 100},
                {field: 'officePhone', title: '电话', width: 100},
                {field: 'email', title: '邮箱', width: 100},
                {
                    field: 'userRole',
                    title: '角色',
                    width: 100,
                    formatter: function (userRole, rec, index) {
                        if (userRole.role) {
                            return userRole.role.rname;
                        }
                    },
                    sortable: true,
                    fixed: true
                },
                {
                    field: 'createtime',
                    title: '创建时间',
                    width: 160,
                    formatter: function (createtime, rec, index) {
                        if (createtime != null) {
                            var unixTimestamp = new Date(createtime);
                            return unixTimestamp.toLocaleString();
                        }
                    },
                    sortable: true,
                    fixed: true
                }
            ]],
            toolbar:['-',{
                text:'增加',
                iconCls:'icon-edit',
                handler:function(){
                    $("#user_dialog").dialog({
                        title: '用户添加',
                        width: 650,
                        height: 430,
                        href: './user/add_user.jsp',
                        modal: true
                    });
//                    $('#user_list').datagrid('load');
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                    del_user();
                }
            }]
        });

        $("#search_user_btn").click(search_user);//绑定查询事件
        $("#reset_search_user_btn").click(reset_search_user);

        /**
         * 删除用户
         */
        function del_user(){
            var del_userlist=$('#user_list').datagrid('getSelections');
            var del_list='';
            for(var i=0;i<del_userlist.length;i++){
                var selected=del_userlist[i];
                del_list+=selected['uid']+' ';
            }
            del_list.trim();
            $.ajax({
                url: "./user/userdel.do",
                type: "post",
                data:{"delList":del_list},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message+"，已删除"+result.data+"条数据");
                        $('#user_list').datagrid('load');
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "删除用户异常");
                },
                async: true
            });
        }

        /**
         * 条件查询
         */
        function search_user() {
            var uname = $("#search_uname").val().trim();
            var truename = $("#search_truename").val().trim();
            var rname = $("#search_rname").val().trim();
            $('#user_list').datagrid('load', {
                uname: uname,
                tureName:truename,
                rname: rname
            });
        }

        /**
         * 清空条件查询
         */
        function reset_search_user() {
            $("#search_uname").val("");
            $("#search_truename").val("");
            $("#search_rname").val("");
            $('#user_list').datagrid('load',{});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px" >
                &emsp;<b>登录名查询</b><input id="search_uname" class="easyui-validatebox">&emsp;
                &emsp;<b>真实姓名查询</b><input id="search_truename" class="easyui-validatebox">&emsp;
                &emsp;<b>角色查询</b><input id="search_rname" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="search_user_btn" type="button" value="查询">
                <input id="reset_search_user_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="user_grid" data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <div id="user_dialog" style="overflow: hidden"></div>
        <table id="user_list"></table>
    </div>
</div>
