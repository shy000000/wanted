<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/9
  Time: 0:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>通缉犯管理-修改通缉犯成功</title>
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
            <li><a class="scroll" href="#service"><span data-hover="WANTEDMANAGE">----通缉犯管理----</span></a></li>
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
    <h3>通缉犯管理</h3>
    <div class="contact-form">
      <a href="/back/wanted?pageNow=${pageNow}"><h4>修改成功，点此返回</h4></a>
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
