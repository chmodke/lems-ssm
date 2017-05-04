<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#lab_list').datagrid({
            url: './lab/labsearch.do',
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
                {field: 'id', title: '实验室编号', width: 80, sortable: true},
                {field: 'lname', title: '实验室名称', width: 100, sortable: true},
                {field: 'type', title: '实验室类型', width: 100, sortable: true},
                {field: 'lsize', title: '学生容量(人)', width: 80},
                {field: 'equcount', title: '设备容量(台)', width: 80},
                {
                    field: 'status',
                    title: '实验室状态',
                    width: 60,
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
                {field: 'lab_uname', title: '实验室管理员', width: 80},

                {field: 'equ_ename', title: '设备名称', width: 100, sortable: true},
                {field: 'equ_type', title: '设备类型', width: 100, sortable: true},
                {field: 'equ_status',
                    title: '设备状态',
                    width: 60,
                    formatter: function (equ_status, rec, index) {
                    if (equ_status==0) {
                        return '可用';
                    }
                    if (equ_status==1) {
                        return '已预约';
                    }
                }},
                {field: 'purc_price', title: '设备价格', width: 100},
                {field: 'equ_uname', title: '设备采购者', width: 100},
                {field: 'remark', title: '实验室备注', width: 100},
                {field: 'equ_remark', title: '设备备注', width: 100}
            ]]
        });

        $("#search_lab_btn").click(search_lab);//绑定查询事件
        $("#reset_search_lab_btn").click(reset_search_lab);

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
