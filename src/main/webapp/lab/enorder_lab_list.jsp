<%--lab/enorder_lab_list.jsp--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var enorder_lab_uid_auth = getCookie("uid");
        var enorder_lab_token_auth = getCookie("token");
        if(enorder_lab_uid_auth==null||enorder_lab_token_auth==null){
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        $('#enorder_lab_list').datagrid({
            url: './lab/enorder_lab_list.do',
            queryParams: {//认证条件
                auth_uid: enorder_lab_uid_auth,//认证条件
                auth_token: enorder_lab_token_auth//认证条件
            },
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect: true,
            idField: 'lid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'lname',
            sortOrder: 'asc',
            columns: [[
                {field: 'ck', checkbox: "true"},
                {field: 'id', title: '实验室编号', width: 100, sortable: true},
                {field: 'lname', title: '实验室名称', width: 100, sortable: true},
                {field: 'type', title: '实验室类型', width: 100, sortable: true},
                {field: 'lsize', title: '学生容量(人)', width: 100},
                {field: 'equcount', title: '设备容量(台)', width: 100},
                {field: 'lab_uname', title: '实验室负责人', width: 100, sortable: true},
                {
                    field: 'status',
                    title: '状态',
                    width: 100,
                    formatter: function (status, rec, index) {
                        if (status == 0) {
                            return '可用';
                        }
                        if (status != 0) {
                            return '不可用';
                        }
                    },
                    sortable: true,
                    fixed: true
                },
                {field: 'remark', title: '备注', width: 100}
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
                text: '预约',
                iconCls: 'icon-edit',
                handler: function () {
                    var order_lab = $('#enorder_lab_list').datagrid('getSelected');
                    var order_lab_lid = order_lab['lid'];
                    var order_lab_id = order_lab['id'];
                    var order_lab_lname = order_lab['lname'];
//                    $('#enorder_lab_list').datagrid('clearSelections');//清除选中
                    $("#enorder_lab_dialog").dialog({
                        title: '实验室预约',
                        width: 650,
                        height: 480,
                        href: './lab/order_lab.jsp',
                        params: {
                            'order_lab_lid': order_lab_lid,
                            'order_lab_id': order_lab_id,
                            'order_lab_lname': order_lab_lname
                        },//传递参数
                        modal: true,
                        onClose: function () {
                            $('#enorder_lab_list').datagrid('load', {
                                auth_uid: enorder_lab_uid_auth,//认证条件
                                auth_token: enorder_lab_token_auth//认证条件
                            });
                        },
                    });
                }
            }]
        });

        $("#enorder_lab_search_btn").click(enorder_lab_search);//绑定查询事件
        $("#enorder_lab_search_reset_btn").click(enorder_lab_search_reset);


        /**
         * 条件查询
         */
        function enorder_lab_search() {
            var enorder_lname = $("#enorder_lab_search_lname").val().trim();
            var enorder_id = $("#enorder_lab_search_id").val().trim();
            var enorder_type = $("#enorder_lab_search_type").val().trim();
            enorder_lname=(enorder_lname==""?undefined:enorder_lname);
            enorder_id=(enorder_id==""?undefined:enorder_id);
            enorder_type=(enorder_type==""?undefined:enorder_type);
            $('#enorder_lab_list').datagrid('load', {
                lname: enorder_lname,
                id: enorder_id,
                type: enorder_type,
                auth_uid: enorder_lab_uid_auth,//认证条件
                auth_token: enorder_lab_token_auth//认证条件
            });
        }

        /**
         * 清空条件查询
         */
        function enorder_lab_search_reset() {
            $("#enorder_lab_search_lname").val("");
            $("#enorder_lab_search_id").val("");
            $("#enorder_lab_search_type").val("");
            $('#enorder_lab_list').datagrid('load', {
                auth_uid: enorder_lab_uid_auth,//认证条件
                auth_token: enorder_lab_token_auth//认证条件
            });
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                &emsp;<b>实验室编号查询</b><input id="enorder_lab_search_id" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室名查询</b><input id="enorder_lab_search_lname" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室类型查询</b><input id="enorder_lab_search_type" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="enorder_lab_search_btn" type="button" value="查询">
                <input id="enorder_lab_search_reset_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="enorder_lab_grid" data-options="region:'center',collapsible:false"
         style="padding:5px;background:#eee;overflow: hidden">
        <div id="enorder_lab_dialog" style="overflow: hidden"></div>
        <table id="enorder_lab_list"></table>
    </div>
</div>
