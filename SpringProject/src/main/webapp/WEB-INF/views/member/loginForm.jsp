<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/resources/css/loginMain.css">

<%@include file="../includes/header.jsp"%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function () {
		console.log("loaded");
		
		$(".login_button").on("click", function (e) {
			e.preventDefault();
			if(isValid()) {
				console.log($("#userid").val());
				// 관리자로 로그인하면 관리자 페이지로 이동
				if($("#userid").val() === "admin@admin.com") {
					$("form").attr("method", "post");
					$("form").attr("action", "/admin/header");
				}
				$("form").submit();
			}
		});
		
		function isValid() {
			let userid = $("#userid").val();
			let userpw = $("#userpw").val();
			
			$("#error_userid").text("");
			$("#error_userpw").text("");
			
			if (userid === "") {
				$("#error_userid").text("E-mail을 입력하셔야 합니다");
				$("#userid").focus();
				return false;
			}
			if (userpw === "") {
				$("#error_userpw").text("비밀번호를 입력하셔야 합니다");
				$("#userpw").focus();
				return false;
			}
			return true;
		}
		
		// MemberController에서 전달되는 error를 체크해서 alert() 출력
		let error = "${error}";
		console.log(error);
		
		if (error === "") {  // error가 없다 , 정상적으로 아이디 , 비밀번호 입력
			return;
		} 
		if (error === "no_user") {
			$("#userid").focus();
		} else {
			$("#userpw").focus();
		}
		let msg = (error === "no_user") ? "존재하지 않는 Email입니다" : "비밀번호가 일치하지 않습니다";
		alert(msg);
	});

</script>

<div class="wrapped_login">
	<form action="/member/login" class="login_form" method="post">
		<div class="form_id">
			<label>E-mail</label>
			<input type="email" class="id_control" id="userid" name="userid" placeholder="E-mail을 입력하세요"
				value="${memberVO.userid }" />
			<div class="error" id="error_userid"></div>
		</div>
		
		<div class="form_pw">
			<label>비밀번호</label>
			<input type="password" class="pw_control" id="userpw" name="userpw" placeholder="비밀번호를 입력하세요"/>
			<div class="error" id="error_userpw"></div>
		</div>
		<div class="form_login_button">
			<button class="login_button" type="submit">
				로그인
			</button>
		</div>
	</form>
</div>

<%@include file="../includes/footerCenter.jsp" %>