<%--
实验室负责人管理页面
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    //TODO datagrid 行内修改功能待实现
    $(function () {
        $('#mgr_lab_list').datagrid({
            url: './lab/lab_mgr_list.do',
            pagination: true,
            fit: true,
            fitColumns: true,
            singleSelect:true,
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
                /*----------实验室部分--------*/
                {field: 'lab_uname', title: '实验室负责人', width: 100,sortable: true},
                {field: 'lab_uid', title: '实验室负责人ID', width: 100}
            ]]
        });

        $("#mgr_search_lab_btn").click(mgr_lab_search_lab);//绑定查询事件
        $("#mgr_reset_search_lab_btn").click(mgr_reset_search_lab);


        /**
         * 条件查询
         */
        function mgr_lab_search_lab() {
            var mgr_lname = $("#mgr_lab_search_lname").val().trim();
            var mgr_id = $("#mgr_lab_search_id").val().trim();
            var mgr_type = $("#mgr_lab_search_type").val().trim();
            $('#mgr_lab_list').datagrid('load', {
                lname: mgr_lname,
                id:mgr_id,
                type: mgr_type
            });
        }

        /**
         * 清空条件查询
         */
        function mgr_reset_search_lab() {
            $("#mgr_lab_search_lname").val("");
            $("#mgr_lab_search_id").val("");
            $("#mgr_lab_search_type").val("");
            $('#mgr_lab_list').datagrid('load',{});
        }
    });
</script>
<div class="easyui-layout" data-options="fit : true">
    <div data-options="region:'north',split:false,collapsible:true" style="overflow: hidden">
        <form>

            <div style="float: left;margin-top: 5px;margin-bottom: 5px" >
                &emsp;<b>实验室编号查询</b><input id="mgr_lab_search_id" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室名查询</b><input id="mgr_lab_search_lname" class="easyui-validatebox">&emsp;
                &emsp;<b>实验室类型查询</b><input id="mgr_lab_search_type" class="easyui-validatebox">&emsp;
            </div>
            <div style="float: left;margin-top: 5px;margin-bottom: 5px">
                <input id="mgr_search_lab_btn" type="button" value="查询">
                <input id="mgr_reset_search_lab_btn" type="button" value="清空">&emsp;
            </div>
        </form>
    </div>
    <div id="mgr_lab_grid" data-options="region:'center',collapsible:false" style="padding:5px;background:#eee;overflow: hidden">
        <div id="mgr_lab_dialog" style="overflow: hidden"></div>
        <table id="mgr_lab_list"></table>
    </div>
</div>
