/**
 * Created by kehao on 2017/1/4.
 */

var lems={
    /**
     * 获得项目根路径
     */
    bp:function () {
        var curWwwPath=window.document.location.href;
        var pathName=window.document.location.pathname;
        var pos=curWwwPath.indexOf(pathName);
        var localhostPath=curWwwPath.substring(0,pos);
        var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
        return localhostPath+projectName;
    }
};

$.extend($.fn.validatebox.defaults.rules, {
    eqPassword: {
        validator: function(value, param){
            return value == $(param[0]).val();
        },
        message: '密码不一致'
    }
});