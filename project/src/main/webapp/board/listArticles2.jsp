<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<head>

<script>
$(function() {
	let addItem = '<c:out value="${param.addItem}"/>';
	let delItem = '<c:out value="${param.delItem}"/>';
	
	let addMember = '<c:out value="${param.addMember}"/>';
	let modMember = '<c:out value="${param.modMember}"/>';
	
	let addReply = '<c:out value="${param.addReply}"/>';
	
	if (addItem) {
		alert("%%새글이 추가되었습니다");

	} else if (delItem) {
		alert("%%글이 삭제되었습니다");

	} else if (addMember) {
		alert("%%회원가입이 완료되었습니다");
	
	} else if (modMember) {
		alert("%%회원정보가 수정되었습니다");

	} else if (addReply) {
		alert("%%댓글이 추가되었습니다");
	}
	
	// url(~/board/listArticles.do)만 나온다  -> (?addItem=true)는 출력되지 않는다
	history.replaceState(null, null, location.pathname);
	//history.replaceState(null, null, "?");
	console.log(location.pathname);
});
</script>
<style>
	.cls1 {text-decoration:none;}
	.cls2 {text-align:center; font-size:30px;}
	
</style>

<title>Insert title here</title>
</head>

	<table align="center" border="1" width="80%">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td>글번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
		</tr>
		<c:choose>
			<c:when test="${empty articlesList }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			
			<c:otherwise>
			<c:forEach var="article" items="${articlesList }" varStatus="articleNum">
				<tr align="center">
					<td width="5%">${articleNum.count } </td>
					<td width="10%">${article.id } </td>  <!-- 작성자 -->
					<td align='left' width="35%">
						<span style='padding-right:30px'></span> 
					<c:if test="${article.level > 1 }">
						<c:forEach begin="1" end="${article.level }" step="1">
							<span style="padding-left:20px"></span>
						</c:forEach>
							<span style="font-size:12px;">&#9492;[답변]</span>						
					</c:if>  <!-- 댓글이 아닌 일반 글 -->
					<a class="cls1" href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO }" >${article.title }</a>
					</td>  <!-- title -->
					<td width="10%">
						<fmt:formatDate value="${article.writeDate }"/>
					</td>
				</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

<a class="cls1" href="${contextPath }/board/articleForm.do"><p class="cls2">글쓰기</p></a>
<%@ include file="../include/footer.jsp" %>
