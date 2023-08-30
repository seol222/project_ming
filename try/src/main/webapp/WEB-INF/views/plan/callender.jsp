<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

    <script>
		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				  //locale: "ko",
				  initialView: 'dayGridMonth',
				  headerToolbar: {
					left: 'prev,next today',
					center: 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
				  },
				  googleCalendarApiKey: 'AIzaSyBD8qLDH2CqCbEWOkzmk6aR0GAELXYoQVo',
				  events: {
				  googleCalendarId: 'd7847ce73e2571fccd36674808d26eab24169a7253b6e582e465dfe447273628@group.calendar.google.com',
				  className: 'gcal-event' // an option!
				  },
				  eventClick: function(info) {
					  let start_year = info.event.start.getUTCFullYear();
					  let start_month = info.event.start.getMonth() + 1;
					  let start_date = info.event.start.getUTCDate();
					  let start_hour = info.event.start.getHours();
					  let start_minute = info.event.start.getMinutes();
					  let start_second = info.event.start.getSeconds();
					  let end_hour = info.event.end.getHours();

					  let start = start_year + "-" + start_month + "-" + start_date + " " + start_hour + "시 ~ " + end_hour + "시";

					  let attends = "";
					  info.event.extendedProps.attachments.forEach(function(item) {
						  attends += "<div><a href='"+item.fileUrl+"' target='_blank'>[첨부파일]</a></div>"
					  });

					  if(!info.event.extendedProps.description) {
						  info.event.extendedProps.description = "";
					  }
					  let contents = `
						<div style='font-weight:bold; font-size:20px; margin-bottom:30px; text-align:center'>
							${start}
						</div>
						<div style='font-size:18px; margin-bottom:20px'>
							제목: ${info.event.title}
						</div>
						<div style='width:500px'>
							${info.event.extendedProps.description}
							${attends}
						</div>
					  `;
					  
					  $("#popup").html(contents);
					  $("#popup").bPopup({
						speed: 650,
						transition: 'slideIn',
						transitionClose: 'slideBack',
						position: [($(document).width()-500)/2, 30] //x, y
					  });
					  info.jsEvent.stopPropagation();
					  info.jsEvent.preventDefault();
				  }
			});
			calendar.render();
		});
    </script>

 
<div class="custom-hero">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <h1 class="hero-heading">Callender</h1>
          <div  class="line js-line mx-auto mb-3 my-3"></div>
          <p class="sub-text">달력</p>
        </div>
      </div>
    </div>
  </div>
  
   <div id='calendar'></div>
	<div id='popup' style="width:500px; height:600px; display:none; background-color:white; padding:20px; border-radius:14px; border:2px solid #eeeeee"></div>
  </body>
  
     
  
 <%@ include file="../includes/footer.jsp" %>