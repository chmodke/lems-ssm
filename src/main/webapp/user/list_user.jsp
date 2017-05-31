<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var list_user_uid_auth = getCookie("uid");
        var list_user_token_auth = getCookie("token");
        if(list_user_uid_auth==null||list_user_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        $('#user_list').datagrid({
            url: './user/user_list.do',queryParams: {//认证条件
                auth_uid: list_user_uid_auth,
                auth_token: list_user_token_auth
            },
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect: true,
            idField: 'uid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'uname',
            sortOrder: 'asc',
            columns: [[
                {field: 'ck', checkbox: "true"},
                {field: 'uname', title: '用户名', width: 100, sortable: true},
                {field: 'tureName', title: '真实姓名', width: 100, sortable: true},
                {field: 'officeAddress', title: '办公室', width: 100},
                {field: 'officePhone', title: '电话', width: 100},
                {field: 'email', title: '邮箱', width: 100},
                {field: 'rname', title: '角色', width: 100, sortable: true},
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
            onLoadSuccess:function (result) {
                if (result.status!=0){
                    $.messager.alert('警告', result.message);
                    setTimeout(function () {
                        window.location.reload();
                    }, 3000);
                }
            },
            toolbar: ['-', {
                text: '增加',
                iconCls: 'icon-edit',
                handler: function () {
                    $("#user_dialog").dialog({
                        title: '用户添加',
                        width: 650,
                        height: 430,
                        href: './user/add_user.jsp',
                        modal: true,
                        onClose: function () {
                            $('#user_list').datagrid('load', {
                                auth_uid: list_user_uid_auth,
                                auth_token: list_user_token_auth
                            });
                        }
                    });
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    del_user();
                }
            }, '-', {
                text: '修改角色',
                iconCls: 'icon-remove',
                handler: function () {
                    mod_user_role();
                }
            }]
        });

        $("#search_user_list_btn").click(search_user_list);//绑定查询事件
        $("#reset_search_user_list_btn").click(reset_search_user_list);

        /**
         * 删除用户
         */
        function del_user() {
            var del_userlist = $('#user_list').datagrid('getSelections');
            var del_list = '';
            for (var i = 0; i < del_userlist.length; i++) {
                var selected = del_userlist[i];
                del_list += selected['uid'] + ' ';
            }
            del_list.trim();
            $.ajax({
                url: "./user/userdel.do",
                type: "post",
                data: {
                    "delList": del_list,
                    "auth_uid": list_user_uid_auth,
                    "auth_token": list_user_token_auth
                },
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message + "，已删除" + result.data + "条数据");
                        $('#user_list').datagrid('load',{
                            auth_uid: list_user_uid_auth,
                            auth_token: list_user_token_auth
                        });
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
        /*
        * 修改用户角色
        */
        function mod_user_role() {
            var mod_role = $('#user_list').datagrid('getSelected');
            var mod_role_uid = mod_role['uid'];
            var mod_role_uname = mod_role['uname'];
            $("#user_dialog").dialog({
                title: '角色修改',
                width: 650,
                height: 480,
                href: './user/mod_user_role.jsp',
                modal: true,
                params: {
                    'mod_role_uid': mod_role_uid,
                    'mod_role_uname': mod_role_uname
                },//传递参数
                onClose: function () {
                    $('#user_list').datagrid('load',{
                        auth_uid: list_user_uid_auth,
                        auth_token: list_user_token_auth
                    });
                }
            });
        }

        /**
         * 条件查询
         */
        function search_user_list() {
            var uname = $("#search_uname").val().trim();
            var truename = $("#search_truename").val().trim();
            var rname = $("#search_rname").val().trim();
            uname=(uname==""?undefined:uname);
            truename=(truename==""?undefined:truename);
            rname=(rname==""?undefined:rname);
            $('#user_list').datagrid('load', {
                uname: uname,
                tureName: truename,
                rname: rname
            });
        }

        /**
         * 清空条件查询
         */
        function reset_search_user_list() {
            $("#search_uname").val("");
            $("#search_truename").val("");
            $("#search_rname").val("");
            $('#user_list').datagrid('load', {});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                &emsp;<b>用户名查询</b><input id="search_uname" class="easyui-validatebox">&emsp;
                &emsp;<b>真实姓名查询</b><input id="search_truename" class="easyui-validatebox">&emsp;
                &emsp;<b>角色查询</b><input id="search_rname" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="search_user_list_btn" type="button" value="查询">
                <input id="reset_search_user_list_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="user_grid" data-options="region:'center',collapsible:false"
         style="padding:5px;background:#eee;overflow: hidden">
        <div id="user_dialog" style="overflow: hidden">
            <%--用于实现datagrid弹出窗口--%>
        </div>
        <table id="user_list"></table>
    </div>
</div>
