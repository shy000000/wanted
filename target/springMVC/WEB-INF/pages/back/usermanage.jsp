<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/8
  Time: 0:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>用户管理</title>
  <%@ include file="../head.jsp" %>
</head>
<body>
<div id="home" class="banner">
  <div class="container">
    <div class="top-header">
      <div class="logo">
        <img src="../../images/logo.png" alt="" onclick="getHome()" />
      </div>
      <div class="top-menu">
        <span class="menu"> </span>
        <ul>
          <nav class="cl-effect-5">
            <li><a class="active scroll"  href="#home"><span data-hover="HOME">----主页----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#service"><span data-hover="USERMANAGE">----用户管理----</span></a></li>
            <li>/</li>
            <li><a href="/back/loggedin"><span data-hover="">----返回----</span></a></li>
          </nav>
        </ul>
      </div>
      <!-- script-for-menu -->
      <script>
        $("span.menu").click(function(){
          $(".top-menu ul").slideToggle("slow" , function(){
          });
        });
      </script>
      <!-- script-for-menu -->
      <div class="clearfix"></div>
    </div>
    <div class="banner-info">
      <h1>后台管理</h1>
      <h3>国家安全人人有责</h3>
      <a class="downarrow scroll" href="#service"><span> </span></a>
    </div>
  </div>
</div>
<script>
  function getHome(){
    window.location.href = "/";
  }
</script>
<div id="service" class="contact">
  <div class="container">
    <h3>用户管理</h3>
    <a href="/back/addUser"><h4>添加新用户</h4></a>
    <div class="contact-form">
      <c:if test="${users == '0'}">
        <p class="bg-warning">
          <br/>
          只有你一个用户
          <br/>
          <br/>
        </p>
      </c:if>
      <c:if test="${!empty users && users != '0'}">
      <table class="table tavble-bordered table-striped">
        <table class="table tavble-bordered table-striped">
          <tr>
            <th>用户id</th>
            <th>用户名</th>
            <th>密码</th>
            <th>操作</th>
          </tr>
          <c:forEach items="${users}" var="wanted">
            <tr>
              <td>${wanted.id}</td>
              <td>${wanted.username}</td>
              <td>${wanted.password}</td>
              <td>
                <a href="/back/updateUser?userid=${wanted.id}&pageNow=${page.pageNow}" type="button" class="btn btn-sm btn-default">修改</a>
                <a href="javascript:if(confirm('确认删除吗?'))window.location='/back/deleteUser?userid=${wanted.id}&pageNow=${page.pageNow}'" type="button" class="btn btn-sm btn-default">删除</a>
              </td>
            </tr>
          </c:forEach>
        </table>
        <!-- 分页功能 start -->
        <div align="center">
          <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第
            ${page.pageNow} 页</font> <a href="userManage?pageNow=1">首页</a>
          <c:choose>
            <c:when test="${page.pageNow - 1 > 0}">
              <a href="userManage?pageNow=${page.pageNow - 1}">上一页</a>
            </c:when>
            <c:when test="${page.pageNow - 1 <= 0}">
              <a href="userManage?pageNow=1">上一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="userManage?pageNow=${page.pageNow}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">
              <a href="userManage?pageNow=${page.pageNow + 1}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">
              <a href="userManage?pageNow=${page.totalPageCount}">下一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="userManage?pageNow=${page.pageNow}">尾页</a>
            </c:when>
            <c:otherwise>
              <a href="userManage?pageNow=${page.totalPageCount}">尾页</a>
            </c:otherwise>
          </c:choose>
        </div>
        <!-- 分页功能 End -->
        </c:if>
    </div>
  </div>
</div>

<script src="../../js/jquery.min.js"> </script>
<script src="../../js/responsiveslides.min.js"></script>

<!---fotter-->
<%@ include file="../fotter.jsp" %>
<!-- toTop-->
<%@ include file="../toTop.jsp"%>


</body>
</html>
