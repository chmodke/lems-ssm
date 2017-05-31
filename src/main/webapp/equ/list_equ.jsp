<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var equ_list_uid_auth = getCookie("uid");
        var equ_list_token_auth = getCookie("token");
        if (equ_list_uid_auth == null || equ_list_token_auth == null) {
            $.messager.alert('警告', "530,您没有登录");
            setTimeout(function () {
                window.location.reload();
            }, 3000);
            return;
        }
        $('#equ_list_list').datagrid({
            url: './equ/equ_list.do',
            queryParams: {//认证条件
                auth_uid: equ_list_uid_auth,
                auth_token: equ_list_token_auth
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
                        if (status == 2) {
                            return '已预约';
                        }
                        if (status == 3) {
                            return '故障';
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
                text:'增加',
                iconCls:'icon-edit',
                handler:function(){
                    $("#equ_list_dialog").dialog({
                        title: '设备添加',
                        width: 650,
                        height: 480,
                        href: './equ/add_equ.jsp',
                        modal: true,
                        onClose: function () {
                            $('#equ_list_list').datagrid('load',{
                                auth_uid: equ_list_uid_auth,
                                auth_token: equ_list_token_auth
                            });
                        }
                    });
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                    equ_list_del();
                }
            },'-',{
                text:'转移',
                iconCls:'icon-edit',
                handler:function(){
                    //获取参数
                    var move_equ = $('#equ_list_list').datagrid('getSelected');
                    var move_equ_eid = move_equ['eid'];
                    var move_equ_id = move_equ['id'];
                    var move_equ_ename = move_equ['ename'];
//                    $('#equ_list_list').datagrid('clearSelections');//清除选中
                    $("#equ_list_dialog").dialog({
                        title: '设备转移',
                        width: 650,
                        height: 480,
                        href: './equ/move_equ.jsp',
                        modal: true,
                        params: {
                            'move_equ_eid': move_equ_eid,
                            'move_equ_id': move_equ_id,
                            'move_equ_ename': move_equ_ename
                        },//传递参数
                        onClose: function () {
                            $('#equ_list_list').datagrid('load',{
                                auth_uid: equ_list_uid_auth,
                                auth_token: equ_list_token_auth
                            });
                        }
                    });
                }
            },'-',{
                text:'报修',
                iconCls:'icon-edit',
                handler:function(){
                    //获取参数
                    var break_equ = $('#equ_list_list').datagrid('getSelected');
                    var break_equ_eid = break_equ['eid'];
                    var break_equ_id = break_equ['id'];
                    var break_equ_ename = break_equ['ename'];
//                    $('#equ_list_list').datagrid('clearSelections');//清除选中
                    $("#equ_list_dialog").dialog({
                        title: '设备转移',
                        width: 650,
                        height: 480,
                        href: './equ/break_equ.jsp',
                        modal: true,
                        params: {
                            'break_equ_eid': break_equ_eid,
                            'break_equ_id': break_equ_id,
                            'break_equ_ename': break_equ_ename
                        },//传递参数
                        onClose: function () {
                            $('#equ_list_list').datagrid('load',{
                                auth_uid: equ_list_uid_auth,
                                auth_token: equ_list_token_auth
                            });
                        }
                    });
                }
            }]
        });

        $("#equ_list_search_lab_btn").click(equ_list_search_lab);//绑定查询事件
        $("#equ_list_reset_search_lab_btn").click(equ_list_reset_search_lab);

        /**
         * 删除设备
         */
        function equ_list_del(){
            var del_equlist=$('#equ_list_list').datagrid('getSelections');
            var del_list='';
            for(var i=0;i<del_equlist.length;i++){
                var selected=del_equlist[i];
                del_list+=selected['eid']+' ';
            }
            del_list.trim();
            $.ajax({
                url: "./equ/equdel.do",
                type: "post",
                data:{
                    "delList":del_list,
                    "auth_uid": equ_list_uid_auth,
                    "auth_token": equ_list_token_auth
                },
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message+"，已删除"+result.data+"条数据");
                        $('#equ_list_list').datagrid('load',{
                            "auth_uid": equ_list_uid_auth,
                            "auth_token": equ_list_token_auth
                        });
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "删除实验室异常");
                },
                async: true
            });
        }

        /**
         * 条件查询
         */
        function equ_list_search_lab() {
            var equ_ename = $("#equ_list_search_ename").val().trim();
            var equ_id = $("#equ_list_search_id").val().trim();
            var equ_etype = $("#equ_list_search_etype").val().trim();
            equ_ename=(equ_ename==""?undefined:equ_ename);
            equ_id=(equ_id==""?undefined:equ_id);
            equ_etype=(equ_etype==""?undefined:equ_etype);
            $('#equ_list_list').datagrid('load', {
                ename: equ_ename,
                id:equ_id,
                type: equ_etype,
                auth_uid: equ_list_uid_auth,
                auth_token: equ_list_token_auth
            });
        }

        /**
         * 清空条件查询
         */
        function equ_list_reset_search_lab() {
            $("#equ_list_search_ename").val("");
            $("#equ_list_search_id").val("");
            $("#equ_list_search_etype").val("");
            $('#equ_list_list').datagrid('load',{
                auth_uid: equ_list_uid_auth,
                auth_token: equ_list_token_auth
            });
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px" >
                &emsp;<b>设备编号查询</b><input id="equ_list_search_id" class="easyui-validatebox">&emsp;
                &emsp;<b>设备名查询</b><input id="equ_list_search_ename" class="easyui-validatebox">&emsp;
                &emsp;<b>设备类型查询</b><input id="equ_list_search_etype" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="equ_list_search_lab_btn" type="button" value="查询">
                <input id="equ_list_reset_search_lab_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="equ_list_grid" data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <div id="equ_list_dialog" style="overflow: hidden">
            <%--用于实现datagrid弹出窗口--%>
        </div>
        <table id="equ_list_list"></table>
    </div>
</div>
