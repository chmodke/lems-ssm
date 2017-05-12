<%--lab/ordered_lab_list.jsp--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#ordered_equ_list').datagrid({
            url: './equs/ordered_equ_list.do',
            pagination: true,
            fit: true,
            fitColumns: false,
            singleSelect: true,
            idField: 'eid',
            pageSize: 5,
            pageList: [5, 10, 15, 20],
            sortName: 'ename',
            sortOrder: 'asc',
            columns: [[
                {field: 'ck', checkbox: "true"},
                {field: 'id', title: '设备编号', width: 80, sortable: true},
                {field: 'ename', title: '设备名称', width: 80, sortable: true},

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

                {field: 'type', title: '设备类型', width: 80, sortable: true},
                {field: 'lname', title: '所属实验室', width: 100, sortable: true},
                {field: 'remark', title: '备注', width: 100}
            ]]
        });

        $("#ordered_equ_search_btn").click(ordered_equ_search);//绑定查询事件
        $("#ordered_equ_search_reset_btn").click(ordered_equ_search_reset);


        /**
         * 条件查询
         */
        function ordered_equ_search() {
            var ordered_ename = $("#ordered_equ_search_ename").val().trim();
            var ordered_id = $("#ordered_equ_search_id").val().trim();
            var ordered_type = $("#ordered_equ_search_type").val().trim();
            var ordered_sname = $("#ordered_equ_search_sname").val().trim();

            $('#ordered_equ_list').datagrid('load', {
                ename: ordered_ename,
                id: ordered_id,
                type: ordered_type,
                sname: ordered_sname
            });
        }

        /**
         * 清空条件查询
         */
        function ordered_equ_search_reset() {
            $("#ordered_equ_search_ename").val("");
            $("#ordered_equ_search_id").val("");
            $("#ordered_equ_search_type").val("");
            $("#ordered_equ_search_sname").val("");
            $('#ordered_equ_list').datagrid('load', {});
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
                        <td><input id="ordered_equ_search_id" class="easyui-validatebox">&emsp;</td>
                        <td><b>实验室名查询</b></td>
                        <td><input id="ordered_equ_search_ename" class="easyui-validatebox">&emsp;</td>
                        <td><b>实验室类型查询</b></td>
                        <td><input id="ordered_equ_search_type" class="easyui-validatebox">&emsp;</td>
                        <td rowspan="2" style="padding-left: 5px">
                            <input id="ordered_equ_search_btn" type="button" value="查询">
                            <input id="ordered_equ_search_reset_btn" type="button" value="清空">&emsp;
                        </td>
                    </tr>
                    <tr>
                        <td><b>预约人姓名查询</b></td>
                        <td><input id="ordered_equ_search_sname" class="easyui-validatebox">&emsp;</td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
    <div id="ordered_equ_grid" data-options="region:'center',collapsible:false"
         style="padding:5px;background:#eee;overflow: hidden">
        <div id="ordered_equ_dialog" style="overflow: hidden"></div>
        <table id="ordered_equ_list"></table>
    </div>
</div>
