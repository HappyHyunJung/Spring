<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/modifyMain.css">

<%@include file="../includes/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function () {
	let formObj = $("form");
	$('button').on("click", function(e) {
		e.preventDefault();
		let operation = $(this).data("oper");
		console.log(operation);
		
		if(operation === 'remove') {
			formObj.attr("action", "/board/remove");
		} else if (operation === 'list') {
			formObj.empty();
			formObj.attr("action", "/board/list").attr("method", "get");
		} else if (operation === 'list') {
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			formObj.empty();
			formObj.attr("action", "/board/list").attr("method", "get");
			formObj.append(pageNumTag);
			formObj.append(amountTag);
		}
		formObj.submit();
	});
});
</script>

<div class="wrapper_read">
	<div class="read_head">
		<h3>게시글 수정화면 입니다</h3>
	</div>
	<div class="read_line"></div>
	<form action="/board/modify" method="post">  <!--  -->
		<input type="hidden" name='pageNum' value='<c:out value="${criteria.pageNum }"/>'>
		<input type="hidden" name='amount' value='<c:out value="${criteria.amount }"/>'>
		<table class="read_table">
			<thead>
				<tr class="read_table_title">
					<th>번호</th>
					<td><input class="form-control" name="bno"
						value='<c:out value="${board.bno }"/>' readonly="readonly"></td>
				</tr>
				
				<tr class="read_table_title">
					<th>제목</th>
					<td><input class="form-control" name="title"
						value='<c:out value="${board.title }"/>'></td>
				</tr>
				<tr class="read_table_title">
					<th>작성자</th>
					<td><input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly="readonly"> </td>
				</tr>
				<tr class="read_table_title">
					<th>작성일</th>
					<td><input class="form-control" name="regdate  <!-- 왜 regDate로 하면 오류가 날까? -> BoardMapper.xml  -->
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }"/>' readonly="readonly"> </td>
				</tr>
			</thead>
		</table>
		<div class="read_table_content">
			<textarea class="read_content" name="content"><c:out value="${board.content }"/></textarea>
		</div>
		<c:if test="${auth.userid eq board.writer }">
			<button type="submit" data-oper='modify' class="read_button" id="modify_btn">수정</button>
			<button type="submit" data-oper='remove' class="read_button" id="remove_btn">삭제</button>
		</c:if>
		<button type="submit" data-oper="list" class="read_button" id="list_btn">List</button>
	</form>
</div>

<%@include file="../includes/footer.jsp" %>	