<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 21:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
  function check(v){
    var r=/^[0-9]+.?[0-9]*$/;
    if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
      alert('只能输入数字');
//      window.location = "/back/addWanted";
      document.getElementById("phone").value = "";
    }
  }
</script>
<div id="contact" class="contact">
  <div class="container">
    <h3>我们欢迎您的举报</h3>
    <h4>请在下方填写举报信息，姓名和联系电话可以不填</h4>
    <div class="contact-form">

      <form:form action="/report" method="post" commandName="clue" role="form">
        <div class="col-md-6 contact-left">
          <input type="text" id="title" name="title" placeholder="线索标题" required/>
          <input type="text" id="phone" name="phone" placeholder="举报人联系电话（可不录入）" onpropertychange='check(this.value)' oninput='check(this.value)'/>
          <input type="text" id="name" name="name" placeholder="姓名（可不录入）" />
        </div>
        <div class="col-md-6 contact-right">
          <textarea id="content" name="content" placeholder="线索内容" required></textarea>
          <input type="submit" value="举报"/>
        </div>
        <div class="clearfix"></div>

      </form:form>

    </div>
  </div>
</div>