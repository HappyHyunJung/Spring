<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function () {
	let error = '<c:out value="${param.error}"/>';
	
	if (error) {
		alert("아이디 혹은 비밀번호가 다릅니다");
		history.replaceState(null, null, location.pathname);
	}
});
	
</script>
</head>
<body>
	<div>
		<div>
			<h1>로그인</h1>
		</div>
		
		<form action="/login" method="post">
			<div class="form-group">
				아이디 : <input type="text" name="id" placeholder="아이디를 입력하세요" required="required"/>
			</div>
			<br>
			<div class="form-group">
				비밀번호 : <input type="password" name="pwd" placeholder="비밀번호를 입력하세요" required="required" />
			</div>
			<br>
			<div>
				<button>로그인</button>
				<button type="reset">취소</button>
			</div>
		</form>
	</div>
</body>
</html>