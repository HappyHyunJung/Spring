<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<script type="text/javascript" src="/resources/js/replyService.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- 부트스트랩 추가해서 css 헤더가 깨졌다 // 부트스트랩이 body 부분에 들어가고 css 파일은 head에 들어감 -->  
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">


<script type="text/javascript">
$(function () {
	const operForm = $("#operForm");
	$("#list_btn").on("click", function (e) {
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	});
	
	$("#modify_btn").on("click", function (e) {
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("#addReplyBtn").on("click", function() {
		$("#reply").val("");
		$("#modalModBtn").hide();
		$("#modalRegisterBtn").show();
		$("#modalCloseBtn").show();
		$(".modal").modal("show");
	});
	
	$("#modalCloseBtn").on("click", function() {
		$(".modal").modal("hide");
	});
	
	$("#modalRegisterBtn").on("click", function() {
		console.log("dialog RegisterBtn");
		let reply = {
				reply: $("#reply").val(), 
				replyer : $("#replyer").val(), 
				bno : '<c:out value="${board.bno}"/>'
		};
	
		ReplyService.add(reply,
			function(result) {
				alert(result);
				$(".modal").modal("hide");
				//getReplyList();
				getReplyListWithPaging(pageNum);
			},
			function(error) {
				alert(error);
			//});  // ??? 이 한 줄때문에 댓글 수정이 동작하지 않았다
			// 자세히 보면 아래2번째 줄에 }); 중괄호가 function(error)의 닫는 괄호
			// )가 ReplyService.add의 닫는 괄호이다
		console.log("replyservice end");
		});
	});
	/* reply list */
	// get.jsp 들어가자마자 댓글 목록이 나오게 한다
	//getReplyList();  // getReplyListWithPagin() 만들었는데 계속 list로 댓글 목록이 나옴
	function getReplyList() {
		ReplyService.getList(
			{bno: '<c:out value="${board.bno}"/>'},
			function (list) {
				console.log("list : " + list);
				showReplyList(list);
			},
			function (error) {
				alert(error);
			//}
		});
	}
	
	let pageNum = 1;
	let replyPageFooter = $(".panel-footer");
	
	getReplyListWithPaging(pageNum);
	function getReplyListWithPaging(pageNum) {
		ReplyService.getListWithPaging(
			{bno: '<c:out value="${board.bno}"/>', page: pageNum},
			function(replyCnt, list) {
				console.log("list: " + list);
				showReplyList(list);
				showReplyPaging(replyCnt);  // 페이지 하단에 번호 보여주기  HTML에서 panel-footer에서 나옴
			},
			function (error) {
				alert(error);
			}
		);
		
	}
	
	function showReplyPaging(replyCnt) {
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		let prev = startNum != 1;
		let next = false;
		let str = "";
		if (endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt / 10.0);
		}
		if (endNum * 10 < replyCnt) {
			next = true;
		}
		
		str += "<ul class='pagination'>";
		if (prev) {
			str+="<li class='paginate_button'><a href='"+(startNum -1)+"'>Previous</a></li>";
		}
		for (let i = startNum; i <= endNum; i++) {
			let active = pageNum == i? "active_list" : "";
			str += "<li class='paginate_button " + active + " '><a href='" + i + "'>" + i + "</a></li>";
		}
		if (next) {
			str += "<li class='paginate_button'><a href='"+(endNum + 1)+"'>Next</a></li>";
		}
		str += "</ul></div>";
		console.log(str);
		replyPageFooter.html(str);
	}
	
	function showReplyList(list) {
		let str = "";
		let replyUL = $(".reply");
		if(list === null || list.length == 0) {
			replyUL.html(str);
			return;
		}
		
		for(let i = 0, len = list.length || 0; i < len; i++ ) {
			str += "<li>";
			str += "  <div>";
			str += "    <div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
			str += "      <small class='pull-right text-muted'>"+ReplyService.displayTime(list[i].regdate)+"</small>";
			str += "    </div>";
			str += "    <div data-rno='"+ list[i].rno + "' data-replyer='" + list[i].replyer + "'>";
			str += "      <strong id='modify' class='primary-font'>"+list[i].reply+"</strong>";
			if("${auth.userid}" === list[i].replyer) {
				str += "      <button id='remove' type='button' class='close' data-rno='" + list[i].rno + "'>";
				str += "        <span>x</span></button>";
			}
			str += "    </div>";
			str += "  </div>";
			str += "</li>";
		}
		//console.log(str);
		//console.log(replyUL);
		replyUL.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e) {
		e.preventDefault();
		console.log("page click");
		let targetPageNum = $(this).attr("href");
		console.log("targetPageNum : " + targetPageNum);
		pageNum = targetPageNum;
		getReplyListWithPaging(pageNum);
	});
	
	/* (.reply)가 ul 태그  동적 생성 */
	/* modify the reply */
	$(".reply").on("click", "li #modify", function(e) {
		console.log("reply modify click");
		/* id=modify 인 태그에서 가장 가까운 div태그 data가 replyer인 데이터를 대입 */
		
		let replyer = $(this).parent().closest('div').data("replyer");   
		let rno = $(this).parent().closest('div').data("rno");
		let auth = "${auth.userid}";
		if (auth !== replyer) {
			return;
		}
		//alert('modify ' + auth + ' ' + replyer + ' ' + rno);
		
		// 댓글 누르면 뜨는 창
		ReplyService.get(rno, function(reply) {
			$("#reply").val(reply.reply);
			$("#replyer").val(reply.replyer);
			$(".modal").data("rno", reply.rno);
			$("#modalModBtn").show();
			$("#modalRegisterBtn").hide();
			$(".modal").modal("show");
		});
	}); 
	// 댓글 수정
	$("#modalModBtn").on("click", function(e) {
		let reply = {reply: $("#reply").val(),
				rno: $(".modal").data("rno")
		};
		ReplyService.update(reply,
			function(result) {
				alert(result);
				$(".modal").modal("hide");
				//getReplyList();
				getReplyListWithPaging(pageNum);
			},
			function (error) {
				alert(error);
		});
	});
	
	$("#listpp").on("click", function(e) {
		console.log("hhh");
	});
	// 댓글 삭제
	$(".reply").on("click", "li #remove", function(e) {
		let rno = $(this).parent().closest('div').data("rno");
		alert('remove ' + rno);
		ReplyService.remove(rno,
			function(result) {
				alert(result);
				getReplyListWithPaging(pageNum);
			},
			function(error) {
				alert(error);
		});
	});
	
	//첨부파일 출력
	//bno번호
	let bno = '<c:out value="${board.bno}"/>';
	$.getJSON("/board/getAttachList/" + bno, function(attachList) {
		console.log("attachList:" + attachList);
		let str = "";
		//callback -> array반복시 요청됨
		$(attachList).each(function(i, attach) {
			console.log(i, attach.uuid, attach.filename, attach.filetype);
			//이미지일 경우, 썸네일 화면에 노출
			if(attach.filetype == 1) {
				//썸네일 이미지 경로
				let fileCallPath = encodeURIComponent(attach.uploadpath + "\\s_" + attach.uuid + "_" + attach.filename);
				console.log("fileCallPath : " + fileCallPath);
				str +="<li data-path='" + attach.uploadpath + "'";
				str +=" data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'>";
				str += " <div>";
				str += "  <span>" + attach.filename + "</span><br>";
				str += "   <img src='/display?filename=" + fileCallPath + "'/>";
				str += " </div>";
				str += "</li>";
			} else {
				//이미지가 아닌 경우
				str +="<li data-path='" + attach.uploadpath + "'";
				str +=" data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'>";
				str += " <div>";
				str += "  <span>" + attach.filename + "</span><br>";
				str += "  <img src='/resources/img/attach.png'/>";
				str += " </div>";
				str += "</li>";
				
			}
		});
		$(".uploadResult ul").html(str);
	});
    
	function showImage(fileCallPath) {
		console.log(fileCallPath);
		// 첨부파일 이미지 보여주는 부분 - 애니메이션으로 이미지가 보여진다
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture").html("<img src='/display?filename=" + fileCallPath + "'/>").animate({width:'100%', top:'0'}, 600);
	}
	$(".uploadResult").on("click", "li", function(e) {
		console.log("view image");
		let liObj = $(this);
		let path = encodeURIComponent(liObj.data("path") + "\\" + liObj.data("uuid") + "_" + liObj.data("filename"));
		console.log("path : " + path);
		if (liObj.data("type")) {
			showImage(path);  // 이미지가 보여지는 함수
		} else {
			if (path.toLowerCase().endsWith('pdf')) {
				//new window
				window.open("/pdfviewer?filename=" + path);
			} else {
				//download
				self.location = "/downloadFile?filename=" + path;
			}
		}
	});
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPictureWrapper").hide();
		$(".bigPicture").css("top", "15%");
	});
	
});  /* #modalRegisterBtn 클릭 함수 에서 ReplyService.add() 를 호출하면 오류때문에 지워야 된다 */
/* ReplyService.add()  주석처리하면 마지막 닫는 괄호거 없으면 오류가 된다 */
/* ReplyService.add()에서 괄호를 잘못 닫아서 오류가 났다 */
</script>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/getMain.css">
<link rel="stylesheet" href="/resources/css/headfoot.css">

