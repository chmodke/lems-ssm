<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#search_user_list').datagrid({
            url: './user/user_list.do',
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
            ]]
        });

        $("#search_user_btn").click(search_user);//绑定查询事件
        $("#reset_search_user_btn").click(reset_search_user);

        /**
         * 条件查询
         */
        function search_user() {
            var uname = $("#search_user_uname").val().trim();
            var truename = $("#search_user_truename").val().trim();
            var rname = $("#search_user_rname").val().trim();
            uname=(uname==""?undefined:uname);
            truename=(truename==""?undefined:truename);
            rname=(rname==""?undefined:rname);
            $('#search_user_list').datagrid('load', {
                uname: uname,
                tureName: truename,
                rname: rname
            });
        }

        /**
         * 清空条件查询
         */
        function reset_search_user() {
            $("#search_user_uname").val("");
            $("#search_user_truename").val("");
            $("#search_user_rname").val("");
            $('#search_user_list').datagrid('load', {});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                &emsp;<b>用户名查询</b><input id="search_user_uname" class="easyui-validatebox">&emsp;
                &emsp;<b>真实姓名查询</b><input id="search_user_truename" class="easyui-validatebox">&emsp;
                &emsp;<b>角色查询</b><input id="search_user_rname" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="search_user_btn" type="button" value="查询">
                <input id="reset_search_user_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="search_user_grid" data-options="region:'center',collapsible:false"
         style="padding:5px;background:#eee;overflow: hidden">
        <div id="search_user_dialog" style="overflow: hidden">
            <%--用于实现datagrid弹出窗口--%>
        </div>
        <table id="search_user_list"></table>
    </div>
</div>
