<%--
  Created by IntelliJ IDEA.
  User: shy
  Date: 2016/1/2
  Time: 21:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="teamwork" class="teamwork">
  <div class="container">
    <div class="team-head">
      <h3>通缉令</h3>
      <h4>这只是一部分的通缉犯</h4>
    </div>
    <div class="clients">
      <div class="course_demo1">
        <ul id="flexiselDemo1">
          <li>
            <div class="client">
              <img src="../images/per1.png" alt="" />
              <h3>Anas.Emad</h3>
              <h4>EMARKETING SPECIALIST</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per2.png" alt="" />
              <h3>M.Baghago</h3>
              <h4>UI/UX DESIGNER</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per4.png" alt="" />
              <h3>Ahmed Ali</h3>
              <h4>SENIOR UI DESIGNER</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per3.png" alt="" />
              <h3>A.Eliminshawy</h3>
              <h4>GRAPHIC DESIGNER</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per2.png" alt="" />
              <h3>A.Eliminshawy</h3>
              <h4>GRAPHIC DESIGNER</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per3.png" alt="" />
              <h3>M.Baghago</h3>
              <h4>UI/UX DESIGNER</h4>
            </div>
          </li>
          <li>
            <div class="client">
              <img src="../images/per4.png" alt="" />
              <h3>Ahmed Ali</h3>
              <h4>SENIOR UI DESIGNER</h4>
            </div>
          </li>
        </ul>
      </div>
      <link rel="stylesheet" href="../css/flexslider.css" type="text/css" media="screen" />
      <script type="text/javascript">
        $(window).load(function() {
          $("#flexiselDemo1").flexisel({
            visibleItems: 4,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: true,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
              portrait: {
                changePoint:480,
                visibleItems: 1
              },
              landscape: {
                changePoint:640,
                visibleItems: 2
              },
              tablet: {
                changePoint:768,
                visibleItems: 3
              }
            }
          });

        });
      </script>
      <script type="text/javascript" src="../js/jquery.flexisel.js"></script>
    </div>
  </div>
</div>
