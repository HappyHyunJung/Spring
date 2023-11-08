<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    

<script>
$(function() {
	let replyForm = $("#replyForm");
	$("#replyForm input").on("click", function(e) {
		let operation = $(this).data("oper");
		console.log(operation);
		if (operation === 'list') {
			replyForm.attr("action", "${contextPath}/board/listArticles.do");
			replyForm.submit();
		}
	});
	
	$("#imageFileName").change((function() {
		if (this.files && this.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			};
			reader.readAsDataURL(this.files[0]);
		}
	}));
});
</script>

<h1 style="text-align:center">답글쓰기</h1>

<form id="replyForm" name="replyForm" method="post" action="${contextPath }/board/addReply.do" enctype="multipart/form-data">
	<table style="text-align:center;">
		<tr>
			<td align="right">글쓴이:&nbsp;</td> <!-- 글쓴이 writer가 name이 없는데 viewArticle2.jsp에서 파라미터로 넘어옴 -->
			<td><input type="text" size="5" value="<c:out value="${writer }" />" disabled /></td>
		</tr>
		<tr>
			<td align="right">글제목:&nbsp;</td>
			<td><input type="text" size="67" maxlength="500" name="title" /></td>
		</tr>
		<tr>
			<td align="right" valign="top"><b>글내용:&nbsp;</td>
			<td ><textarea name="content" rows="10" cols="65" maxlength="4000"></textarea></td>
		</tr>
		<tr>
			<td align="right">이미지파일 첨부:	</td>
			<td ><input type="file" id="imageFileName" name="imageFileName" /></td>
			<td><img id="preview" src="#" width=200 height=200 /></td>
		</tr>
		<tr>
			<td align="right"> </td>
			<td colspan="2">
			<!-- 태그에 변수 넣기 -->
				<input type="submit" value="답글쓰기"/>
				<input type="button" data-oper='list' value="목록보기"/>
			</td>
		</tr>
	</table>
</form>

<%@ include file="../include/footer.jsp" %>