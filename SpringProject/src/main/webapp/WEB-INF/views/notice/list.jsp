<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="/resources/js/noticeService.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	$(function() {
		getNoticeList();
		function getNoticeList() {
			NoticeService.getList(
				function(list) {
					console.log("list : " + list);
					showNoticeList(list);
				},
				function(error) {
					alert(error);
			});
		}
		
		let noticeUL = $(".notice");
		function showNoticeList(list) {
			let str = "";
			if(list == null || list.length == 0) {
				noticeUL.html(str);
				return;
			}
			
			for(let i = 0, len = list.length || 0; i < len; i++) {
				str += "<li>";
				str += "  <div>";
				str += "    <div class='header' ><strong>" + list[i].title+"</strong>";
				str += "      <small>"+NoticeService.displayTime(list[i].regdate)+"</small>";
				str += "      <span class='view'>▼</span>"
				str += "    </div>";
				str += "    <div id='notice_content' data-show='hide'></div>"
				str += "    <div data-rno='" + list[i].rno +"' data-title='" + list[i].title + "' ";
				str += "      data-notice='"+list[i].notice+"'>"; 
				str += "  </div>";
				str += "</li>";
			}
			noticeUL.html(str);
		}
		
		
		noticeUL.on("click", "li .view", function(e) {
			let notice = $(this).parent().closest('div').next().next().data("notice");
			let rno = $(this).parent().closest('div').next().next().data("rno");
			let content = $(this).parent().closest('div').next();
			//console.log("view click");
			console.log(rno);  // view 버튼을 누르면 숫자가 보인다
			console.log(notice);
	
			
			if (content.data("show") === 'hide') {
				NoticeService.get(rno, function(notice) {
					content.append(notice.notice);
				});
				content.show();
				content.data('show', 'show');
				console.log(content.data('show'));
			
			} else if (content.data("show") === 'show') {
				content.empty();
				content.data('show', 'hide');
				console.log(content.data('show'));
			}
			content.css('background-color', 'purple');
			content.css('color', 'white');
		});
	});

</script>

<%@include file="../includes/header.jsp"%>
<body>
	<div class="notice_wrap"> 
		<h1>공지사항</h1>
		<ul class="notice"></ul>
		<div class="notice-panel-footer"></div>
	</div>
</body>
<%@include file="../includes/footer.jsp" %>	