<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {

        var move_equ_eid = lems.getDialogParam('equ_list_dialog', 'move_equ_eid');
        $("#move_equ_id").val(lems.getDialogParam('equ_list_dialog', 'move_equ_id'));
        $("#move_equ_ename").val(lems.getDialogParam('equ_list_dialog', 'move_equ_ename'));


        $("#move_equ_btn").click(move_equ);//添加用户按钮事件绑定
        $("#move_equ_reset_btn").click(move_equ_reset);

        //获取实验室列表
        $.ajax({
            url: './lab/get_all_lab.do',
            dataType: 'json',
            timeout: 1000,
            cache: false,
            success: function (result) {
                var data = result.data;
                var dataList, lid, lname;
                dataList = [];
                for(var i=0;i<data.length;i++){
                    lid = data[i].lid;
                    lname = data[i].lname;
                    dataList.push({"id": lid, "text": lname});
                }
                $("#move_equ_lanme").combobox("loadData", dataList);
            },
            error: function () {

            },
            async: true
        });

        //设备添加
        function move_equ() {
            /*var addequ_uid=getCookie("uid");
            var addequ_token=getCookie("token");

            if(addequ_uid==null||addequ_token==null){
                $.messager.alert('警告', "非法操作");
            }*/
            var move_equ_lid=$("#move_equ_lanme").combobox('getValue');
                $.ajax({
                    url: "./equ/move_equ.do",
                    type: "post",
                    data:{"eid":move_equ_eid,"lid":move_equ_lid},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            $.messager.alert('提示', result.message);
                        }
                        if (result.status != 0) {
                            $.messager.alert('警告', result.message);
                        }
                    },
                    error: function () {
                        $.messager.alert('警告', "转移设备异常");
                    },
                    async: true
                });
            }

        function move_equ_reset() {

        }
    });

</script>
<form method="post" id="add_equ_form">
        <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">设备转移</h3>
        <hr>
        <tr>
            <th>设备编号</th>
            <td>
                <input id="move_equ_id" type="text" placeholder="请输入设备编号" class="easyui-validatebox" editable="false"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备名称</th>
            <td>
                <input id="move_equ_ename" type="text" placeholder="请输入设备名称" class="easyui-validatebox" editable="false"
                       data-options="required:true">
            </td>
        </tr>
            <tr>
                <th>实验室</th>
                <td>
                    <select id="move_equ_lanme" class="easyui-combobox easyui-validatebox" placeholder="请选择实验室"
                            data-options="valueField:'id', textField:'text',panelHeight:'auto'"></select>
                </td>
            </tr>
        <tr>
            <td colspan="3">
                <div class="dialog-button">
                    <a id="move_equ_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="move_equ_btn" class="l-btn">
                                    <span class="l-btn-left" style="color:#ffffff;background-color:#0e90d2">
                                        <span class="l-btn-text">转移</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>
