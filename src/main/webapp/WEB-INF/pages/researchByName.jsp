<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/3
  Time: 0:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>姓名检索</title>
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
            <li><a class="scroll" href="#service"><span data-hover="SEARCH">----检索----</span></a></li>
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
    <h3>姓名检索</h3>
    <div class="contact-form">

      <form:form action="/reByName" method="get" methodParam="name" role="form">
        <div class="col-md-6 contact-left">
          <input style="" type="text" id="name" value="${key}" name="name" placeholder="请输入待检索的姓名" required/>
        </div>
        <div class="col-md-6 contact-right">
          <input type="submit" value="检索"/>
        </div>
        <div class="clearfix"></div>
      </form:form>

      <c:if test="${wantedman == '0'}">
        <p class="bg-warning">
          <br/>
          无此人
          <br/>
          <br/>
        </p>
      </c:if>
      <c:if test="${!empty wantedman && wantedman != '0'}">
        <table class="table tavble-bordered table-striped">
          <tr>
            <th>身份证号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>操作</th>
          </tr>
          <c:forEach items="${wantedman}" var="wanted">
            <tr>
              <td>${wanted.id}</td>
              <td>${wanted.name}</td>
              <td>${wanted.gender}</td>
              <td>
                <a href="/showWanted?wantedid=${wanted.id}&return=1" type="button" class="btn btn-sm btn-default">详情</a>
              </td>
            </tr>
          </c:forEach>
        </table>
        <!-- 分页功能 start -->
        <div align="center">
          <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第
            ${page.pageNow} 页</font> <a href="reByName?pageNow=1&name=${key}">首页</a>
          <c:choose>
            <c:when test="${page.pageNow - 1 > 0}">
              <a href="reByName?pageNow=${page.pageNow - 1}&name=${key}">上一页</a>
            </c:when>
            <c:when test="${page.pageNow - 1 <= 0}">
              <a href="reByName?pageNow=1&name=${key}">上一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="reByName?pageNow=${page.pageNow}&name=${key}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">
              <a href="reByName?pageNow=${page.pageNow + 1}&name=${key}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">
              <a href="reByName?pageNow=${page.totalPageCount}&name=${key}">下一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="reByName?pageNow=${page.pageNow}&name=${key}">尾页</a>
            </c:when>
            <c:otherwise>
              <a href="reByName?pageNow=${page.totalPageCount}&name=${key}">尾页</a>
            </c:otherwise>
          </c:choose>
        </div>
        <!-- 分页功能 End -->
      </c:if>

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
