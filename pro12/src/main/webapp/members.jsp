<%@page import="sec01.ex01.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String searchName = request.getParameter("userName");
	MemberDAO dao = new MemberDAO();
	MemberVO membervo = new MemberVO();
	membervo.setName(searchName);
	List<MemberVO> memberList = dao.listMembers(membervo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<title>회원 정보 출력</title>
</head>
<body>
<div class="container">
	<!-- 회원 검색 -->
	<form action="" method="post">
		이름 : <input type="text" name="userName">
		<button>검색</button>
	</form>

	<table class="table table-bordered">
		<tr>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>이름</td>
			<td>이메일</td>
			<td>가입일자</td>
		</tr>
		
		<!-- 반복구간 시작 -->
		<% for(MemberVO vo : memberList) {%>
		<tr>
			<td><%=vo.getId() %></td>
			<td><%=vo.getPwd() %></td>
			<td><%=vo.getName() %></td>
			<td><%=vo.getEmail() %></td>
			<td><%=vo.getJoinDate() %></td>
		</tr>
		
		<!-- 반복구간 끝 -->
		<%} %>
	</table>
</div>
</body>
</html>