<div class="wrapper_read" style="display: flex;">
	<div class="read_board_con">
		<div class="read_head">
		<h3>게시글 읽기</h3>
		</div>
		<div class="read_line"></div>
		<table class="read_table">
			<thead>
				<tr class="read_table_title">
					<th>제목</th>
					<td>${board.title }</td>
				</tr>
				<tr class="read_table_title">
					<th>작성자</th>
					<td>${board.writer }</td>
				</tr>
				<tr class="read_table_title">
					<th>작성일</th>
					<td>
						<c:choose>
							<c:when test="${board.regDate } == ${board.updateDate }">
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.regDate }"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.updateDate }"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</thead>
		</table>
		<div class="read_table_content">
			<textarea class="read_content" name="content" readonly="readonly">${board.content }</textarea>
		</div>
		<!-- 첨부파일 -->
		<div class="article-bottom">
			<div class="field3 get-th field-style">
				<p><b>첨부파일</b></p>
			</div>
			<div class="field3 get-td">
				<div class="uploadResult">
					<ul></ul>
				</div>
			</div>
		</div>
		
		<div class="read_button" style="display: inline;">
			<button class="read_button" id="list_btn">목록</button>
			<c:if test="${auth.userid eq board.writer }">
				<button class="read_button" id='modify_btn'>수정</button>
			</c:if>
			<form id='operForm' action="/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }" />'>
				<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${criteria.pageNum }" />'>
				<input type='hidden' id='amount' name='amount' value='<c:out value="${criteria.amount }" />'>
			</form>
		</div>
	</div>
	
	<div class="read_reply_con">
		<!-- 댓글 -->
		
		<div class="reply_tab">
			<h4 id="listpp">댓글 목록</h4>
			<div class="read_reply">
				<c:if test="${not empty auth }" >
					<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
				</c:if>
			</div>
		</div>
		
		<div class="reply_list">
			<ul class="reply"></ul>
			<div class="panel-footer"></div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">REPLY MODAL</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
	   					<div class="form-group">
	   						<label>Reply</label>
	   						<input class="form-control" id='reply' name='reply'>
						</div>
						<div class="form-group">
							<label>Replyer</label> 
							<input class="form-control" id='replyer' name='replyer' value="${auth.userid}" readonly="readonly">
						</div>
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				        <button id='modalCloseBtn' type="button" class="btn btn-info">Close</button>
			        </div>
		        </div>
		        <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
	    </div>
	    <!-- /.modal -->
	    
	    <div class="bigPictureWrapper">
	    	<div class="bigPicture"></div>
	    </div>
	</div>
	
</div>
<%@include file="../includes/footer.jsp" %>	
