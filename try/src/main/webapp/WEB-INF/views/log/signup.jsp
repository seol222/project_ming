<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Sign Up</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">회원가입</p>
        </div>
      </div>
    </div>
  </div>
  

<div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-12 col-lg-12 pb-4" data-aos="fade-up" data-aos-delay="200">

			<div class="simple-page-form animated flipInY" id="signup-form">
	           <form method ="post" action="/log/signup" id="frm">
	           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	           
	              <div style="width: 800px; margin: auto; " >
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="fname">ID</label>
	                    <input type="text" class="form-control" id="mb_id" name="mb_id"> 
	                    <p id="idErrMsg"></p>                  
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">Password</label>
	                    <input type="text" class="form-control" id="mb_pw" name="mb_pw">
	                    <p id="pwErrMsg"></p>
	                  </div>
	                </div>
	             
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">name</label>
	                    <input type="text" class="form-control" id="mb_name" name="mb_name">
	                    <p id="nameErrMsg"></p>
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">email</label>
	                    <input type="text" class="form-control" id="mb_email" name="mb_email">
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">phone</label>
	                    <input type="text" class="form-control" id="mb_phone" name="mb_phone">
	                    <p id="phoneErrMsg"></p>
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group"  >
	                    <label class="text-black" for="lname">code</label>
		                    <div style="width: 100%; text-align:center; display:flex;">
			                    <input type="text" class="form-control" id="mb_code" name="mb_code" style="width:85%;" readonly="readonly" >
			                    <button type="button" onclick="sample6_execDaumPostcode()" style="display :inline-block">찾기</button>
		                    </div>
	                  </div>
	                </div>
	              	
	              	<div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">adress</label>
	                    <input type="text" class="form-control" id="mb_addr" name="mb_addr" style="width:100%" readonly="readonly" >
						 <label class="text-black" for="lname">extra</label>
						<input type="text" class="form-control"  id="mb_extra"  name="mb_extra" style="width:100%">
	                  </div>
	                </div>
	                
	                 <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <input id="mb_yes" name="mb_yynn" type="radio" value="Y" placeholder="YES">YES<br>
						<input id="mb_no" name="mb_yynn" type="radio" value="N" placeholder="NO"> NO
	                  </div>
	                </div>
	      
	                </div>           
	
	              <button id="btnsubmit" type="submit" class="btn btn-primary" style="width:200px;">sign up</button>
	           </form>
			</div>	 
          </div>
        </div>
      </div>
    </div>
  </div>




<%@ include file="../includes/footer.jsp" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("mb_extra").value = extraAddr;
                
                } else {
                    document.getElementById("mb_extra").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mb_code').value = data.zonecode;
                document.getElementById("mb_addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
              
            }
        }).open();
    }
</script>
<script>

var pwValidate = -1;

$(document).ready(function(){
	$('#mb_id').on("blur",function(){
		let mb_id = $('#mb_id').val().trim();
		
		if(mb_id =='' ){
			$('#idErrMsg').text('아이디는 6~16글자 입력 필수');
			$('#idErrMsg').css('color','red');
			$('#mb_id').focus();
		}else if(mb_id.length < 6 || mb_id.length > 16 ){
			$('#idErrMsg').text('아이디는 6~16글자 입력 필수');
			$('#idErrMsg').css('color','blue');
			$('#mb_id').focus();
		}else{
			$('#idErrMsg').text('');
			$('#idErrMsg').css('color','black');
			
			$.ajax({
				type:"GET",
				url:"/log/idchkajax",
				data:{mb_id:mb_id},
				dataType:'json',
				success:function(result){
	            	console.log("dddd"+result);
					if(result==0){
		            	console.log('Success');
		            	$('#idErrMsg').text('사용 가능한 아이디 입니다.');
		    			$('#idErrMsg').css('color','green');		    			
		            } else{
		            	console.log('Fail');
		            	$('#idErrMsg').text('중복된 아이디 입니다.');
		    			$('#idErrMsg').css('color','red');
		    			$('#mb_id').focus();
		            }
		            	
		           
		            //console.log("["+res+"]");
		        },
		        error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		        	console.log("통신 실패.")
		        }     
		        //$("#frm").submit();
			
				});
		}
	});	
	
	$("button[type=submit]").on("click",function(e){
		e.preventDefault();
		
		let mb_id = $("#mb_id").val();
		let mb_pw = $("#mb_pw").val();		
		let mb_name = $("#mb_name").val();		
		let mb_phone = $("#mb_phone").val();		
		
		if(mb_id == ''){
			alert("아이디를 입력하세요");
			return;
		}else if(mb_pw == ''){
			alert("비밀번호를 입력하세요");
			return;
		}else if(mb_name == ''){
			alert("이름을 입력하세요");
			return;
		}else if(mb_phone == ''){
			alert("전화번호를 입력하세요");
			return;
		}else{
		
		
		$("#frm").submit();
	
		}
		
	
		}); 

});

</script>
</body>
</html>



