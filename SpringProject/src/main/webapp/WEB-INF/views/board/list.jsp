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
		if (result != "") {
			result += "번 글이 등록되었습니다";
			alert(result);
		}
		
		/* form 태그가 없는 상태에서 동적으로 form 을 생성한다 */
		$(".get").on("click", function (e) {
			e.preventDefault();
			let form = $("<form></form>");
			form.attr("method", "get");
			form.attr("action", "/board/get");
			
			form.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
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
					<c:forEach var="board" items="${ListBoardVO }" >
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
	
			<div class="board_button">
				<button class="write_btn" id="write_btn">글쓰기</button>
			</div>
		</div>
	</div>
	
<%@include file="../includes/footer.jsp" %>
</body>
</html>