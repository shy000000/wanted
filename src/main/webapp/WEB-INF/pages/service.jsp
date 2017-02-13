<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 21:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="service" class="service">
  <div class="container">
    <div class="service-head">
      <h3>检索</h3>
      <h4>我们可以做什么？</h4>
    </div>
    <div class="service-grids">
      <div class="col-md-4 service-grid">
        <img src="../images/pic1.png" alt="" onclick="researchById()"/>
        <h3>精确检索</h3>
        <h4>按身份证检索通缉信息</h4>
      </div>
      <div class="col-md-4 service-grid">
        <img src="../images/pic2.png" alt="" onclick="researchByRange()"/>
        <h3>范围检索</h3>
        <h4>按身高范围、体重范围检索通缉信息</h4>
      </div>
      <div class="col-md-4 service-grid">
        <img src="../images/pic3.png" alt="" onclick="researchByName()"/>
        <h3>名字检索</h3>
        <h4>按名字(部分匹配)检索通缉信息</h4>
      </div>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<script type="text/javascript">
  function researchById(){
    window.location.href = "researchById";
  }
  function researchByRange(){
    window.location.href = "researchByRange";
  }
  function researchByName(){
    window.location.href = "researchByName";
  }
</script>
