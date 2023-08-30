<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>




  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Parking</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">입출차관리</p>
        </div>
      </div>
    </div>
  </div>


  <div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-6 col-lg-4 pb-3" data-aos="fade-up" data-aos-delay="200">


            <form id = "frm" role="form" method="post" action="/park/in">
              <div style="width: 600px; margin: auto;">
                <div class="col-6">
                  <div class="form-group">
                    <label class="text-black" for="fname">차량번호</label>
                    <input type="text" class="form-control" id="car_number" name="car_number">
                  </div>
                </div>                
             </div>
              
			<div>
              <button id="btnsubmit" type="submit" style="text-align: center; display :inline-block;" class="btn btn-primary">IN</button>
              <button id="btnsubmit" type="submit" style="text-align: center; display :inline-block;" class="btn btn-primary">OUT</button>
            </div>
            </form>

          </div>





        </div>

      </div>

    </div>


  </div>


  

<script>
$(document).ready(function(){
	
	$("button[type=submit]").on("click",function(e){
		e.preventDefault();
		
		let car_number = $("#car_number").val();
				
		
		if(car_number == ''){
			alert("차량번호 입력하세요");
			return;
		}else{	
		
		$("#frm").submit();
	
		}
		
	
		}); 

});
</script>



    <%@ include file="../includes/footer.jsp" %>