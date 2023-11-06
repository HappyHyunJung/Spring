<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#tr_image_modify {
		display:none;
		/* 버튼이 안 보이게 한다 */
	}
	
	#tr_btn_modify {
		display:none;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function () {
		
		let articleForm = $("#articleForm");
		$("#articleForm input").on("click", function(e) {
			let operation = $(this).data("oper");  // input 태그의 oper 불러온다 -> 'list'
			console.log(operation);
			
			if(operation === 'list' || operation === 'modify_off') {
				e.preventDefault();  // 원래 input 태그를 눌렀을 때 form 태그의 action이 실행되는 이벤트 무시하고 이벤트 전이
				articleForm.attr("action", "${contextPath}/board/listArticles.do");
				articleForm.submit();
			
			} else if(operation === 'modify_on') {   /* 수정하기 기능 수행 */
				$("#i_title").attr("disabled", false);
				$("#i_content").attr("disabled", false);
				$('#i_imageFileName').attr("disabled", false);
				
				$("#tr_image_modify").show();  /* 보이지 않게 했던 버튼을 보이게 구성 */
				$("#tr_btn_modify").show();
			
			} else if (operation === "modify") {  // 수정완료 - 수정이 반영된다
				articleForm.attr("action" , "${contextPath}/board/modArticle.do");
				articleForm.submit();
			
			} else if (operation === "remove") {   // 게시글 삭제
				e.preventDefault(); 
				articleForm.attr("enctype", "application/www-form-urlencoded");
				articleForm.attr("action", "${contextPath}/board/removeArticle.do");
				articleForm.submit();
				
			} else if (operation === "reply") {     // 답글 달기
				articleForm.attr("action", "${contextPath}/board/replyForm.do" +
						"?parentNO=${article.articleNO}&writer=${article.id}");
				articleForm.submit();
			}
		});
		
		$("#i_imageFileName").change(function () {   // change 함수  // 수정하기에서 바뀐 이미지가 출력
			if(this.files && this.files[0]) {      // 파일이 있는지 체크
				let reader = new FileReader();
				reader.onload = function(e) {
					
					// preview에 src 속성을 선택된 파일로 변경해준다
					$("#preview").attr('src', e.target.result);   
				};
				reader.readAsDataURL(this.files[0]);
			}
		});
		
		/* url을 바꾼다 */
		let modItem = '<c:out value="${param.modItem}"/>';
		if(modItem) {
			alert("수정했습니다.");
			let url = new URL(location.href);
			let sp = new URLSearchParams(url.search);
			sp.delete("modItem");
			history.replaceState(null, null, "?" + sp.toString());
		}
		
	
	});
</script>
</head>

<body>
<form id="articleForm" name="articleForm" method="post" enctype="multipart/form-data">
	<table style="text-align:left;">
		<tr>
			<td width="150" align="center" bgcolor="FF9933">글번호</td>
			<td>
				<input type="text" value="${article.articleNO }" disabled />
				<input type="hidden" name="articleNO" value="${article.articleNO }" />  <!-- 수정하기 -->
			</td>
		</tr>
		<tr>
			<td width="150" align="center" bgcolor="FF9933">작성자 아이디</td>
			<td>
				<input type="text" values="${article.id }" disabled />
				<input type="hidden" name="id" value="${article.id } " />  <!-- 수정하기 -->
			</td>
		</tr>
		<tr>
			<td width="150" align="center" bgcolor="FF9933">제목</td>
			<td>
				<input type="text" values="${article.title }" name="title" id="i_title" disabled />
			</td>
		</tr>		
		<tr>
			<td width="150" align="center" bgcolor="FF9933">내용</td>
			<td>
				<textarea rows="20" cols="60" name="content" id="i_content" disabled />${article.content }</textarea>
			</td>
		</tr>	
		
		<!-- 첨부파일이 있는지 -->	
		<!-- https://my-develop-diary.tistory.com/192  참고링크  filedownload -->
		<c:if test="${not empty article.imageFileName  &&  article.imageFileName != 'null'}">
			<tr>
				<td width="150" align="center" bgcolor="FF9933">이미지</td>
				<td>
					<input type="hidden" name="originalFileName" value="${article.imageFileName }" />  <!-- 수정할 때 사용 -->
					<img width="500" src="${contextPath }/download.do?imageFileName=${article.imageFileName}&articleNO=${article.articleNO}" id="preview" />
				</td>
			</tr>
		</c:if>
		
		<tr id="tr_image_modify">
			<td width="150" align="center" bgcolor="FF9933">파일경로</td>
			<td>
				<input type="file" name="imageFileName" id="i_imageFileName" disabled />
			</td>
		</tr>
		<tr>
			<td width="150" align="center" bgcolor="FF9933">등록일자</td>
			<td>
				<input type="text" value="${article.writeDate }" disabled />
			</td>
		</tr>
		<tr id="tr_btn_modify">
			<td align="center">
				<input type="button" data-oper='modify' value="수정완료" />
				<input type="button" data-oper='modify_off' value="수정취소" />
			</td>
		</tr>
		<tr id="trb_btn">
			<td colspan="2" align="center">
				<input type="button" data-oper='modify_on' value="수정하기" />  <!-- 수정 상태가 되록록 input의 disabled 상태를 없앤다 -->
				<input type="button" data-oper='list' value="목록보기" />
				<input type="button" data-oper='remove' value="삭제하기" />
				<input type="button" data-oper='reply' value= "답글쓰기" />
			</td>
		</tr>
	</table>	
</form>
<%@ include file="../include/footer.jsp" %>