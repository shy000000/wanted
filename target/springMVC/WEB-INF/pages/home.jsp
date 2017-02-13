<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 21:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="home" class="banner">
  <div class="container">
    <div class="top-header">
      <div class="logo">
        <img src="../images/logo.png" alt="" />
      </div>
      <div class="top-menu">
        <span class="menu"> </span>
        <ul>
          <nav class="cl-effect-5">
            <li><a class="active scroll"  href="#home"><span data-hover="HOME">----主页----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#service"><span data-hover="SEARCH">----检索----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#teamwork"><span data-hover="WANTED">----通缉令----</span></a></li>
            <li>/</li>
            <li><a class="scroll" href="#contact"><span data-hover="REPORT">----举报----</span></a></li>
            <li>/</li>
            <li><a  href="loggedin"><span data-hover="LAND">----登陆----</span></a></li>
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