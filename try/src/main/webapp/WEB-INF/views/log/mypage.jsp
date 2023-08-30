<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Mypage</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">회원정보 조회 및 수정</p>
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
	           <form method ="post" action="/log/resignup" id="frm">
	           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	           
	              <div style="width: 800px; margin: auto; " >
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="fname">ID</label>
	                    <input type="text" class="form-control" id="mb_id" name="mb_id" value="${list.mb_id }" readonly="readonly">                   
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">Password</label>
	                    <input type="text" class="form-control" id="mb_pw" name="mb_pw" value="<%-- ${list.mb_pw } --%>" readonly="readonly">
	                  </div>
	                </div>
	             
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">name</label>
	                    <input type="text" class="form-control" id="mb_name" name="mb_name" value="${list.mb_name }" readonly="readonly">
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">email</label>
	                    <input type="text" class="form-control" id="mb_email" name="mb_email" value="${list.mb_email }">
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">phone</label>
	                    <input type="text" class="form-control" id="mb_phone" name="mb_phone" value="${list.mb_phone }">
	                  </div>
	                </div>
	                
	                <div class="col-6" style="margin: auto;">
	                  <div class="form-group"  >
	                    <label class="text-black" for="lname">code</label>
		                    <div style="width: 100%; text-align:center; display:flex;">
			                    <input type="text" class="form-control" id="mb_code" name="mb_code" style="width:85%;" readonly="readonly"  value="${list.mb_code }">
			                    <button type="button" onclick="sample6_execDaumPostcode()" style="display :inline-block">찾기</button>
		                    </div>
	                  </div>
	                </div>
	              	
	              	<div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <label class="text-black" for="lname">adress</label>
	                    <input type="text" class="form-control" id="mb_addr" name="mb_addr" style="width:100%" readonly="readonly" value="${list.mb_addr }" >
						 <label class="text-black" for="lname">extra</label>
						<input type="text" class="form-control"  id="mb_extra"  name="mb_extra" style="width:100%" value="${list.mb_extra }">
	                  </div>
	                </div>
	                
	                 <div class="col-6" style="margin: auto;">
	                  <div class="form-group">
	                    <input id="mb_yes" name="mb_yynn" type="radio" value="Y" <c:if test="${list.mb_yynn eq 'Y' }" > checked="chedcked" </c:if>  >YES<br>
						<input id="mb_no" name="mb_yynn" type="radio" value="N" <c:if test="${list.mb_yynn eq 'N' }"> checked="chedcked" </c:if>> NO
	                  </div>
	                </div>
	      
	      
	      
	      
	      
	                </div>           
	
	              <button id="btnsubmit" type="submit" class="btn btn-primary" style="width:200px;">정보수정</button>
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
$(document).ready(function(){
	$("button[type=submit]").on("click",function(e){
		e.preventDefault();
		
		let mb_id = $("#mb_id").val();
		let mb_pw = $("#mb_pw").val();		
		let mb_name = $("#mb_name").val();		
		let mb_phone = $("#mb_phone").val();		
		
		if(mb_id == ''){
			alert("아이디를 입력하세요");
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



