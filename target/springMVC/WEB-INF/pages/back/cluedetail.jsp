<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/4
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>线索详情</title>
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
            <li><a class="scroll" href="#service"><span data-hover="CLUEDETIAL">----线索详情----</span></a></li>
            <li>/</li>
            <li><a href="/back/clue?pageNow=${pageNow}"><span data-hover="">----返回----</span></a></li>
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
    <h3>线索详情</h3>
    <div class="contact-form">
      <table class="table tavble-bordered table-striped">
        <tr>
          <th>线索编号</th>
          <td>${clue.id}</td>
        </tr>
        <tr>
          <th>线索标题</th>
          <td>${clue.title}</td>
        </tr>
        <tr>
          <th>举报者姓名</th>
          <td>${clue.name}</td>
        </tr>
        <tr>
          <th>举报者联系电话</th>
          <td>${clue.phone}</td>
        </tr>
        <tr>
          <th>内容</th>
          <td>${clue.content}</td>
        </tr>
      </table>
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
