<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(function() {
	// MemberController에서 error가 파라미터로 넘어옴
	let error = '<c:out value="${param.error}"/>'; 
	if(error) {
		alert("아이디 혹은 비밀번호가 잘못되었습니다");
		history.replaceState(null, null, location.pathname);
	}
});
</script>
<div class="container">
	<div class="jumbotron text-center p-3 my-3 bg-primary text-white">
		<h1>로그인</h1>
	</div>
	<form action="${contextPath }/member/login.do" method="post">
		<div class="form-group">
			아이디: <input type="text" class="form-control" name="id" placeholder="아이디를 입력하세요" required="required">
		</div><br>
		<div class="form-group">
			비밀번호: <input type="password" class="form-control" name="pwd" placeholder="비밀번호를 입력하세요" required="required">
		</div><br>
		<div class="col text-center">
			<button class="btn btn-success">로그인</button>
			<button class="btn btn-warning" type="reset">취소</button>
		</div><br>
	</form>
</div>
<%@ include file="../include/footer.jsp" %>