<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
    
<%@ include file="./includes/header.jsp" %>




  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Login</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">로그인${error }</p>
          
        </div>
      </div>
    </div>
  </div>


  <div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-6 col-lg-4 pb-3" data-aos="fade-up" data-aos-delay="200">


            <form method="post" action="/login">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
              <div style="width: 600px; margin: auto;">
                <div class="col-6">
                  <div class="form-group">
                    <label class="text-black" for="fname">ID</label>
                    <input type="text" class="form-control" id="mb_id" name="username">
                  </div>
                </div>
                <div class="col-6">
                  <div class="form-group">
                    <label class="text-black" for="lname">Password</label>
                    <input type="password" class="form-control" id="mb_pw" name="password">
                  </div>
                  <div>
	                <input type="checkbox" name="remember-me">로그인상태 유지
	                </div>
                  
                </div>
                
             </div>
              

              <button id="btnsubmit" type="submit" class="btn btn-primary">Login</button>
              
            </form>

          </div>





        </div>

      </div>

    </div>


  </div>


  <div class="site-section">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6 text-center">
          <h4 class="font-weight-bold">Our Clients</h4>
          <div class="line my-3 mx-auto"></div>
        </div>
      </div>

      <div class="owl-logos owl-carousel no-nav">
        <div class="item">
          <img src="/resources/untree/images/logo-puma.png" alt="Image" class="img-fluid">
        </div>
        <div class="item">
          <img src="/resources/untree/images/logo-adobe.png" alt="Image" class="img-fluid">
        </div>
        <div class="item">
          <img src="/resources/untree/images/logo-google.png" alt="Image" class="img-fluid">
        </div>
        <div class="item">
          <img src="/resources/untree/images/logo-paypal.png" alt="Image" class="img-fluid">
        </div>
        <div class="item">
          <img src="/resources/untree/images/logo-adobe.png" alt="Image" class="img-fluid">
        </div>
        <div class="item">
          <img src="/resources/untree/images/logo-google.png" alt="Image" class="img-fluid">
        </div>


      </div>


    </div>

  </div>

<script>

</script>



    <%@ include file="./includes/footer.jsp" %>