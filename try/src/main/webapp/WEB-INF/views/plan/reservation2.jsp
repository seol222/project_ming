<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

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
  


<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var calendar = null;
var all_events = null;
var calendarEl = null;
var savedatafn = savedata();
//all_events = loadingEvents();

  document.addEventListener('DOMContentLoaded', function() {
	  
	 
					
					
					
					calendar = new FullCalendar.Calendar(calendarEl, {
					      headerToolbar: {
					        left: 'prev,next today',
					        center: 'title',
					        right: 'dayGridMonth,timeGridWeek,timeGridDay'
					      },
					      locale:"ko",
					      //initialDate: '2020-09-12',
					      navLinks: true, // 달력 내부의 날짜(숫자)를 클릭할 수 있도록 설정 false 면 클릭 못함
					      navLinkDayClick: function(date,jsEvent){

					          //console.log('day',date.toISOString());

					          //console.log('coords',jsEvent.pageX,jsEvent.pageY);

					      }, //날짜 클릭하면 발생하는 이벤트(등록된 일정을 모두 표시하게 하고싶다..)
					      selectable: true, //달력 날짜 드래그해서 이벤트 등록
					      selectMirror: true,
					      select: savedatafn ,
					      eventClick: function(arg) {
					        if (confirm('삭제하시겠습니까?')) {
					          arg.event.remove()
					        }
					      },
					      editable: true, //등록된 이벤트를 드래그 해서 이동할 수 있게해주는 기능
					      dayMaxEvents: true, // allow "more" link when too many events
					      //events : all_events,
					      events: events,

					      
					    });

					    calendar.render();
					  },
					
				
				
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						console.log("통신 실패.");
						}
					});
	  

});
    
  function savedata(arg) {
      var title = prompt('예약내용');
      if (title) {
        calendar.addEvent({
          title: title,
          //content : arg.content,
          start: arg.start,
          end: arg.end,
          backgroundColor:"lightyellow",
          textColor:"black",
          allDay: arg.allDay
        })
       
        allEvent = calendar.getEvents();
  	  //console.log(allEvent);

  	  let savetitle  = allEvent[0]._def.title;
  	  let saveallDay =  allEvent[0]._def.allDay;
  	  let savestart = allEvent[0]._instance.range.start;
  	  let saveend = allEvent[0]._instance.range.end;
  	  let savbackgroundColor = allEvent[0].backgroundColor;
  	  let savtextColor = allEvent[0].textColor;
  	  let savedata = {
  			  title : savetitle,
  			  allDay : saveallDay,
  			  start1 : savestart,
  			  end1 : saveend,
  			  backgroundColor : savbackgroundColor,
  			  textColor : savtextColor
  			};
  	 
  	// ajax 통신
			$.ajax({
				type : "POST", 
				url : "/plan/savedata", 
				contentType : 'application/json',
				data : JSON.stringify(savedata), // Json 형식의 데이터이다.
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					//console.log("저장성공");
					
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					console.log("통신 실패.");
				}
			});
        
      
      calendar.unselect()
      }
    }  

function loaddingEvents(){

	// ajax 통신
  $.ajax({
		type : "GET", // HTTP method type(GET, POST) 형식이다.
		url :"/plan/getdata",
		contentType : 'application/json',
		//data : JSON.stringify(data),           // Json 형식의 데이터이다.
		success : function(res) {
			var list = res;
			//console.log(list);
			
			calendarEl = document.getElementById('calendar');
			var events = list.map(function(item){
				//console.log(item.title);
				return{
					title : item.title,
					start : item.start1,
					end : item.end1
					
				};
			});
}
	


</script>


	<div id="calendar" >
	</div>
	<!-- <div>
	<button onclick="allSave();">저장</button>
	</div> -->
  
 <%@ include file="../includes/footer.jsp" %>