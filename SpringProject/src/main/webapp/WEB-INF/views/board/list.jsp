<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/boardList.css">

<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function () {
		$(".write_btn").on("click", function() {
			self.location = "/board/register";
		}) ;
		let result = '<c:out value="${result}"/>';
		/*
		if (result != "") {
			result += "번 글이 등록되었습니다";
			alert(result);
		}*/
		checkModal(result);
		history.replaceState({}, null, null);
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			if (parseInt(result) > 0) {
				result = parseInt(result) + "번이 등록되었습니다";
			} else {
				result = "처리가 완료 되었습니다.";
			}
			alert(result);
		}
		
		// 검색어 추가
		// form 태그가 없는 상태에서 동적으로 form 을 생성한다 
		$(".get").on("click", function (e) {
			e.preventDefault();
			let form = $("<form></form>");
			let type = $("select[name=type]").val();
			let keyword = $("input[name=keyword]").val();
			form.attr("method", "get");
			form.attr("action", "/board/get");
			
			form.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
			form.append("<input type='hidden' name='pageNum' value='" + <c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
			form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/>+"'>");
			form.append("<input type='hidden' name='type' value='" + type +"'>");
			form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
			
			form.appendTo('body');
			form.submit();
		});
		
		$(".paginate_button a").on("click",
			function(e) {
				e.preventDefault();
				let form = $('<form></form>');
				form.attr("method", "get");
				form.attr("action", "/board/list");
				form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
				form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/> + "'>");
				form.appendTo('body');
				form.submit();
		});
		
		// 댓글 개수 넣기
		let list = new Array();
		<c:forEach items="${list}" var="board">
			list.push(<c:out value="${board.bno}"/>);
		</c:forEach>
		console.log(list);
		if(list.length == 0) {
			return;
		}
		$.getJSON("/replies/cnt", {list : list}, function(data) {
			//console.log(data);
			// getJSON() 에서 data의 키만 불러오는 함수
			let keys = Object.keys(data);
			$(keys).each(function (i, bno) {
				console.log(i + " : " + bno);
				let replyCnt = data[bno];
				// a 태그의 name 오브젝트를 만들고 data[bno]에 상응하는 데이터인 replyCnt를 저장
				let text = $("a[name="+bno+"]").text().trim() + "  [" + replyCnt + "]";
				$("a[name="+bno+"]").text(text);
			});
		});
		// 게시판에 첨부파일 이미지 넣기
		let listAttach = new Array();
		<c:forEach items="${list}" var="board">
			listAttach.push(<c:out value="${board.bno}"/>);
		</c:forEach>
		if(list.length === 0) {
			return;
		}
		// {list : list}에서 list를 다른 변수명 (listAttach)로 바꿔면 오류뜬다
		$.getJSON("/board/getAttachListOnList", {list : list}, function (data) {
			console.log(data);
			let html = "";
			// 키 정렬
			let keys = Object.keys(data).sort((a, b) => Number(b) - Number(a));
			$(keys).each(function(i, bno) {
				let attach = data[bno];
				//console.log(bno);
				if (attach.length == 0) {
					return;
				}
				if (attach[0] != null) {
					if (attach[0].filetype) {
						let fileCallPath = encodeURIComponent(attach[0].uploadpath + "\\s_" + attach[0].uuid + "_" + attach[0].filename);
						html = "<img src='/display?filename="+fileCallPath+"' style='width:80px; height: 70px;'>";
					} else {
						html = "<img src='/resources/img/attach.png' style='width:80px; height:70px;'>";
					}
					$("#"+bno).html(html);
				}
			});
		});
		
		let searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종료를 선택하세요");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
	});
</script>

</head>
<body>
	<div class="wrapped_container">
		<div class="wrapped_table">
			<table class="board_table">
				<thead>
					<tr class="table__title">
						<th class="table_bno">번호</th>
						<th class="table_title">제목</th>
						<th class="table_writer">작성자</th>
						<th class="table_attach">첨부파일</th>
						<th class="table_date">작성일</th>
					</tr>
				</thead>
	
				<tbody class="board_content">
					<c:forEach var="board" items="${list }" >
						<tr class="tr_list">
							<td class="table_bno"><c:out value="${ board.bno}"></c:out></td>
							<td class="table_title">
								<a class="get" href='<c:out value="${board.bno }"/>' name='<c:out value="${board.bno }"/>'>
									<c:out value="${ board.title}"></c:out>
								</a>
							</td>
							<td class="table_writer"><c:out value="${ board.writer}"></c:out></td>
							<td id='<c:out value="${board.bno}"/>'></td>
							<td class="table_date">
								<c:choose>
									<c:when test="${board.regDate } == ${board.updateDate}">
										<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.regDate }"/>
									</c:when>
									<c:otherwise>
										<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.updateDate }"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- page -->
			<div class="board_page">
				<ul class="pagination">
					<c:if test="${pageDTO.prev} }">
						<li class="paginate_button previous">
							<a href="${pageDTO.startPage - 1}">Prev</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
						<li class="paginate_button ${pageDTO.criteria.pageNum==num ? 'active_list' :'' }">
							<a href="${num }">${num }</a>
						</li>
					</c:forEach>
					<c:if test="${pageDTO.next }">
						<li class="paginate_button next">
							<a href="${pageDTO.endPage+1 }">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
			
			<!-- 게시판 검색어 -->
			<div class="searchform">
				<form action="/board/list" id="searchForm">
					<select name="type" class="select-style">
						<option value="" <c:out value="${pageDTO.criteria.type == null ? 'selected' : ''}"/>>--</option>
						<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : ''}"/>>제목</option>
						<option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : ''}"/>>내용</option>
						<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
						<option value="TC" <c:out value="${pageDTO.criteria.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
						<option value="TW" <c:out value="${pageDTO.criteria.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
						<option value="TWC" <c:out value="${pageDTO.criteria.type eq 'TWC' ? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
					</select>
					<input type="text" class="select-style" name="keyword" value="<c:out value="${pageDTO.criteria.keyword }"/>"/>
					<input type="hidden" name="pageNum" value="<c:out value="${pageDTO.criteria.pageNum }"/>"/>
					<input type="hidden" name="amount" value="<c:out value="${pageDTO.criteria.amount }"/>"/>
					<button class="button">검색</button>
				</form>
			</div>
			
			<div class="board_button">
				<button class="write_btn" id="write_btn">글쓰기</button>
			</div>
		</div>
	</div>
	
<%@include file="../includes/footer.jsp" %>
</body>
</html>