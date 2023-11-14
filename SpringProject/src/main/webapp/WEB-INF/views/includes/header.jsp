<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/header.css">
<script type="text/javascript"></script>

<title>Insert title here</title>
</head>
<body>
	<div class="container">  <!-- width: 990 height : 350 -->
		<div class="wrapper">
			<div class="wrapper_head">
				<div class="wrapper_title">
					<span>Spring project</span>
				</div>
				<nav class="wrapper_menu">
					<div class="menu-item-con">
						<a href="/board/list"><span class="menu-item">게시판</a>
						<a href="/member/signup"><span class="menu-item">회원가입</a>
						<c:choose>
						<c:when test="${not empty auth }">
							<a href = "/member/logout"><span class="menu-item">로그아웃</span></a>
						</c:when>
						<c:otherwise>
							<a href="/member/login"><span class="menu-item">로그인</span></a>
						</c:otherwise>
						</c:choose>					
					</div>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>