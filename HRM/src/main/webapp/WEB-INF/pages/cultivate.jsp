<%@ page import="com.gwy.util.DateAndString" %>
<%--
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
            $(".issueCultivate").click(function () {
                var c_id=parseInt($(this).siblings().eq(0).val());
                var d_id=parseInt($(this).parent().parent().prev().find("select").val());
                if (!confirm("确认发布")){
                    return false;
                }
                alert(c_id);
                alert(d_id);
                $.ajax({
                    type:"post",
                    url:"issueCultivate",
                    data:{c_id:c_id,d_id:d_id},
                    success:function (obj) {//成功后回调函数
                        alert(obj);
                        location.reload(true);
                    },
                    error:function (obj) {

                    }
                })
            })
            $(".recallCultivate").click(function () {
                var c_id=parseInt($(this).siblings().eq(0).val());
                if (!confirm("确认撤回")){
                    return false;
                }
                $.ajax({
                    type:"post",
                    url:"recallCultivate",
                    data:{c_id:c_id},
                    success:function (obj) {//成功后回调函数
                        alert(obj);
                        location.reload(true);
                    },
                    error:function (obj) {

                    }
                })
            })
        })
    </script>
</head>
<body>
<div id="d">
    <div id="d1">
        <div id="d11">
            <a href="adminLogin.jsp">&emsp;${admin.ad_name}</a>
        </div>
        <div id="d12">
            <a href="admin">员工管理&emsp;</a>
            <a href="myResume" >薪资管理&emsp;</a>
            <a href="organizationalManagement" >组织管理&emsp;</a>
            <a href="myInterview">考勤管理&emsp;</a>
            <a href="cultivate" style="color: red">培训管理&emsp;</a>
            <a href="ri">招聘信息&emsp;</a>
            <a href="r">招聘管理&emsp;</a>
            <a href="myInterview">奖惩管理&emsp;</a>
        </div>
    </div>
    <div id="d4">
        <a href="cultivate?c_state=0"
                <c:if test="${c_state eq 0}">
                    style="color: red"
                </c:if>>未发布&emsp;</a>
        <a href="cultivate?c_state=1"
                <c:if test="${c_state eq 1}">
                    style="color: red"
                </c:if>>发布中&emsp;</a>
        <a href="addcultivate1">新增培训&emsp;</a>
    </div>
    <div id="d3" style="font-size: 24px">
        <div id="d31">

            <table >
                <tr style="background-color: #faebd7">
                    <th width="40px">ID</th>
                    <th width="80px">主题</th>
                    <th width="120px">内容</th>
                    <th width="100px">开始时间</th>
                    <th width="60px">结束时间</th>
                    <th width="150px">地点</th>
                    <th width="200px">发布时间</th>
                    <c:if test="${c_state eq 0}">
                    <th width="100px">发布对象</th>
                    </c:if>
                    <th width="80px">操作</th>
                </tr>
                <c:forEach items="${cultivates}" var="cultivate" varStatus="loop">
                    <tr >
                        <td>${cultivate.c_id}</td>
                        <td>${cultivate.c_theme}</td>
                        <td>${cultivate.c_content}</td>
                        <td>${DateAndString.dateToStringTime(cultivate.c_begintime)}</td>
                        <td>${DateAndString.dateToStringTime(cultivate.c_endtime)}</td>
                        <td>${cultivate.c_address}</td>
                        <td>${DateAndString.dateToStringTime(cultivate.c_issuetime)}</td>
                        <c:if test="${c_state eq 0}">
                        <td><select name="d_id" id="d_id">
                            <option value="0">新人</option>
                            <c:forEach items="${departments}" var="department">
                                <option value="${department.d_id}">${department.d_name}</option>
                            </c:forEach>
                        </select>
                        </td>
                        </c:if>
                        <td><form action="updateCultivate1" method="post">
                            <input type="hidden" name="c_id" value="${cultivate.c_id}">
                            <c:if test="${c_state eq 1}">
                            <input type="button" value="撤回" class="recallCultivate">
                            </c:if>
                            <c:if test="${c_state eq 0}">
                                <input type="button" value="发布" class="issueCultivate">
                                <input type="submit" value="修改">
                            </c:if>
                        </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div id="d32" >
            <a href="cultivate?c_state=${c_state}&currentPage=${currentPage-1==0?currentPage:currentPage-1}">上一页</a>
            <a href="cultivate?c_state=${c_state}&currentPage=${currentPage}">第${currentPage}页</a>
            共${totalPages}页
            <a href="cultivate?c_state=${c_state}&currentPage=${currentPage+1>totalPages?currentPage:currentPage+1}">下一页</a>
            <form action="cultivate?c_state=${c_state}" method="post">
                <input style="width: 30px" type="number" min="1" max="${totalPages}" value="${currentPage}" name="currentPage">
                <input type="submit" value="跳转">
            </form>
        </div>
    </div>
</div>
</body>
</html>
