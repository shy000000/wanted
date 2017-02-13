<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <link href="../css/bootstrap.css" rel='stylesheet' type='text/css'/>
  <link href="../css/style.css" rel="stylesheet" type="text/css" media="all"/>
  <!--字体-->
  <%--<link href='http://fonts.useso.com/css?family=Source+Code+Pro:200,300,400,500,600,700,900' rel='stylesheet' type='text/css'>--%>
  <!--视口-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!--关键字-->
  <meta name="keywords" content="Jalil Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
  <!--设置加载页面时回到顶部-->
  <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
  <script src="../js/jquery.min.js"> </script>
  <!---- start-smoth-scrolling---->
  <script type="text/javascript" src="../js/move-top.js"></script>
  <script type="text/javascript" src="../js/easing.js"></script>

  <script type="text/javascript">
    jQuery(document).ready(function($) {
      $(".scroll").click(function(event){
        event.preventDefault();
        $('html,body').animate({scrollTop:$(this.hash).offset().top},900);
      });
    });
  </script>
  <!---- start-smoth-scrolling---->
