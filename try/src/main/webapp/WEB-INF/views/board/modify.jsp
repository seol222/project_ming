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
 			 <input type="hidden" name="bno" value="${board.bno }" />
            
           <div class="form-group">              
                <label class="text-black">bno</label>
                <div >${board.bno }</div>
              </div> 
            


            <form id="frm"  action="" method="post">
            
           	<input type="hidden" name="bno" value="${board.bno }" />
           	<input type="hidden" name="pageNum" value="${cri.pageNum }" />
           	<input type="hidden" name="amount" value="${cri.amount }" />
           	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
           
              <div class="form-group">              
                <label class="text-black" style="font-size:20px; font-weight: bold;">Title</label>
                <input class="form-control" id="title" name="title" value="${board.title }">
                
              </div>

              <div class="form-group">
                <label class="text-black" style="font-size:20px; font-weight: bold;">Content</label>
                <textarea  class="form-control" id="content" name="content" cols="30" rows="5">${board.content }</textarea>
              </div>
              <div class="row">
                <div class="col-6"> 
                  <div class="form-group">
                    <label class="text-black" for="fname" style="font-size:20px; font-weight: bold;">Writer</label>
                    <input type="text" class="form-control" id="writer" name="writer" value="${board.writer }" readonly="readonly">
                  </div>
                </div>
                
              </div>
			<div class="row">
			<sec:authentication property="principal" var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.writer}">
              <button type="submit" class="btn btn-primary">Modify</button>
              
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
 
 var regex = new RegExp("(.*?)\.(jpg|png|gif|bmp|zip|hwp)$");
 var maxSize = 1024*1024*5; //5mb
 
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
 
 function showUploadFile(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length ==0){
			return;
		}
		
		let str = "";
		
		$(uploadResultArr).each(function(i, obj){
			//str += "<li>" + obj.fileName + "</li>";
			
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
	 //var formObj = $("form[role='form']");
 	
 	$("button[type=submit]").on("click",function(e){
		e.preventDefault();
	
		let str = "";
		
		$(".uploadResult ul li").each(function(i,obj){
			console.log(obj);
			str += '<input type = "hidden" name="attachList['+i+'].fileName" value="'+$(obj).data('filename')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].uuid" value="'+$(obj).data('uuid')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].uploadPath" value="'+$(obj).data('path')+'">';
			str += '<input type = "hidden" name="attachList['+i+'].fileType" value="'+$(obj).data('type')+'">';
			
		});
		console.log(str);
		$("#frm").append(str).submit();
		
	});
 });


 
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
			/* beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}, */
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
 

 
 
 $(document).ready(function(){
	 var bno = '${board.bno }';
		
		$.getJSON("./getAttachList",{bno:bno}, function(arr){
			console.log(arr);
			
			let str = "";
			$(arr).each(function(i,attach){
				
				var fileRealPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
				
				
				//파일 타입이 
				if(attach.fileType){
					//그림파일이면
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					str += "<li style='padding:5px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
					str += '<a href="../download?fileName='+fileRealPath+'">';
					str += '<img src="../display?fileName='+fileCallPath+'">';					
					str += '</a>';
					str += "<span data-realfile='"+fileRealPath+"' data-file='"+fileCallPath+"' data-type='image' >X</span></li>";
					str += '</li>';
					
				}else{
					//그림파일이 아니면
					str += "<li style='padding:5px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";					
					str += '<a href="../download?fileName='+fileRealPath+'">';
					str += '<img src="/admin/resources/assets/images/att.png" width="100">';					
					str += '</a>';
					str += "<span data-realfile='"+fileRealPath+"' data-file='"+fileCallPath+"' data-type='image' >X</span></li>";
					str += '</li>';
					
				}
				
			});
			
			$(".uploadResult ul").html(str);
			
			
		});
 });
 var formObj = $("form[role='form']");
 $(".uploadResult").on("click","span" , function(){
		
		$(this).parent().remove();
		
	}); 
 </script> 

<%@ include file="../includes/footer.jsp" %>