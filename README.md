# LEMS

##基于Spring MVC模式的实验室设备管理系统

###系统开发环境

**开发环境：** Windows7、JDK1.8、IDEA、Tomcat7、MySQL5.6、Maven3.3、hMailServer

**技术实现：** Java、Spring(IOC、AOP 、MVC)、MyBatis、Shiro、HTML、JSP、jQuery、Ajax、JSON、EasyUI、Git

###开发方法

使用Maven工具进行项目管理；

基于MVC模式开发，使用Spring整合MyBatis搭建四层软件体系(SSM框架)；

采用SpringIOC反转控制权，由系统自动管理Bean对象；

使用SpringMVC作为前端控制器；

使用MyBatis取代传统JDBC，作为持久化层对数据库进行(MySQL)操作；

使用Shiro框架完成认证及授权控制，实现权限控制；

前端是用EasyUI搭建简易页面；

前端数据交互采用HTML、JSP结合Ajax及JSON异步请求完成；

使用Java Mail组件进行用户注册验证，本地使用hMailServer作为邮件服务器；

采用log4j组件作为日志记录工具(SpringAOP)；

使用Git作为版本控制工具。
