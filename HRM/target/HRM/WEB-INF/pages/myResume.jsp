<%@ page import="java.util.Date" %>
<%@ page import="com.gwy.model.Resume" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gwy.util.DateAndString" %><%--
  Created by IntelliJ IDEA.
  User: destiny
  Date: 2018/6/24/0024
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <title></title>
    <link rel="stylesheet" href="resources/css/index.css" type="text/css"/>
    <script type="text/javascript" src="resources/js/index.js"></script>
    <script src="resources/js/jquery.js"></script>
    <script>
        $(function () {
            $("#del").click(function () {
                return confirm("是否删除简历"+$("#resumename").text());
            })
        })
    </script>
</head>
<body>
<div id="d">
    <div id="d1">
        <div id="d11">
            <a href="login.jsp">&emsp;${user.u_name}</a>
        </div>
        <div id="d12">
            <a href="user" >首页&emsp;</a>
            <a href="myResume" STYLE="color: red">我的简历&emsp;</a>
            <a href="myInterview">面试管理&emsp;</a>
        </div>
    </div>
    <div id="d3" style="font-size: 24px">
        <div id="d31">
            <a href="addresume">添加&emsp;</a>
            <c:forEach items="${resumes}" var="resume" varStatus="loop">
                <a href="updateresume?re_id=${resume.re_id}">修改&emsp;</a><a href="deleteResume?re_id=${resume.re_id}" id="del">删除&emsp;</a>
            <table >
                <tr><th colspan="4" id="resumename">
                        ${resume.resumename}</th></tr>
                <tr><td colspan="4">个人信息</td></tr>
                <tr>
                    <td>姓名</td><td>${resume.re_name}</td>
                    <td>性别</td><td>${resume.re_sex}</td>
                </tr>
                <tr>
                    <td>身份证号</td><td>${resume.re_idcardno}</td>
                    <td>出生时间</td><td>${DateAndString.dateToString(resume.re_birthday)}</td>
                </tr>
                <tr><td colspan="4">教育情况</td></tr>
                <tr>
                    <td>学历</td><td>${resume.re_education}</td>
                    <td>毕业院校</td><td>${resume.re_college}</td>
                </tr>
                <tr>
                    <td>专业</td><td>${resume.re_major}</td>
                    <td>毕业时间</td><td>${DateAndString.dateToString(resume.re_graduate)}</td>
                </tr>
                <tr><td colspan="4">联系方式</td></tr>
                <tr>
                    <td>手机</td><td>${resume.re_phone}</td>
                    <td>电子邮箱</td><td>${resume.re_email}</td>
                </tr>
                <tr>
                    <td>地址</td><td>${resume.re_address}</td>
                    <td>邮编</td><td>${resume.re_post}</td>
                </tr>
                <tr><td colspan="4">简介</td></tr>
                <tr>
                    <td colspan="4">${resume.re_intro}</td>
                </tr>
            </table>
            </c:forEach>
        </div>
        <div id="d32" >
            <a href="myResume?currentPage=${currentPage-1==0?currentPage:currentPage-1}">上一页</a>
            <a href="myResume?currentPage=${currentPage}">第${currentPage}页</a>
            共${totalPages}页
            <a href="myResume?currentPage=${currentPage+1>totalPages?currentPage:currentPage+1}">下一页</a>
            <form action="myResume" method="post">
                <input style="width: 30px" type="number" min="1" max="${totalPages}" value="${currentPage}" name="currentPage">
                <input type="submit" value="跳转">
            </form>
        </div>
    </div>
</div>
</body>
</html>
