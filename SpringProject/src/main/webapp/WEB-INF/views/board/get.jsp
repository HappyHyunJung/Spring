<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/getMain.css">

<%@include file="../includes/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
});
</script>

<div class="wrapper_read">
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
	<div class="read_button">
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
	
<%@include file="../includes/footer.jsp" %>	
