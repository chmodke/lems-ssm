<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#equ_list_list').datagrid({
            url: './equ/equ_list.do',
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect:false,
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
                    },
                    sortable: true,
                    fixed: true
                },
                {field: 'remark', title: '备注', width: 100}
            ]],
            toolbar:['-',{
                text:'增加',
                iconCls:'icon-edit',
                handler:function(){
                    $("#equ_list_dialog").dialog({
                        title: '设备添加',
                        width: 650,
                        height: 480,
                        href: './equ/add_equ.jsp',
                        modal: true
                    });
//                    $('#lab_list').datagrid('load');
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
//                    equ_list_del();
                }
            }]
        });

        $("#equ_list_search_lab_btn").click(equ_list_search_lab);//绑定查询事件
        $("#equ_list_reset_search_lab_btn").click(equ_list_reset_search_lab);

        /**
         * 删除用户
         */
        /*function equ_list_del(){
            var del_lablist=$('#equ_list_list').datagrid('getSelections');
            var del_list='';
            for(var i=0;i<del_lablist.length;i++){
                var selected=del_lablist[i];
                del_list+=selected['lid']+' ';
            }
            del_list.trim();
            $.ajax({
                url: "./equ/equdel.do",
                type: "post",
                data:{"delList":del_list},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message+"，已删除"+result.data+"条数据");
                        $('#list_lab_list').datagrid('load');
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
        }*/

        /**
         * 条件查询
         */
        function equ_list_search_lab() {
            var equ_ename = $("#equ_list_search_ename").val().trim();
            var equ_id = $("#equ_list_search_id").val().trim();
            var equ_etype = $("#equ_list_search_etype").val().trim();
            $('#equ_list_list').datagrid('load', {
                ename: equ_ename,
                id:equ_id,
                type: equ_etype
            });
        }

        /**
         * 清空条件查询
         */
        function equ_list_reset_search_lab() {
            $("#equ_list_search_ename").val("");
            $("#equ_list_search_id").val("");
            $("#equ_list_search_etype").val("");
            $('#equ_list_list').datagrid('load',{});
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
        <div id="equ_list_dialog" style="overflow: hidden"></div>
        <table id="equ_list_list"></table>
    </div>
</div>
