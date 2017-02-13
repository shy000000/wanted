<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/4
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>通缉犯信息详情</title>
  <%@ include file="head.jsp" %>
</head>
<body>
<div id="home" class="banner">
  <div class="container">
    <div class="top-header">
      <div class="logo">
        <img src="../images/logo.png" alt="" onclick="getHome()" />
      </div>
      <div class="top-menu">
        <span class="menu"> </span>
        <ul>
          <nav class="cl-effect-5">
            <li><a class="active scroll"  href="#home"><span data-hover="HOME">----主页----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#service"><span data-hover="WANTEDMAN">----信息详情----</span></a></li>
            <li>/</li>
            <li><a href="/reByName?name=${wantedname}"><span data-hover="">----返回----</span></a></li>
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
      <h1>通缉网</h1>
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
    <h3>通缉犯信息详情</h3>
    <div class="contact-form">
      <table class="table tavble-bordered table-striped">
        <tr>
          <th>身份证号码</th>
          <td>${wantedman.id}</td>
        </tr>
        <tr>
          <th>姓名</th>
          <td>${wantedman.name}</td>
        </tr>
        <tr>
          <th>性别</th>
          <td>${wantedman.gender}</td>
        </tr>
        <tr>
          <th>身高</th>
          <td>${wantedman.high}</td>
        </tr>
        <tr>
          <th>体重</th>
          <td>${wantedman.weight}</td>
        </tr>
        <tr>
          <th>特征</th>
          <td>${wantedman.feature}</td>
        </tr>
        <tr>
          <th>举报电话</th>
          <td>${wantedman.phone}</td>
        </tr>
        <tr>
          <th>照片</th>
          <c:if test="${wantedman.photo =='无'}">
            <td>${wantedman.photo}</td>
          </c:if>
          <c:if test="${wantedman.photo !='无'}">
            <td><img src="${wantedman.photo}"></td>
          </c:if>
        </tr>
      </table>
    </div>
  </div>
</div>

<script src="../js/jquery.min.js"> </script>
<script src="../js/responsiveslides.min.js"></script>

<!---fotter-->
<%@ include file="fotter.jsp" %>
<!-- toTop-->
<%@ include file="toTop.jsp"%>
</body>
</html>
