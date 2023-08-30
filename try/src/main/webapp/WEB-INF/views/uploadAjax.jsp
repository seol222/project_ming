<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/libs/bower/jquery/dist/jquery.js"></script>
</head>
<body>
<h1>Upload with Ajax</h1>
<div class = "uploadDiv">
	<input type="file" name="uploadFile" multiple="multiple" accept="image/*">
</div>
<button id="uploadBtn">Upload</button>

<div class="uploadResult">
<ul>

</ul>
</div>



<script>

var regex = new RegExp("(.*?)\.(jpg|png|gif|bmp)$");
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
	let str = "";
	
	$(uploadResultArr).each(function(i, obj){
		//str += "<li>" + obj.fileName + "</li>";
		var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
		var fileRealPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
		
		str += "<li><a href='download?fileName="+ fileRealPath + "'><img src = 'display?fileName=" + fileCallPath + "'></a>";
		str += "<span data-realfile='"+fileRealPath+"' data-file='"+fileCallPath+"' data-type='image' >X</span></li>";
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
			
			url : 'deleteFile',
			data:{
				fileRealName:targetRealfile,
				fileName:targetfile,
				type:type
				},
			dataType:"text",
			type:"POST",
			success:function(result){
				//console.log(result);
				if("deleted" == result){
					span.parent().remove();
				}
			}			
		});
		//console.log("span Click");
	});
	
	
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click",function(){
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
			url:"uploadAjaxAction",
			processData:false,
			contentType:false,
			data:formData,
			type:"POST",
			success:function(result){
				//파일선택 창 초기화
				$(".uploadDiv").html(cloneObj.html());
				
				//업로드 된 사진 출력하기
				showUploadFile(result);
				
				
			}
		});
		
		
	});
});
</script>
</body>
</html>