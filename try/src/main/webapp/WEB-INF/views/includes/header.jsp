<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!doctype html>
<html lang="en">
<style>
.heee{
font-size:25px;
}
</style>


<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="free template, bootstrap, bootstrap4" />

  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Crimson+Text:ital@0;1&family=Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
  
  <link rel="stylesheet" href="/resources/untree/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/untree/css/animate.min.css">
  <link rel="stylesheet" href="/resources/untree/css/owl.carousel.min.css">
  <link rel="stylesheet" href="/resources/untree/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="/resources/untree/fonts/icomoon/style.css">
  <link rel="stylesheet" href="/resources/untree/fonts/feather/style.css">
  <link rel="stylesheet" href="/resources/untree/fonts/flaticon/font/flaticon.css">
  <link rel="stylesheet" href="/resources/untree/css/jquery.fancybox.min.css">
  <link rel="stylesheet" href="/resources/untree/css/aos.css">
  <link rel="stylesheet" href="/resources/untree/css/style.css">

<!-- build:js /resources/assets/js/core.min.js -->
	<script src="/resources/libs/bower/jquery/dist/jquery.js"></script>
	<script src="/resources/libs/bower/jquery-ui/jquery-ui.min.js"></script>
	<script src="/resources/libs/bower/jQuery-Storage-API/jquery.storageapi.min.js"></script>
	<script src="/resources/libs/bower/bootstrap-sass/assets/javascripts/bootstrap.js"></script>
	<script src="/resources/libs/bower/jquery-slimscroll/jquery.slimscroll.js"></script>
	<script src="/resources/libs/bower/perfect-scrollbar/js/perfect-scrollbar.jquery.js"></script>
	<script src="/resources/libs/bower/PACE/pace.min.js"></script>
	<script src='/resources/dist/index.global.js'></script>
	
<!-- 	<script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
    <link href='/resources/full/fullcalendar.main.min.css' rel='stylesheet' />
	
    <script src='/resources/full/fullcalendar.main.min.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.min.js"></script>
	
	<link href='/resources/clib/main.css' rel='stylesheet' />
	<script src='/resources/clib/main.js'></script> -->
	
	<!-- endbuild -->
	
	
  <title>Ming!</title>
</head>
<body>

  <div class="lines-wrap">
    <div class="lines-inner">
      <div class="lines"></div>
    </div>
  </div>
  <!-- END lines -->
  


 <!--  <div class="site-mobile-menu site-navbar-target">
    <div class="site-mobile-menu-header">
      <div class="site-mobile-menu-close">
        <span class="icofont-close js-menu-toggle"></span>
          
      </div>
    </div>
    <div class="site-mobile-menu-body"></div>
  </div>
      
  <nav class="site-nav">
  <a href="/" class="logo float-left m-3">Style <span class="text-primary">.</span></a>
  
    <div class="container">
    
    
      <div class="site-navigation">
        <a href="/" class="logo float-left m-0">Style <span class="text-primary">.</span></a>


      </div>
    </div>
  </nav> -->
  
    <div class="container" >
  
  </div>
  
   <div class="container">
  <div class="filters" data-aos="fade-up" data-aos-delay="100">
  <a href="/" class="logo float-left m-0">ming <span class="text-primary">!</span></a>
  
  
  
  
  
  
  
        <ul style="padding:40px;">
		
          <!-- <li class="heee"><a href="/" >Main</a></li> -->
          <!-- <li class="heee"><a href="/park/park" >Parking</a></li> -->
          <li class="heee"><a href="/board/list" >Board</a></li>
          <li class="heee"><a href="/plan/reservation">Reservation</a></li>
          <li class="heee"><a href="/plan/callender">Callender</a></li>
          <sec:authorize access="isAnonymous()"> 
          <li class="heee"><a href="/log/signup" >Signup</a></li>
          <li class="heee"><a href="/customLogin">Login</a></li>
          </sec:authorize>
          
          <sec:authorize access="isAuthenticated()">
          
			<li class="heee"><a href="/log/mypage">Mypage</a></li>
           <li class="heee"><a href="javascript:void(0);$('#logout').submit();">Logout</a></li>
           <form  id="logout" method="post" action="/customLogout">
           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
           </form>
           
           
          
          </sec:authorize>
        </ul>
      </div> 
      </div>