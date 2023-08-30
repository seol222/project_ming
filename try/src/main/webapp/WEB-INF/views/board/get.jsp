<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
    
<%@ include file="../includes/header.jsp" %>




  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">View(get)</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">작성한 글 확인</p>
        </div>
      </div>
    </div>
  </div>

  <div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-12 col-lg-12 pb-4" data-aos="fade-up" data-aos-delay="200">
 <%-- <input type="hidden" name="bno" value="${board.bno }" />
            
           <div class="form-group">              
                <label class="text-black">bno</label>
                <div >${board.bno }</div>
              </div> --%>
            


            <form role="form" action="" method="post" id="frm">
           <input type="hidden" name="bno" value="${board.bno }" />
           <input type="hidden" name="pageNum" value="${cri.pageNum }" />
           <input type="hidden" name="amount" value="${cri.amount }" />
           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
           
              <div class="form-group">              
                <label class="text-black" style="font-size:20px; font-weight: bold;">Title</label>
                <div>${board.title }</div>
              </div>

              <div class="form-group">
                <label class="text-black" style="font-size:20px; font-weight: bold;">Content</label>
                <div>
                <%
                pageContext.setAttribute("newLineChar", "\n");
				%>
				${fn:replace(board.content, newLineChar,'<br/>')}
              </div>
              </div>
              <div class="row">
                <div class="col-6"> 
                  <div class="form-group">
                    <label class="text-black" for="fname" style="font-size:20px; font-weight: bold;">Writer</label>
                    <div>${board.writer }</div>
                  </div>
                </div>
                
              </div>
			<div class="row">
			
			<sec:authentication property="principal" var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.writer}">
			  <a href="/board/modify?bno=${board.bno }" class="btn btn-primary">Modify</a>
              <button type="button" class="btn btn-primary" id="btn_remove">Delete</button>
              </c:if>
			</sec:authorize>
              
              <a href="javascript:history.go(-1);" class="btn btn-primary">List</a>
              </div>
            </form>
            
            <!-- 첨부파일 -->
 <div class="container pb-5 mb-5 border-bottom">
    <div class="row">
      <div class="col-lg-12">
        <h1 class="h6 mb-3 text-black">파일첨부</h1>
      </div>
      <div class="col-lg-12">
        <div class="custom-accordion" id="accordion_1">
          <div class="accordion-item">
            
            
            <div class="uploadResult">
            <ul style = "display:flex; list-style-type: none;">
            
            </ul>
            </div>
            
   
          </div> <!-- .accordion-item -->

        </div>
      </div>
    </div>
  </div>
<!-- 첨부파일 끝 -->
           	
           	<!-- 댓글!!!!!!!!!!!!!! -->
          
			
							
           	<div class="pt-5">
            <h3 class="mb-5">6 Reply</h3>
             <form action="#" onsubmit="return false;">	
              <input type="hidden" name="rno" id="rno">
             <div class="form-group">
             
	             <div class="col-sm-9" >           
					<label for="exampleTextInput1" class="col-sm-3 control-label" style="display: inline-block;">Writer :</label>					
						<input style="display: inline-block; "type="text" class="form-control input-sm" id="replyer" name="replyer" readonly="readonly" required="required" value="<sec:authentication property="principal.username"/>">
				</div>
			</div>	
           	<div class="form-group">
				<label for="textarea1" class="col-sm-3 control-label">Content :</label>
					<div class="col-sm-9">
						<textarea style="display: inline-block; "class="form-control input-sm" id="reply" name="reply" placeholder="댓글내용" required="required"></textarea>						
						<sec:authorize access="isAuthenticated()" > 
							<button style="display: inline-block; float: right;" class="btn btn-primary"  id="btn_reply" name="btn_reply">New Reply</button>
					 	</sec:authorize>
					</div>			
			</div>
			</form>
			
			<div id="chat">
			
           <!--  <ul class="comment-list">
              <li class="comment">
                
                <div class="comment-body">
                  <h3>댓글작성자이름</h3>
                  <div class="meta">작성일January 9, 2018 at 2:21pm</div>
                  <p>댓글내용~~~~</p>
                  
                  <p style="display: inline-block;"><a href="#" class="reply">수정</a></p>
                  <p style="display: inline-block;"><a href="#" class="reply">삭제</a></p>
                	
                
                </div>
              </li>
			</ul> -->
			</div>
			</div> 
				<!-- 댓글 끝!!!!!!!!!!!!!! -->	
				
			</div>
          </div>

        </div>

      </div>
 </div>




