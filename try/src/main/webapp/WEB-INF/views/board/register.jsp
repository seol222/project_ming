<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Register</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">새글 작성하기</p>
        </div>
      </div>
    </div>
  </div>

  <div class="section-grey">
    <div class="container p-5">

      <div class="block">
        <div class="row justify-content-center">


          <div class="col-md-12 col-lg-12 pb-4" data-aos="fade-up" data-aos-delay="200">



            <form  id = "frm" role="form" action="/board/register" method="post">
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
           
              <div class="form-group">
                <label class="text-black">Title</label>
                <input class="form-control" id="title" name="title">
              </div>

              <div class="form-group">
                <label class="text-black">Content</label>
                <textarea  class="form-control" id="content" name="content" cols="30" rows="5"></textarea>
              </div>
                 <div class="row">
                <div class="col-6">
                  <div class="form-group">
                    <label class="text-black" for="fname">Writer</label>
                    <input type="text" class="form-control" id="writer" name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly">
                  </div>
                </div>
                
              </div>

              <button type="submit" class="btn btn-primary">Register</button>
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
            
            <input type="file" name="uploadFile" multiple class="form-control">
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
  		</div>
        </div>
      </div>
    </div>
  </div>

<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var regex = new RegExp("(.*?)\.(jpg|png|gif|bmp|zip|hwp)$");
var maxSize = 1024*1024*5; //5mb

$(document).ready(function(){
	//var formObj = $("form[role='form']");
	
	$("button[type=submit]").on("click",function(e){
		e.preventDefault();
		
		let title = $("#title").val();
		let content = $("#content").val();		
		let writer = $("#writer").val();		
		
		if(title == ''){
			alert("제목을 입력하세요");
			return;
		}else if(content == ''){
			alert("내용을 입력하세요");
			return;
		}else if(writer == ''){
			alert("작성자를 입력하세요");
			return;
		}else{
		let str = "";
		$(".uploadResult ul li").each(function(i,obj){
			str += '<input type = "hidden" name="attachList['+i+'].fileName" value="'+$(obj).data('filename')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].uuid" value="'+$(obj).data('uuid')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].uploadPath" value="'+$(obj).data('path')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].fileType" value="'+$(obj).data('type')+'">';

			console.log(str);
		});
		
		$("#frm").append(str).submit();
		}	
	});
});

function checkExtension(fileName, fileSize){
	//용량체크
	if(fileSize >=maxSize ){
		alert("파일 사이즈 초과");
		return false;
	}
	//확장자 체크
	if(!regex.test(fileName)){
		alert("업로드 불가한 파일형식 입니다.");
		return false;
	}
	return true;
}

$("input[type=file]").on("change",function(){
	var formData = new FormData();
	var inputfile =  $("input[name=uploadFile]");
	var files =  inputfile[0].files;
	console.log(files);
	
	for(var i = 0; i<files.length; i++){
		
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		
		formData.append("uploadFile",files[i]);
		
	}
	
	$.ajax({
		url:"/uploadAjaxAction",
		processData:false,
		contentType:false,
		data:formData,
		type:"POST",
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		}, 
		success:function(result){
			//파일선택 창 초기화
			//$(".uploadDiv").html(cloneObj.html());
			$("#uploadFile").val('');
			console.log(result);
			//업로드 된 사진 출력하기
			showUploadFile(result);
			
			
		}
	});
});

function showUploadFile(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length ==0){
		return;
	}
	
	let str = "";
	
	$(uploadResultArr).each(function(i, obj){
		//str += "<li>" + obj.fileName + "</li>";
		console.log(obj);
		if(obj.image){
			var fileCallPath = encodeURIComponent(obj.uploadpath + "/s_" + obj.uuid + "_" + obj.fileName);
			var fileRealPath = encodeURIComponent(obj.uploadpath + "/" + obj.uuid + "_" + obj.fileName);
			
			str += "<li data-path='"+obj.uploadpath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><a href='../download?fileName="+ fileRealPath + "'><img src = '../display?fileName=" + fileCallPath + "'></a>";
			str += "<span data-realfile='"+fileRealPath+"' data-file='"+fileCallPath+"' data-type='image' >X</span></li>";
		}else{
			var fileRealPath = encodeURIComponent(obj.uploadpath + "/" + obj.uuid + "_" + obj.fileName);
			
			str += "<li data-path='"+obj.uploadpath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><a href='../download?fileName="+ fileRealPath + "'>";
			str += "<img src='/resources/untree/images/att.png' width='100'></a>";
			str += "<span data-realfile='"+fileRealPath+"' data-file='"+fileCallPath+"' data-type='file' >X</span></li>";
		}
	});
	
	$(".uploadResult ul").append(str);
}




$(document).ready(function(){
	
	
	
	$(".uploadResult").on("click","span" , function(){
		let targetRealfile =  $(this).data("realfile");
		let targetfile =  $(this).data("file");
		let type = $(this).data("type");
		let span = $(this);
		
		$.ajax({
			
			url : '../deleteFile',
			data:{
				fileRealName:targetRealfile,
				fileName:targetfile,
				type:type
				},
			dataType:"text",
			type:"POST",
			 beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}, 
			success:function(result){
				//console.log(result);
				if("deleted" == result){
					span.parent().remove();
					//$(".uploadDiv").html(cloneObj.html());
				}
			}			
		});
		
	});
	

	
	
	
});
</script>


<%@ include file="../includes/footer.jsp" %>