<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/8
  Time: 12:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>通缉犯列表</title>
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
            <li><a class="scroll" href="#service"><span data-hover="WANTEDLIST">----通缉犯列表----</span></a></li>
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

<%--通缉犯列表--%>
<div id="service" class="contact">
  <div class="container">
    <h3>通缉犯列表</h3>
    <a href="/back/addWanted"><h4>添加通缉犯</h4></a>
    <div class="contact-form">
      <c:if test="${wantedman == '0'}">
        <p class="bg-warning">
          <br/>
          无通缉犯
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
                <a href="/back/showWanted?wantedid=${wanted.id}&pageNow=${page.pageNow}" type="button" class="btn btn-sm btn-default">详情</a>
                <a href="/back/updateWanted?wantedid=${wanted.id}&pageNow=${page.pageNow}" type="button" class="btn btn-sm btn-default">修改</a>
                <a href="javascript:if(confirm('确认删除吗?'))window.location='/back/deleteWanted?wantedid=${wanted.id}&pageNow=${page.pageNow}'" type="button" class="btn btn-sm btn-default">删除</a>
              </td>
            </tr>
          </c:forEach>
        </table>
        <!-- 分页功能 start -->
        <div align="center">
          <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第
            ${page.pageNow} 页</font> <a href="wanted?pageNow=1">首页</a>
          <c:choose>
            <c:when test="${page.pageNow - 1 > 0}">
              <a href="wanted?pageNow=${page.pageNow - 1}">上一页</a>
            </c:when>
            <c:when test="${page.pageNow - 1 <= 0}">
              <a href="wanted?pageNow=1">上一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="wanted?pageNow=${page.pageNow}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">
              <a href="wanted?pageNow=${page.pageNow + 1}">下一页</a>
            </c:when>
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">
              <a href="wanted?pageNow=${page.totalPageCount}">下一页</a>
            </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${page.totalPageCount==0}">
              <a href="wanted?pageNow=${page.pageNow}">尾页</a>
            </c:when>
            <c:otherwise>
              <a href="wanted?pageNow=${page.totalPageCount}">尾页</a>
            </c:otherwise>
          </c:choose>
        </div>
        <!-- 分页功能 End -->
      </c:if>

    </div>
  </div>
</div>
</body>
</html>
