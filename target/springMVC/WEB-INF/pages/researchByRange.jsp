<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/3
  Time: 0:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>范围检索</title>
  <%@ include file="head.jsp" %>
  <script type="text/javascript">
    function check(v){
      var r=/^[0-9]+.?[0-9]*$/;
      if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
        alert('只能输入数字');
//      window.location = "/back/addWanted";
        document.getElementById("minheight").value = "";
        document.getElementById("maxheight").value = "";
        document.getElementById("minweight").value = "";
        document.getElementById("maxweight").value = "";

      }
    }
  </script>
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
    <h3>范围检索</h3>
    <div class="contact-form">

      <form:form action="/reByRange" method="get" methodParam="range" role="form">
        <div class="col-md-6 contact-left">
          <input style="" type="text" id="maxheight" value="${key1}" name="maxheight" placeholder="请输入身高上限" onpropertychange='check(this.value)' oninput='check(this.value)'/>
          <input style="" type="text" id="minheight" value="${key2}" name="minheight" placeholder="请输入身高下限" onpropertychange='check(this.value)' oninput='check(this.value)'/>
          <input style="" type="text" id="maxweight" value="${key3}" name="maxweight" placeholder="请输入体重上限" onpropertychange='check(this.value)' oninput='check(this.value)'/>
          <input style="" type="text" id="minweight" value="${key4}" name="minweight" placeholder="请输入体重下限" onpropertychange='check(this.value)' oninput='check(this.value)'/>
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
                  <a href="/showWanted?wantedid=${wanted.id}&return=2&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}" type="button" class="btn btn-sm btn-default">详情</a>
                </td>
              </tr>
            </c:forEach>
          </table>
          <!-- 分页功能 start -->
          <div align="center">
            <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第
              ${page.pageNow} 页</font> <a href="reByRange?pageNow=1&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">首页</a>
            <c:choose>
              <c:when test="${page.pageNow - 1 > 0}">
                <a href="reByRange?pageNow=${page.pageNow - 1}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">上一页</a>
              </c:when>
              <c:when test="${page.pageNow - 1 <= 0}">
                <a href="reByRange?pageNow=1&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">上一页</a>
              </c:when>
            </c:choose>
            <c:choose>
              <c:when test="${page.totalPageCount==0}">
                <a href="reByRange?pageNow=${page.pageNow}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">下一页</a>
              </c:when>
              <c:when test="${page.pageNow + 1 < page.totalPageCount}">
                <a href="reByRange?pageNow=${page.pageNow + 1}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">下一页</a>
              </c:when>
              <c:when test="${page.pageNow + 1 >= page.totalPageCount}">
                <a href="reByRange?pageNow=${page.totalPageCount}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">下一页</a>
              </c:when>
            </c:choose>
            <c:choose>
              <c:when test="${page.totalPageCount==0}">
                <a href="reByRange?pageNow=${page.pageNow}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">尾页</a>
              </c:when>
              <c:otherwise>
                <a href="reByRange?pageNow=${page.totalPageCount}&maxheight=${key1}&minheight=${key2}&maxweight=${key3}&minweight=${key4}">尾页</a>
              </c:otherwise>
            </c:choose>
          </div>
          <!-- 分页功能 End -->
        </table>
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
