<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/8
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>添加通缉犯</title>
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
            <li><a class="scroll" href="#service"><span data-hover="ADDWANTED">----通缉犯管理-添加通缉犯----</span></a></li>
            <li>/</li>
            <li><a href="/back/wanted?"><span data-hover="">----返回----</span></a></li>
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
<script type="text/javascript">

  function pidImport() {
    var url = "/back/addWantedPost?";
    var inputList = document.getElementsByTagName("input");
    var id = document.upload.id.value;
    url += "id=" + id;
    var name = document.upload.name.value;
    var gender = document.upload.gender.value;
    var high = document.upload.high.value;
    var weight = document.upload.weight.value;
    var phone = document.upload.phone.value;
    var feature = document.upload.feature.value;
    url += "&name="+name+"&gender="+gender+"&high="+high+"&weight="+weight+"&phone="+phone+"&feature="+feature;
    document.all.upload.action = url;
    document.all.upload.submit();
  }
</script>
<%--数字检查--%>
<script>
  function checkh(v){
    var r=/^[0-9]+.?[0-9]*$/;
    if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
      alert('只能输入数字');
//      window.location = "/back/addWanted";
      document.getElementById("high").value = "";


    }
  }
</script>
<script>
  function checkw(v){
    var r=/^[0-9]+.?[0-9]*$/;
    if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
      alert('只能输入数字');
//      window.location = "/back/addWanted";

      document.getElementById("weight").value = "";

    }
  }
</script>
<script>
  function checkp(v){
    var r=/^[0-9]+.?[0-9]*$/;
    if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
      alert('只能输入数字');
//      window.location = "/back/addWanted";

      document.getElementById("phone").value = "";

    }
  }
</script>
<script>
  function checkId (v){
    var num = 18;
    if(v.length>18){
      alert("我国身份证号为18位");
      document.getElementById("id").value = v.substr(0,18);
    }
  }
</script>
<div id="service" class="contact">
  <div class="container">
    <h3>通缉犯管理-添加通缉犯</h3>
    <div class="contact-form">
      <form:form name="upload" action="/back/addWantedPost" method="post" commandName="wanted" role="form" enctype="multipart/form-data">
        <div class="col-md-6 contact-left">
          身份证号码：<input type="text" id="id" name="id" value="${id}" onpropertychange='checkId(this.value)' oninput='checkId(this.value)' required/>
          姓名：<input type="text" id="name" name="name" value="${name}" required/>
          性别：<input type="text" id="gender" name="gender" value="${gender}"  required/>
          身高：<input type="text" id="high" name="high" value="${high}" onpropertychange='checkh(this.value)' oninput='checkh(this.value)' required/>
          体重：<input type="text" id="weight" name="weight" value="${weight}" onpropertychange='checkw(this.value)' oninput='checkw(this.value)' required/>
          举报电话：<input type="text" id="phone" name="phone" value="${phone}" onpropertychange='checkp(this.value)' oninput='checkp(this.value)'  required/>
          照片：<input type="file" id="photo" name="photo" >
        </div>
        <div class="col-md-6 contact-right">
          <textarea id="feature" name="feature" placeholder="体态特征"  required>${feature}</textarea>
          <input type="submit" style="position: absolute" value="添加" onclick="pidImport();"/>
        </div>
        <div class="clearfix"></div>

      </form:form>
      <c:if test="${haswanted == 1}">
        <p class="bg-warning">
          <br/>
          通缉犯已存在，请重新输入
          <br/>
          <br/>
        </p>
      </c:if>
      <c:if test="${idnot == 0}">
        <p class="bg-warning">
          <br/>
          身份证号码不合法，请输入正确的身份证号
          <br/>
          <br/>
        </p>
      </c:if>
      <c:if test="${gendernot == 0}">
        <p class="bg-warning">
          <br/>
          性别只有"男"或"女"
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
