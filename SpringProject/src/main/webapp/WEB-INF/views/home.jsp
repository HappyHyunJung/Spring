<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/resources/js/jquery.bxslider.js"></script>

<%@include file="./includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/homeMain.css">

<script type="text/javascript">
	$(function () {
		$(".slider").bxSlider({
			auto:true,
			speed:400,
			pause:3000,
			mode:'fade'
		});

		let msg = "${msg}";
		
		if (msg === "") {
			return;
		}
		let txt;
		if (msg === "logout") {
			txt = "로그아웃 되었습니다";
		}
		alert(txt);
	
	});
</script>


<div class="wrapped_home">
 
	<header>
  	
		<input type="text" class="search">
		<img class="searchIcon" src="/resources/img/searchIcon.jpg">
		<nav class="mainNav">
			<div class="sector">빠른분야찾기</div>
			<div class="leftNav"><a href="#">베스트</a></div>
			<div class="leftNav"><a href="#">신상품</a></div>
			<div class="leftNav"><a href="#">이벤트</a></div>
			<div class="leftNav"><a href="#">채널예스</a></div>
			<div class="leftNav"><a href="#">블로그</a></div>
			<div class="leftNav"><a href="#">예스펀딩</a></div>
			<div class="leftNav"><a href="/notices/list">공지사항</a></div>
			
			<div class="rightNav">
				<div class="rightElement"><a href="#">예사단독판매</a></div>
				<div class="rightElement"><a href="#">작가만남</a></div>
				<div class="rightElement"><a href="#">이달의사은품</a></div>
				<div class="rightElement"><a href="#">특가할인</a></div>
				<div class="rightElement"><a href="#">추천도서</a></div>
				<div class="rightElement"><a href="#">대량/법인</a></div>
			</div>
		</nav>
	</header>
	<main>
		<div id="slides_con" >
			<div id="slider" class="slider">
				<img class="mainSlide" id="slide4" src="/resources/img/springSlider4.png">
				<img class="mainSlide" src="/resources/img/springSlider1.png">
				<img class="mainSlide" src="/resources/img/springSlider2.png">
				<img class="mainSlide" src="/resources/img/springSlider3.png">
			</div>
		</div>
		<img class="mainImg" src="/resources/img/homeBottom.png">
	</main>
	<%@include file="./includes/footer.jsp" %>	
</div>
