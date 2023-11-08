<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지리스트창</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
	/* a { display: block; } */  /* a 태그가 원래 인라인 속성이다 그것 블록속성으로 바꾼다 - a 태그 영역이 커져서 img 태그를 감싼다 */
</style>
<body>
<div class="container">
	<table class="table table-bordered">
		<tr>
			<th>이미지</th>
			<th>이미지 이름</th>
			<th>선택하기</th>
		</tr>
		
		<%
			for(int i = 0; i < 5; i ++) {
		%>
				<tr>
					<td>
						<a href='#'>
						  <img src='image/duke.png' width='90' height="90">
						</a>
					</td>
					<td>
						<a href='#'>
							<strong>이미지 이름 : 듀크<%=i %></strong>
						</a>
					</td>
					<td>
						<a href="#"><input name='chk<%=i%>' type='checkbox'></a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</div>
</body>
</html>