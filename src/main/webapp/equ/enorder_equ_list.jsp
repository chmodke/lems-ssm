<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var enorder_equ_list_uid_auth = getCookie("uid");
        var enorder_equ_list_token_auth = getCookie("token");
        if (enorder_equ_list_uid_auth == null || enorder_equ_list_token_auth == null) {
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        $('#enorder_equ_list').datagrid({
            url: './equ/enorder_equ_list.do',
            queryParams: {//认证条件
                auth_uid: enorder_equ_list_uid_auth,
                auth_token: enorder_equ_list_token_auth
            },
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect:true,
            idField: 'eid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'ename',
            sortOrder: 'asc',
            columns: [[
                {field:'ck',checkbox:"true"},
                {field: 'id', title: '设备编号', width: 100, sortable: true},
                {field: 'ename', title: '设备名称', width: 100, sortable: true},
                {field: 'type', title: '设备类型', width: 100, sortable: true},
                {field: 'lanme', title: '所属实验室', width: 100},
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
            toolbar:['-',{
                text:'预约',
                iconCls:'icon-edit',
                handler:function(){
                    var order_equ = $('#enorder_equ_list').datagrid('getSelected');
                    var order_equ_eid = order_equ['eid'];
                    var order_equ_id = order_equ['id'];
                    var order_equ_ename = order_equ['ename'];
                    $("#enorder_equ_list_dialog").dialog({
                        title: '设备预约',
                        width: 650,
                        height: 480,
                        href: './equ/order_equ.jsp',
                        params: {
                            'order_equ_eid': order_equ_eid,
                            'order_equ_id': order_equ_id,
                            'order_equ_ename': order_equ_ename
                        },//传递参数
                        modal: true,
                        onClose: function () {
                            $('#enorder_equ_list').datagrid('load',{
                                auth_uid: enorder_equ_list_uid_auth,
                                auth_token: enorder_equ_list_token_auth
                            });
                        }
                    });
                }
            },'-',{
                text:'租借',
                iconCls:'icon-edit',
                handler:function(){
                    var order_equ = $('#enorder_equ_list').datagrid('getSelected');
                    var order_equ_eid = order_equ['eid'];
                    var order_equ_id = order_equ['id'];
                    var order_equ_ename = order_equ['ename'];
                    $("#enorder_equ_list_dialog").dialog({
                        title: '设备预约',
                        width: 650,
                        height: 480,
                        href: './equ/order_equ.jsp',
                        params: {
                            'order_equ_eid': order_equ_eid,
                            'order_equ_id': order_equ_id,
                            'order_equ_ename': order_equ_ename
                        },//传递参数
                        modal: true,
                        onClose: function () {
                            $('#enorder_equ_list').datagrid('load',{
                                auth_uid: enorder_equ_list_uid_auth,
                                auth_token: enorder_equ_list_token_auth
                            });
                        }
                    });
                }
            }]
        });

        $("#enorder_equ_list_search_lab_btn").click(enorder_equ_list_search_lab);//绑定查询事件
        $("#enorder_equ_list_search_reset_lab_btn").click(enorder_equ_list_reset_search_lab);

        /**
         * 条件查询
         */
        function enorder_equ_list_search_lab() {
            var equ_ename = $("#enorder_equ_list_search_ename").val().trim();
            var equ_id = $("#enorder_equ_list_search_id").val().trim();
            var equ_etype = $("#enorder_equ_list_search_etype").val().trim();
            equ_ename=(equ_ename==""?undefined:equ_ename);
            equ_id=(equ_id==""?undefined:equ_id);
            equ_etype=(equ_etype==""?undefined:equ_etype);
            $('#enorder_equ_list').datagrid('load', {
                ename: equ_ename,
                id:equ_id,
                type: equ_etype
            });
        }

        /**
         * 清空条件查询
         */
        function enorder_equ_list_reset_search_lab() {
            $("#enorder_equ_list_search_ename").val("");
            $("#enorder_equ_list_search_id").val("");
            $("#enorder_equ_list_search_etype").val("");
            $('#enorder_equ_list').datagrid('load',{});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px" >
                &emsp;<b>设备编号查询</b><input id="enorder_equ_list_search_id" class="easyui-validatebox">&emsp;
                &emsp;<b>设备名查询</b><input id="enorder_equ_list_search_ename" class="easyui-validatebox">&emsp;
                &emsp;<b>设备类型查询</b><input id="enorder_equ_list_search_etype" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="enorder_equ_list_search_lab_btn" type="button" value="查询">
                <input id="enorder_equ_list_search_reset_lab_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="enorder_equ_list_grid" data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <div id="enorder_equ_list_dialog" style="overflow: hidden">
            <%--用于实现datagrid弹出窗口--%>
        </div>
        <table id="enorder_equ_list"></table>
    </div>
</div>
