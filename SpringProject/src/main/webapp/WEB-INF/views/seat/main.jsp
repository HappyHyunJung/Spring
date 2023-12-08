<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang='ko'>
  <head>
    <meta charset='utf-8' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<link rel="stylesheet" href="/resources/css/image-picker.css">
	<script src="/resources/js/image-picker.js"></script>
	<script src="/resources/js/image-picker.min.js"></script>
	<script>

      $(function() {
    	  let startStr;
    	  initFullCalendar();
    	  function initFullCalendar() {
    		  let calendarEl = document.getElementById('calendar');
    		  let calendar = new FullCalendar.Calendar(calendarEl, {
    			  initialView: 'dayGridMonth',
    			  selectable: true,
    			  unselectAuto: false,
    			  select: function(info) {
    				  console.log(info.startStr);
    				  startStr = info.startStr;
    				  $('#seatPicker').prop('selectedIndex', 0).trigger('change');
    			  }
    		  });
    		  calendar.setOption('contentHeight', 450);
    		  calendar.render();
    		  startStr = calendar.getDate().toISOString();
    	  }
    	  //좌석번호 이미지로 화면에 보여주는 기능
    	  initSeatNo();
    	  function initSeatNo() {
    		  $.getJSON("/seat/getSeatNo/", function(data) {
    			  console.log(data);
    			  $(data).each(function(i, item) {
    				  let option = $("<option data-img-src='/resources/img/number_0" + (i+1) + ".png' value='"+(i+1)+"'></option>");
    				  $('#seatPicker').append(option);
    			  });
    			  $("select").imagepicker();
    			  $('#seatPicker').prop('selectedIndex', 0).trigger('change');
    		  });
    	  }
    	  //startStr 의 날짜 정보를 받아와서 시,분,초를 '0'으로 만들고 반환하면 날짜정보가 반환된다 -> resdate(좌석예약일)
    	  function getTime() {
    		  alert(startStr);
    		  const d = new Date(startStr);
    		  d.setHours(0);
    		  d.setMinutes(0);
    		  d.setSeconds(0);
    		  return d.getTime();
    	  }
    	  // 좌석 정보 보여주는 기능
    	  $("#seatPicker").on('change', function() {
    		  $.getJSON("/seat/getResState/",
    				  {sno:$("#seatPicker").find(':selected').val(), resdate: getTime()}, function(data) {
    				$("#seats").empty();
    				console.log(data);
    				console.log("${auth.userid}");
    				$(data).each(function(i, item) {
    					let input;
    					if (item.userid === null) {
    						input = $("<label class='box'><input type='checkbox' id="+(i+1)+">" + "[" + item.tno + 
    							"  " + item.duration + "]" + "[예약가능] </input><span class='checkmark'></span><label><br/>");
    					} else {
    						if ("${auth.userid}" === item.userid) {
    							input = $("<label calss='box'><input type='checkbox' disabled='disabled' id=" + (i+1)+ ">" + "[" + item.tno + 
    								"  " + item.duration + "]" + "[예약중] </input><span class='checkmar'></span><label><br/>");
    						} else {
    							input = $("<label class='box'><input type='checkbox' disabled='disabled' id=" + (i+1) + ">" + "[" + item.tno +
    								"  " + item.duration + "]" + "[예약불가] </input><span class='checkmark'></span><label><br/>");
    						}
    					}
    					$("#seats").append(input);
    				});
			   });
    	  });
    	  // 예약하기 버튼 눌렀을 때 동작
    	  $("#reservation").on("click", function() {
    		  //console.log("reservation click")
    		  let list = new Array();
    		  $("#seats input").each(function(i, item) {
    			  let inputObj = $(item);
    			  if(inputObj.is(':checked')) {
	    			  //alert(startStr + " " + $("#seatPicker option:checked").val() + " " + inputObj.attr('id'));
	    			  let obj = {userid: "${auth.userid}", sno: $("#seatPicker option:checked").val(),
	    					  tno: inputObj.attr('id'), resdate:getTime()};
	    			  list.push(obj);
    			  }
    		  });
    		  $.ajax({
    			  type: 'post',
    			  url: '/seat/reservation',
    			  data: JSON.stringify(list),
    			  dataType:'json',
    			  contentType: 'application/json',
    			  success : function(result) {
    				  alert(result + "번 좌석 예약이 완료되었습니다");
    				  $('#seatPicker').prop('selectedIndex', result-1).trigger('change');
    			  }
    		  });
    	  });
      });

    </script>  
  </head>
  <body>
    <div class="wrapper_main" style="display: flex; margin-top:5px;">
    	<div id='calendar' style="width:50%;"></div>
    	<div style="width:50%; margin-left:20px;">
    		<div style="height:25%;">
    			<select id="seatPicker" class="image-picker show-html"></select>
    		</div>
    		<div id="seats" style="height:65%;">
    		</div>
    		<div style="height:10%;">
    			<button id="reservation" type="button">예약하기</button>
    		</div>
    	</div>
    </div>
  </body>
</html>