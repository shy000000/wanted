<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/4
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>后台管理</title>
  <%@ include file="../head.jsp" %>
  <script type="text/javascript">
    function isDel() {
      if(confirm("是否注销"))
        alert("正在尝试注销");
      else
        alert("未能注销");
    }

  </script>
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
            <li><a class="scroll" href="#service"><span data-hover="LIST">----通缉犯列表----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#teamwork"><span data-hover="OUTWANTED">----通缉犯注销----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#contact"><span data-hover="CLUES">----线索----</span></a></li>
            <li>/</li>
            <li><a href="/back/loggedout"><span data-hover="LOGGEDOUT">----注销----</span></a></li>
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
      <h3>欢迎，${key}</h3>
      <c:if test="${semaphore == 3}">
        <a href="/back/userManage"><h4>用户管理</h4></a>
      </c:if>
      <a class="downarrow scroll" href="#service"><span> </span></a>
    </div>
  </div>
</div>
<script>
  function getHome(){
    window.location.href = "/";
  }
</script>
<%--通缉犯列表--%>
<div id="service" class="contact">
  <div class="container">
    <h3><a href="/back/wanted">通缉犯列表</a></h3>
    <h4>点击查看所有通缉犯</h4>
  </div>
</div>
<%--注销通缉犯--%>
<div id="teamwork" class="contact" style="background-color: #000000">
  <div class="container">
    <h3><font color="white">注销通缉犯</font></h3>
    <h4><font color="white">输入通缉犯身份证号码注销</font></h4>
    <div class="contact-form">
      <form:form action="/back/outwanted" method="post" methodParam="id" role="form">
        <div class="col-md-6 contact-left">
          <input style="" type="text" id="id" name="id" placeholder="请输入待注销的身份证号码" required/>
        </div>
        <div class="col-md-6 contact-right">
          <input type="submit" value="注销" onclick="return isDel()"/>
        </div>

        <div class="clearfix"></div>
      </form:form>
      </div>
  </div>
</div>
<%--线索--%>
<div id="contact" class="contact">
  <div class="container">
    <h3><a href="/back/clue">线索</a></h3>
    <h4>点击查看所有网民提供的线索</h4>
    </div>
  </div>


<!---fotter-->
<%@ include file="../fotter.jsp" %>
<!---->
<!-- toTop-->
<%@ include file="../toTop.jsp"%>
</body>
</html>
