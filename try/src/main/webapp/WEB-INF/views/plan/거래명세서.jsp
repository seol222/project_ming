<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<style>
.btn{
display:inline;
}
</style>
<div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Reservation</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">예약문의</p>
        </div>
      </div>
    </div>
  </div>
  
  
  <div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-12 col-lg-12 pb-4" data-aos="fade-up" data-aos-delay="200">
			<form  id = "frm" role="form" action="" method="post">
			<div class="row">
                <div class="col-6">
                  <div class="form-group">
                    <label class="text-black" for="fname">업체명</label>
                    <select name="type" class="form-control" style="min-width:6px;">
							<option value="">선택</option>
							<option value="AAA">AAA</option>
							<option value="AAA">BBB</option>
							<option value="AAA">CCC</option>
							<option value="AAA">DDD</option>
						</select>
                    
                  </div>
                </div>
                
              </div>


            
         					  <table class="table" id="crew">
								<tr>
									<th>날짜</th><th>품목</th><th>수량</th><th>단가</th><th>공급가액</th><th>세액</th><th></th>
								</tr>
								<tr>
									<td><input type="date" name="tradingDate" id="tradingDate0" class="form-control"></td>
									<td><input type="text" name="품목" id="subject0" class="form-control"></td>
									
									<td><input type="text" name="quantity" id="quantity0" class="form-control" onchange="assignment(0);" ></td>
									<td><input type="text" name="unitPrice" id="unitPrice0" class="form-control" onchange="assignment(0);"></td>
									<td><input type="text" name="supplyPrice" id="supplyPrice0" class="form-control"></td>
									<td><input type="text" name="taxAmount" id="taxAmount0" class="form-control"></td>
									
									<td style="width:160px;">
										<button class="btn btn-primary" type="button" onclick="addItem(this)" style="width:30%;">+</button>
										<button class="btn btn-primary" type="button" onclick="delItem(this)" style="width:30%;" >-</button>
									</td>
										
								</tr>
								
								
								
							</table>
             <!--  <div class="form-group">
                <label class="text-black">Title</label>
                <input class="form-control" id="title" name="title">
              </div>

              <div class="form-group">
                <label class="text-black">Content</label>
                <textarea  class="form-control" id="content" name="content" cols="30" rows="5"></textarea>
              </div>
                  -->

              <button type="submit" class="btn btn-primary">Register</button>
            </form>
  
  </div>
        </div>
      </div>
    </div>
  </div>
<script>

function assignment(target){
	$("#supplyPrice"+target).val($("#quantity"+target).val()*$("#unitPrice"+target).val());
	$("#taxAmount"+target).val($("#supplyPrice"+target).val()*0.1);	
		//console.log(a);
	}



function delItem(t){
	var len =  $('#crew tr').length;
	if(len>2){
		$(t).parent().parent().remove();		
		let html = "";
		html +=	'<button class="btn btn-primary" type="button" onclick="addItem(this)"style="width:30%;" >+</button>';
		html +=	'<button class="btn btn-primary" type="button" onclick="delItem(this)"style="width:30%;" >-</button>';
		
		$("#crew > tbody > tr:nth-child("+(len-1)+") > td:nth-child(7)").append(html);
		
	}else{
		alert("한개필수");
	}
	
	
}  
function addItem(t){
	
	//자기자신 삭제 
	$(t).parent().empty();
	
	let len =  $('#crew tr').length;
	console.log(len);
	
	let html = "";
	html += '<tr>';
	html += '<td><input type="date" name="tradingDate" id="tradingDate'+len+'" class="form-control"></td>';
	html += '<td><input type="text" name="subject" id="subject'+len+'" class="form-control"></td>';
	
	html += '<td><input type="text" name="quantity" id="quantity'+len+'" class="form-control" onchange="assignment('+len+');"></td>';
	html += '<td><input type="text" name="unitPrice" id="unitPrice'+len+'" class="form-control" onchange="assignment('+len+');"></td>';
	html += '<td><input type="text" name="supplyPrice" id="supplyPrice'+len+'" class="form-control"></td>';
	html += '<td><input type="text" name="taxAmount" id="taxAmount'+len+'" class="form-control"></td>';

	html += '<td><button class="btn btn-primary" type="button" onclick="addItem(this)" style="width:30%;" >+</button>';
	html += '<button class="btn btn-primary" type="button" onclick="delItem(this)" style="width:30%;" >-</button></td>';	
	html +=	'</tr>';
	
	$('#crew:last').append(html);
	
}




</script>
 <%@ include file="../includes/footer.jsp" %>