<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var pageNum = 1;
var bno = '${board.bno }';

function btn_modi(t,i){
	$("#aaa"+i).hide();
	$("#btn_modi"+i).css({"display":"block"});
	$("#re_modify"+i).hide();
	$("#btn_modify"+i).css({"display":"inline-block"});
}

function btn_del(t,i){
	//console.log("삭제버튼클릭");
	
	let rno = i;
	
	//console.log(rno);
	
	if (confirm("정말로 삭제하시겠습니까?")) {
		// ajax 통신
		$.ajax({
			type : "DELETE", // HTTP method type(GET, POST) 형식이다.
			url : "/replies/" + rno, // 컨트롤러에서 대기중인 URL 주소이다.
			data:JSON.stringify({rno:rno }),  //, reply:reply,replyer:replyer
			contentType :"application/json; charset=utf-8",
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				//console.log("댓글 등록 성공");
				if (res == 'success') {
					getList();
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				console.log("통신 실패.");
			}
		});

		

	}
	
}

//a -> '+res[i].rno+',
//b -> '+ res[i].replyer +', 
//c -> '+res[i].reply+'


function btn_modify(t,i,b,a){
	console.log("수정등록클릭");
	
	let rno = a;
	let replyer = b;
	let reply = $("#btn_modi"+i).val();
	let bno = '${board.bno}';
	let data = {
			bno : bno,
			reply : reply,
			replyer : replyer
		}; 

		//console.log(reply);
		//console.log(replyer);
		//console.log(bno);
		//console.log(data);
		
	
	if (reply == "") {
		alert("댓글내용 입력");
	}  else {

		// ajax 통신
		$.ajax({
			type : "PUT", 
			url : "/replies/" + rno, // 컨트롤러에서 대기중인 URL 주소이다.
			contentType : 'application/json',
			data : JSON.stringify(data), // Json 형식의 데이터이다.
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				//console.log(res);
				if (res == 'success') {
					getList();
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				console.log("통신 실패.");
			}
		});

		

	} 
	
}

function getList() {
	
	// ajax 통신
	$.ajax({
				type : "GET", // HTTP method type(GET, POST) 형식이다.
				url : "/replies/pages/${board.bno}/"+pageNum+".json", // 컨트롤러에서 대기중인 URL 주소이다.
				//contentType : 'application/json',
				//data : JSON.stringify(data),           // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					//let jsonArr = JSON.parse(res)
					let html = "";
				
					for (let i = 0; i < res.length; i++) {
						
						html +=	 '<ul class="comment-list">';
						html +=	 '<li class="comment">';
						html +=	 '<div class="comment-body">';
						html +=	 '<h3>'+ res[i].replyer + '</h3>';
						html +=	 '<div class="meta">'+ (new Date(res[i].replyDate).toLocaleString()) + '</div>';
						html +=	 '<p id="aaa'+[i]+'" >'+ res[i].reply + '</p> '; 
						html +=	 '<input id="btn_modi'+[i]+'" style="display:none;" class="form-control input-sm" value="'+res[i].reply+'"> ';
						html +=	 '<p style="display: inline-block;" class="reply" id="re_modify'+[i]+'" data-dismiss="" onclick="btn_modi(this,'+i+')" >수정</p>';
						
						/* html +=	 '<p style="display: none;" class="reply" id="btn_modify'+[i]+'" data-dismiss="" onclick="btn_modify(this,'+res[i].rno+', \''+ res[i].replyer +'\',  \''+res[i].reply+'\' )" >등록</p>'; */
						
						html +=	 '<p style="display: none;" class="reply" id="btn_modify'+[i]+'" data-dismiss="" onclick="btn_modify(this , '+i+',  \''+res[i].replyer+'\', \''+res[i].rno+'\'    )" >등록</p>';
						html +=	 '<p id="btn_del'+[i]+'" style="display: inline-block;" class="reply" data-dismiss="" onclick="btn_del(this,'+res[i].rno+')" >삭제</p>';	
						
						
						html +=	 '<span  style="display:none" data-reply="'
							+ res[i].reply
							+ '" data-rno="'
							+ res[i].rno
							+ '">'
							+ res[i].replyer + '</span>';
						
						html +=	 '</div>';
						html +=	 '</li>';
						html +=	 '</ul>	';			

						


					}

					$("#chat").html(html);
					//showReplyPage(res.replyCnt); // 페이징

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					console.log("통신 실패.");
				}
			});
}
 

