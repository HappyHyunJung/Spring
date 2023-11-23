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
		
		
		/* form 태그가 없는 상태에서 동적으로 form 을 생성한다 */
		$(".get").on("click", function (e) {
			e.preventDefault();
			let form = $("<form></form>");
			form.attr("method", "get");
			form.attr("action", "/board/get");
			
			form.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
			form.append("<input type='hidden' name='pageNum' value='" + <c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
			form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/>+"'>");
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
						<th class="table_date">작성일</th>
					</tr>
				</thead>
	
				<tbody class="board_content">
					<c:forEach var="board" items="${list }" >
						<tr class="tr_list">
							<td class="table_bno"><c:out value="${ board.bno}"></c:out></td>
							<td class="table_title">
								<a class="get" href='<c:out value="${board.bno }"/>'>
									<c:out value="${ board.title}"></c:out>
								</a>
							</td>
							<td class="table_writer"><c:out value="${ board.writer}"></c:out></td>
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
			
			<div class="board_button">
				<button class="write_btn" id="write_btn">글쓰기</button>
			</div>
		</div>
	</div>
	
<%@include file="../includes/footer.jsp" %>
</body>
</html>