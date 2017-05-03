<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#lab_list').datagrid({
            url: './lab/lab_list.do',
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect:false,
            idField: 'lid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'lname',
            sortOrder: 'asc',
            columns: [[
                {field:'ck',checkbox:"true"},
                {field: 'id', title: '实验室编号', width: 100, sortable: true},
                {field: 'lname', title: '实验室名称', width: 100, sortable: true},
                {field: 'type', title: '实验室类型', width: 100, sortable: true},
                {field: 'lsize', title: '学生容量(人)', width: 100},
                {field: 'equcount', title: '设备容量(台)', width: 100},
                {
                    field: 'status',
                    title: '状态',
                    width: 100,
                    formatter: function (status, rec, index) {
                        if (status==0) {
                            return '可用';
                        }
                        if (status==1) {
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
                    $("#lab_dialog").dialog({
                        title: '实验室添加',
                        width: 650,
                        height: 480,
                        href: './lab/add_lab.jsp',
                        modal: true
                    });
//                    $('#lab_list').datagrid('load');
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                    del_lab();
                }
            }]
        });

        $("#search_lab_btn").click(search_lab);//绑定查询事件
        $("#reset_search_lab_btn").click(reset_search_lab);

        /**
         * 删除用户
         */
        function del_lab(){
            var del_lablist=$('#lab_list').datagrid('getSelections');
            var del_list='';
            for(var i=0;i<del_lablist.length;i++){
                var selected=del_lablist[i];
                del_list+=selected['lid']+' ';
            }
            del_list.trim();
            $.ajax({
                url: "./lab/labdel.do",
                type: "post",
                data:{"delList":del_list},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message+"，已删除"+result.data+"条数据");
                        $('#lab_list').datagrid('load');
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
        function search_lab() {
            var lname = $("#search_lname").val().trim();
            var id = $("#search_id").val().trim();
            var type = $("#search_type").val().trim();
            $('#lab_list').datagrid('load', {
                lname: lname,
                id:id,
                type: type
            });
        }

        /**
         * 清空条件查询
         */
        function reset_search_lab() {
            $("#search_lname").val("");
            $("#search_id").val("");
            $("#search_type").val("");
            $('#lab_list').datagrid('load',{});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px" >
                &emsp;<b>实验室名查询</b><input id="search_lname" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室编号查询</b><input id="search_id" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室类型查询</b><input id="search_type" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="search_lab_btn" type="button" value="查询">
                <input id="reset_search_lab_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="lab_grid" data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <div id="lab_dialog" style="overflow: hidden"></div>
        <table id="lab_list"></table>
    </div>
</div>
