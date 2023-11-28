<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/css/headfoot.css">

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<script type="text/javascript"></script>

<title>Insert title here</title>
</head>
<body>
	<!-- container 대신 다른 클래스 이름으로 바꿨다 , 부트스트랩과 겹치지 않는 클래스를 썼다 -->
	<div class="containerGet ">  <!-- width: 1500 height : 200 -->
		<div class="wrapper">
			<div class="wrapper_head">
				<div class="wrapper_title">
					<span>Spring project</span>
				</div>
				<div class="wrapper_sub">
					<c:if test="${!empty auth }">
						<span style="font-weight: bolder; margin-left: 100px;"><c:out value="${auth.username }"></c:out>님 접속중입니다</span>
					</c:if>
				</div>
				<nav class="wrapper_menu">
					<div class="menu-item-con">
						<a href="/board/list"><span class="menu-item">게시판</a>
						<c:choose>
						<c:when test="${empty auth }">  <!-- 로그인이 안 된 경우 -->
							<a href = "/member/signup"><span class="menu-item">회원가입</span></a>
							<a href = "/member/login"><span class="menu-item">로그인</span></a>
						</c:when>
						<c:otherwise>
							<a href = "/member/signup"><span class="menu-item">회원가입</span></a>
							<a href="/member/logout"><span class="menu-item">로그아웃</span></a>
						</c:otherwise>
						</c:choose>					
					</div>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>