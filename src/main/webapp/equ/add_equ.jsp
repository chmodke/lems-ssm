<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    $(function () {
        var add_equ_btn = $("#add_equ_btn");
        var addequ_reset_btn = $("#addequ_reset_btn");

        add_equ_btn.click(add_equ);//添加用户按钮事件绑定
        addequ_reset_btn.click(addequ_reset);

        /**
         * 注册页面回车键事件绑定
         */
        /*$("#adduser_emailbox").keydown(function (event) {
            var keyCode=event.keyCode;
            if(keyCode==13){
                add_user();
            }
        });*/
        //设备添加
        function add_equ() {
            var addequ_uid=getCookie("uid");
            var addequ_token=getCookie("token");

            if(addequ_uid==null||addequ_token==null){
                $.messager.alert('警告', "非法操作");
            }

            var addequ_serial = $("#addequ_serial").val();
            var addequ_name = $("#addequ_name").val();
            var addequ_type=$("#addequ_type").val();
            var addequ_price=$("#addequ_price").val();
            var addequ_remark=$("#addequ_remark").val();
            if(addequ_remark==null){
                addequ_remark="";
            }

            $.ajax({
                url: "./equ/equadd.do",
                type: "post",
                data:{"id":addequ_serial,"ename":addequ_name,"type":addequ_type,"remark":addequ_remark,"equPurchase.uid":addequ_uid,"equPurchase.price":addequ_price},
                dataType: "json",
                success: function (result) {
                    if (result.status == 0) {
                        $.messager.alert('提示', result.message);
                        addequ_reset();
                    }
                    if (result.status != 0) {
                        $.messager.alert('警告', result.message);
                    }
                },
                error: function () {
                    $.messager.alert('警告', "添加设备异常");
                },
                async: true
            });
        }

        function addequ_reset() {
            $("#addequ_serial").val("");
            $("#addequ_name").val("");
            $("#addequ_type").val("");
            $("#addequ_price").val("");
            $("#addequ_remark").val("");
        }
    });

</script>
<form method="post">
    <table class="table table-hover table-condensed" style="width: 500px;margin: auto">
        <h3 style="text-align: center">采购设备</h3>
        <hr>
        <tr>
            <th>设备编号</th>
            <td>
                <input id="addequ_serial" type="text" placeholder="请输入设备编号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备名称</th>
            <td>
                <input id="addequ_name" type="text" placeholder="请输入设备名称" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>设备型号</th>
            <td>
                <input id="addequ_type" type="text" placeholder="请输入设备型号" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>采购时间</th>
            <td>
                <input id="addequ_time" type="text" placeholder="请输入采购时间" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>采购价格</th>
            <td>
                <input id="addequ_price" type="text" placeholder="请输入采购价格" class="easyui-validatebox"
                       data-options="required:true">
            </td>
        </tr>
        <tr>
            <th>备注</th>
            <td>
                <input id="addequ_remark" type="text" placeholder="请输入备注" class="easyui-validatebox">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dialog-button">
                    <a id="addequ_reset_btn" class="l-btn">
                                    <span class="l-btn-left">
                                        <span class="l-btn-text">清空</span>
                                    </span>
                    </a>
                    <a id="add_equ_btn" class="l-btn">
                                    <span class="l-btn-left" style="background-color:#0e90d2">
                                        <span class="l-btn-text">添加</span>
                                    </span>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>