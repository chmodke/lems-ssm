<%--lab/ordered_lab_list.jsp--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var ordered_lab_uid_auth = getCookie("uid");
        var ordered_lab_token_auth = getCookie("token");
        if(ordered_lab_uid_auth==null||ordered_lab_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        $('#ordered_lab_list').datagrid({
            url: './labs/ordered_lab_list.do',
            queryParams: {//认证条件
                auth_uid: ordered_lab_uid_auth,
                auth_token: ordered_lab_token_auth
            },
            pagination: true,
            fit: true,
            fitColumns: false,
            singleSelect: true,
            idField: 'lid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'lname',
            sortOrder: 'asc',
            columns: [[
                {field: 'id', title: '实验室编号', width: 80, sortable: true},
                {field: 'lname', title: '实验室名称', width: 80, sortable: true},

                {field: 'sname', title: '预约人姓名', width: 80, sortable: true},
                {field: 'stel', title: '预约人电话', width: 100},
                {
                    field: 'starttime', title: '开始时间', width: 130,
                    formatter: function (starttime, rec, index) {
                        if (starttime != null) {
                            var unixTimestamp = new Date(starttime);
                            return unixTimestamp.toLocaleString();
                        }
                    },
                    sortable: true,
                    fixed: true
                },
                {
                    field: 'endtime', title: '结束时间', width: 130,
                    formatter: function (endtime, rec, index) {
                        if (endtime != null) {
                            var unixTimestamp = new Date(endtime);
                            return unixTimestamp.toLocaleString();
                        }
                    },
                    sortable: true,
                    fixed: true
                },

                {field: 'type', title: '实验室类型', width: 80, sortable: true},
                {field: 'lsize', title: '学生容量(人)', width: 80},
                {field: 'equcount', title: '设备容量(台)', width: 80},
                {field: 'uname', title: '实验室负责人', width: 100, sortable: true},
                {field: 'remark', title: '备注', width: 100}
            ]],
            onLoadSuccess:function (result) {
                if (result.status!=0){
                    $.messager.alert('警告', result.message);
                    setTimeout(function () {
                        window.location.reload();
                    }, 3000);
                }
            }
        });

        $("#ordered_lab_search_btn").click(ordered_lab_search);//绑定查询事件
        $("#ordered_lab_search_reset_btn").click(ordered_lab_search_reset);


        /**
         * 条件查询
         */
        function ordered_lab_search() {
            var ordered_lname = $("#ordered_lab_search_lname").val().trim();
            var ordered_id = $("#ordered_lab_search_id").val().trim();
            var ordered_type = $("#ordered_lab_search_type").val().trim();
            var ordered_sname = $("#ordered_lab_search_sname").val().trim();
            ordered_lname=(ordered_lname==""?undefined:ordered_lname);
            ordered_id=(ordered_id==""?undefined:ordered_id);
            ordered_type=(ordered_type==""?undefined:ordered_type);
            ordered_sname=(ordered_sname==""?undefined:ordered_sname);
            $('#ordered_lab_list').datagrid('load', {
                lname: ordered_lname,
                id: ordered_id,
                type: ordered_type,
                sname: ordered_sname,
                auth_uid: ordered_lab_uid_auth,//认证条件
                auth_token: ordered_lab_token_auth//认证条件
            });
        }

        /**
         * 清空条件查询
         */
        function ordered_lab_search_reset() {
            $("#ordered_lab_search_lname").val("");
            $("#ordered_lab_search_id").val("");
            $("#ordered_lab_search_type").val("");
            $("#ordered_lab_search_sname").val("");
            $('#ordered_lab_list').datagrid('load', {
                auth_uid: ordered_lab_uid_auth,//认证条件
                auth_token: ordered_lab_token_auth//认证条件
            });
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px;padding-left: 5px">
                <table>
                    <tr>
                        <td><b>实验室编号查询</b></td>
                        <td><input id="ordered_lab_search_id" class="easyui-validatebox">&emsp;</td>
                        <td><b>实验室名查询</b></td>
                        <td><input id="ordered_lab_search_lname" class="easyui-validatebox">&emsp;</td>
                        <td><b>实验室类型查询</b></td>
                        <td><input id="ordered_lab_search_type" class="easyui-validatebox">&emsp;</td>
                        <td rowspan="2" style="padding-left: 5px">
                            <input id="ordered_lab_search_btn" type="button" value="查询">
                            <input id="ordered_lab_search_reset_btn" type="button" value="清空">&emsp;
                        </td>
                    </tr>
                    <tr>
                        <td><b>预约人姓名查询</b></td>
                        <td><input id="ordered_lab_search_sname" class="easyui-validatebox">&emsp;</td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
    <div id="ordered_lab_grid" data-options="region:'center',collapsible:false"
         style="padding:5px;background:#eee;overflow: hidden">
        <div id="ordered_lab_dialog" style="overflow: hidden"></div>
        <table id="ordered_lab_list"></table>
    </div>
</div>
