<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/4
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>线索</title>
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
            <li><a class="scroll" href="#service"><span data-hover="CLUES">----线索----</span></a></li>
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
    <h3>线索</h3>
    <div class="contact-form">
      <c:if test="${clue == '0'}">
        <p class="bg-warning">
          <br/>
          无线索
          <br/>
          <br/>
        </p>
      </c:if>
      <c:if test="${!empty clue && clue != '0'}">
        <table class="table tavble-bordered table-striped">
          <table class="table tavble-bordered table-striped">
            <tr>
              <th>线索id</th>
              <th>线索标题</th>
              <th>举报人姓名</th>
              <th>操作</th>
            </tr>
            <c:forEach items="${clue}" var="wanted">
              <tr>
                <td>${wanted.id}</td>
                <td>${wanted.title}</td>
                <td>${wanted.name}</td>
                <td>
                  <a href="/back/showClue?clueid=${wanted.id}&pageNow=${page.pageNow}" type="button" class="btn btn-sm btn-default">详情</a>
                  <a href="javascript:if(confirm('确认删除吗?'))window.location='/back/deleteClue?clueid=${wanted.id}&pageNow=${page.pageNow}'"  type="button" class="btn btn-sm btn-default">删除</a>
                </td>
              </tr>
            </c:forEach>
          </table>
          <!-- 分页功能 start -->
          <div align="center">
            <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第
              ${page.pageNow} 页</font> <a href="clue?pageNow=1">首页</a>
            <c:choose>
              <c:when test="${page.pageNow - 1 > 0}">
                <a href="clue?pageNow=${page.pageNow - 1}">上一页</a>
              </c:when>
              <c:when test="${page.pageNow - 1 <= 0}">
                <a href="clue?pageNow=1">上一页</a>
              </c:when>
            </c:choose>
            <c:choose>
              <c:when test="${page.totalPageCount==0}">
                <a href="clue?pageNow=${page.pageNow}">下一页</a>
              </c:when>
              <c:when test="${page.pageNow + 1 < page.totalPageCount}">
                <a href="clue?pageNow=${page.pageNow + 1}">下一页</a>
              </c:when>
              <c:when test="${page.pageNow + 1 >= page.totalPageCount}">
                <a href="clue?pageNow=${page.totalPageCount}">下一页</a>
              </c:when>
            </c:choose>
            <c:choose>
              <c:when test="${page.totalPageCount==0}">
                <a href="clue?pageNow=${page.pageNow}">尾页</a>
              </c:when>
              <c:otherwise>
                <a href="clue?pageNow=${page.totalPageCount}">尾页</a>
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
