<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/8
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>添加新用户</title>
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
            <li><a class="scroll" href="#service"><span data-hover="ADDUSER">----用户管理-添加新用户----</span></a></li>
            <li>/</li>
            <li><a href="/back/userManage?"><span data-hover="">----返回----</span></a></li>
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
    <h3>用户管理-添加新用户</h3>
    <div class="contact-form">
      <form:form action="/back/addUserPost" method="post" commandName="user" role="form">
        <div class="col-md-6 contact-left">
          用户名:<input type="text" id="username" name="username"  required/>
          口令:<input type="password" id="password" name="password"  required/>
        </div>
        <div class="col-md-6 contact-right">
          <input type="submit" style="position: absolute" value="添加"/>
        </div>
        <div class="clearfix"></div>

      </form:form>
      <c:if test="${hasname == 1}">
        <p class="bg-warning">
          <br/>
          用户名已存在，请重新输入
          <br/>
          <br/>
        </p>
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
