/**
 * Created by kehao on 2017/1/4.
 */

var lems = {
    /**
     * 获得项目根路径
     */
    bp: function () {
        var curWwwPath = window.document.location.href;
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        var localhostPath = curWwwPath.substring(0, pos);
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return localhostPath + projectName;
    },
    /**
     * 获取Url中的请求参数
     * @param name 参数名
     * @returns {null}
     */
    getUrlParam: function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) {
            return unescape(r[2]);
        }
        return ""; //返回参数值
    },
    /**
     * 获取Ajax方式加载dialog中的参数
     * @param dialogName dialog名
     * @param name 参数名
     * @returns {*}
     */
    getQueryParam: function (dialogName, name) {
        var obj = $('#' + dialogName).dialog('options');
        var queryParams = obj["queryParams"];
        return queryParams[name];
    }
};
/**
 * 扩展jeasyui验证组件
 */
$.extend($.fn.validatebox.defaults.rules, {
    eqPassword: {
        validator: function (value, param) {
            return value == $(param[0]).val();
        },
        message: '密码不一致'
    },
    lems_minLength: {
        validator: function (value,param) {
            return value.length>=param[0];
        },
        message: '用户名不少于5位'
    },
    lems_email: {
        validator: function (param) {
            var re = new RegExp(" /^[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/");
            return param.matcher(re);
        },
        message: 'Please enter a correct email.'
    }
});