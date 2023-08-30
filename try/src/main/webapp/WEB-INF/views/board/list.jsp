<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@ include file="../includes/header.jsp" %>



  <div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Board</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">게시판</p>
        </div>
      </div>
    </div>
  </div>
  
  <div class="container pb-5 mb-5 border-bottom">
  
  <div style="text-align:right; float: right; " class="form-group"><a href="/board/register" class="btn btn-primary" role="btn">New</a></div>
  
  
 		 <table class="table">
						<colgroup>
							<col style="width:80px"/>
							<col style=""/>
							<col style="width:100px"/>
							<col style="width:150px"/>
							<col style="width:150px"/>
							<col style="width:80px"/>
						</colgroup>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
							<th>조회수</th>
						
						</tr>
						
						
						<c:forEach items="${list }" var="board">
						<tr>
							<td><c:out value="${board.bno }"/></td>
							<td><a href="/board/get?bno=${board.bno}"><c:out value="${board.title }"/></a></td>
							<td><c:out value="${board.writer }"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate }"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.updateDate }"/></td>
							<td><c:out value="${board.hit }"/></td>
						</tr>
						</c:forEach>
						
						
						
					
						
				</table>

  </div>
  			<!-- 검색 시작 -->
  			<div class="container pb-5 mb-5 border-bottom">
				
				<div class="col-md-8 pagination">
					<form action="" class="form-inline">
						<select name="type" class="form-control" style="min-width:6px;">
							<option value="">선택</option>
							<option value="T">제목</option>
							<option value="C">내용</option>
							<option value="W">작성자</option>
							<option value="TC">제목+내용</option>
						</select>
						<input type="text" name="keyword" class="form-control">
					
						
						<button class="btn btn-primary">검색</button>
					</form>
				</div>
				</div>
				<!-- 검색 끝 -->
				
				
			 <div class="row">
		        <div class="col-lg-12 text-center">
		          <ul class="list-unstyled custom-pagination">
		          
		          
		            <c:if test="${pageMaker.prev}">
				    <li >
				      <a href="${pageMaker.startPage - 1}" aria-label="Previous" class="btn_pagination">
				        <span class="icon-arrow_back"></span>
				      </a>
				    </li>
				    </c:if>
				    
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num" >
					    
					    <c:if test="${num eq pageMaker.cri.pageNum }">
						    <li class="active">
						    	<a>${num }</a>
						    </li>
					    </c:if>
					    
					    <c:if test="${num ne pageMaker.cri.pageNum }">
					    	<li class="">
					    		<a href="${num }" class="btn_pagination">${num }</a>
					    	</li>
					    </c:if>
				    
				    </c:forEach>
				    <c:if test="${pageMaker.next }">
				    <li >
				      <a href="${pageMaker.endPage + 1}" aria-label="Next" class="btn_pagination">
				        <span class="icon-arrow_forward"></span>
				      </a>
				    </li>
				    </c:if>
				    
		          </ul>
		        </div>
		      </div> 
<form id="frm">
	<input type="hidden" name="pageNum" value="">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	
	
</form>

<script>
$(document).ready(function(){
	$(".btn_pagination").on("click",function(e){
		e.preventDefault();
		//console.log("BTN"+$(this).attr("href"));
		let href = $(this).attr("href");
		$("input[name=pageNum]").val(href);
		console.log(location.href == '');
		$("#frm").submit();
	});
});
</script>



<%@ include file="../includes/footer.jsp" %>