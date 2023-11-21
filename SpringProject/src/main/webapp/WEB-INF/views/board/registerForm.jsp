<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/registerFomMain.css">

<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="wrapper_register">
		<div class="register_head">
			<h3>게시판 작성 화면 입니다</h3>
		</div>
		<div class="register_line"></div>
		<div class="register_body">
			<form class="register_form" method="post" action="/board/register">
				<div class="register_title">
					<input class="title_area" maxlength="50" placeholder="제목" name="title" required="required"/>
					<input class="title_area" maxlength="50" readonly="readonly" name="writer" value="${auth.userid }"/>
				</div>
				<div class="register_written">
					<textarea type="text" class="written_area" placeholder="내용" name="content" required="required"></textarea>
				</div>
				<div class="register_submit">
					<button class="register_submit_button" id="submit" type="submit">작성</button>
					<button class="register_submit_button" id="reset" type="reset">취소</button>
				</div>
			</form>
		</div>
	</div> <!-- wrapper_register -->
	
	<%@include file="../includes/footer.jsp" %>
</body>
</html>