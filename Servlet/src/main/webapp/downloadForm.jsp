<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="downloadResult.jsp" method="post">
		<!-- input value 속성에 실제 이미지 파일 이름을 입력해야 한다. 없는 파일 입력하면 다운로드가 안된다 -->
		<input type="hidden" name="param1" value="poppy.png"/><br>
		<input type="hidden" name="param2" value="grape.jpg"/><br>
		<input type="submit" value="이미지 다운로드"/>
	</form>
</body>
</html>