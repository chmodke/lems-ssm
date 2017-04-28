<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $("#add_lab_btn").click(add_lab);//添加用户按钮事件绑定
        $("#addlab_reset_btn").click(addlab_reset);

        /**
         * 实验室添加页面回车键事件绑定
         */
        $("#addlab_remark").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                add_lab();
            }
        });
        //实验室添加
        function add_lab() {
            var addlab_uid=getCookie("uid");
            var addlab_token=getCookie("token");

            if(addlab_uid==null||addlab_token==null){
                $.messager.alert('警告', "非法操作");
            }

            var lab_serial = $("#addlab_serial").val();
            var lab_name = $("#addlab_name").val();
            var lab_type=$("#addlab_type").val();
            var lab_size=$("#addlab_size").val();
            var lab_equcount=$("#addlab_equcount").val();
            var lab_remark=$("#addlab_remark").val();
            if(lab_remark==null){
                lab_remark="";
            }
            var lab_uid=addlab_uid;

            $.ajax({
                url: "./lab/labadd.do",
                type: "post",
                data:{"id":lab_serial,"lname":lab_name,"type":lab_type,"lsize":lab_size,"equcount":lab_equcount,"remark":lab_remark,"uid":lab_uid},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                        addlab_reset();
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "添加实验室异常");
                },
                async: true
            });
        }

        function addlab_reset() {
            $("#addlab_serial").val("");
            $("#addlab_name").val("");
            $("#addlab_type").val("");
            $("#addlab_size").val("");
            $("#addlab_equcount").val("");
            $("#addlab_remark").val("");
        }
    });

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">添加实验室</h3>
        <hr>
        <tr>
            <th>实验室编号</th>
            <td>
                <input id="addlab_serial" type="text" placeholder="请输入实验室编号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>实验室名称</th>
            <td>
                <input id="addlab_name" type="text" placeholder="请输入实验室名称" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>实验室类型</th>
            <td>
                <input id="addlab_type" type="text" placeholder="请输入实验室类型" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>实验室容纳人数</th>
            <td>
                <input id="addlab_size" type="text" placeholder="请输入实验室容纳人数" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>实验室容纳设备</th>
            <td>
                <input id="addlab_equcount" type="text" placeholder="实验室容纳设备" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>备注</th>
            <td>
                <input id="addlab_remark" type="text" placeholder="请输入备注" class="easyui-validatebox">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dialog-button">
                    <a id="addlab_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="add_lab_btn" class="l-btn">
                                    <span class="l-btn-left" style="background-color:#0e90d2">
                                        <span class="l-btn-text">添加</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>