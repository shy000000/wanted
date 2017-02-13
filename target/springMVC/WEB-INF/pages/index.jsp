<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<!---head-->
<head>
  <title>通缉网</title>
<%@ include file="head.jsp" %>
</head>
<body>
<!--body-->
<%--home--%>
<%@ include file="home.jsp" %>

<!---->
<%@ include file="service.jsp" %>
<!---->
<div class="author">
  <div class="container">
    <h3>欢迎广大群众拨打安全热线进行咨询</h3>
    <h4>- 安全热线：110</h4>
    </div>
</div>
<!---->
<script src="../js/jquery.min.js"> </script>
<script src="../js/responsiveslides.min.js"></script>

<script>
  // You can also use "$(window).load(function() {"
  $(function () {
    $("#slider2").responsiveSlides({
      auto: true,
      pager: true,
      speed: 300,
      namespace: "callbacks",
    });
  });
</script>

<!---->
<%@ include file="teamwork.jsp" %>
<!---contact-->
<%@ include file="contact.jsp" %>
<!---fotter-->
<%@ include file="fotter.jsp" %>
<!---->
<!-- toTop-->
<%@ include file="toTop.jsp"%>

</body>
</html>