$(document).ready(function() {

	getList();
	

	$("#btn_remove").on("click", function(e) {

		if (confirm("정말로 삭제하시겠습니까?")) {
			$("#frm").attr("action", "remove");
			$("#frm").submit();
		}
		console.log("삭제버튼");	
	});
	
/* 	//댓글수정
	$(document).on("click", "#btn_modify", function() {

		let rno = $("#rno").val();
		let reply = $("#reply").val();
		let replyer = $("#replyer").val();
		let bno = '${board.bno}';
		let data = {
			bno : bno,
			reply : reply,
			replyer : replyer
		};

		if (reply == '') {
			alert("댓글내용 입력");
		} else if (replyer == '') {
			alert("작성자 입력");
		} else {

			// ajax 통신
			$.ajax({
				type : "PUT", // HTTP method type(GET, POST) 형식이다.
				url : "/replies/" + rno, // 컨트롤러에서 대기중인 URL 주소이다.
				contentType : 'application/json',
				data : JSON.stringify(data), // Json 형식의 데이터이다.
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					//console.log("댓글 등록 성공");
					if (res == 'success') {
						getList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					console.log("통신 실패.");
				}
			});

			$("#composeModal").modal('hide');

		}

		console.log("btn_modify");

	});
	
	
	//댓글수정 끝 */
	
	
	
	
	
	$.getJSON("./getAttachList",{bno:bno}, function(arr){
		console.log(arr);
		
		let str = "";
		$(arr).each(function(i,attach){
			
			var fileRealPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
			
			
			//파일 타입이 
			if(attach.fileType){
				//그림파일이면
				var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
				str += '<li style="padding:5px;">';
				str += '<a href="../download?fileName='+fileRealPath+'">';
				str += '<img src="../display?fileName='+fileCallPath+'">';					
				str += '</a>';					
				str += '</li>';
				
			}else{
				//그림파일이 아니면
				str += '<li style="padding:5px;">';
				str += '<a href="../download?fileName='+fileRealPath+'">';
				str += '<img src="/resources/untree/images/att.png" width="100">';					
				str += '</a>';					
				str += '</li>';
				
				
			}
			
		});
		
		$(".uploadResult ul").html(str);
		
		
	});
	
	$(document).on("click", "#btn_reply", function() {
		let reply = $("#reply").val();
		let replyer = $("#replyer").val();
		let bno = '${board.bno}';
		let data = {
			bno : bno,
			reply : reply,
			replyer : replyer
		};

		if (reply == '') {
			alert("댓글내용 입력");
		} else if (replyer == '') {
			alert("작성자 입력");
		} else {

			// ajax 통신
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/replies/new", // 컨트롤러에서 대기중인 URL 주소이다.
				contentType : 'application/json',
				data : JSON.stringify(data), // Json 형식의 데이터이다.
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					//console.log("댓글 등록 성공");
					if (res == 'success') {
						$("#reply").val("");
						getList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					console.log("통신 실패.");
				}
			});

			

		}
		console.log("전송버튼 눌림" + reply + replyer);

	});
	
	
});

</script>
<%@ include file="../includes/footer.jsp" %>