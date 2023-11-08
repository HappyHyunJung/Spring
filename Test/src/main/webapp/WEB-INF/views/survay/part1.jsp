<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/survay/part2" method="post">
		<h1>설문조사</h1>
		<div id="q1">
			1.가장 좋아하는 과일은?<br>
			<input type="radio" name="fruits">포도<br>
			<input type="radio" name="fruits">사과<br>
			<input type="radio" name="fruits">메론<br>
			<input type="radio" name="fruits">체리<br>
		</div>
		
		<div id="q2">
			2.가장 좋아하는 영화 장르는?<br>
			<input type="radio" name="movie_genre">멜로<br>
			<input type="radio" name="movie_genre">호러<br>
			<input type="radio" name="movie_genre">액션<br>
			<input type="radio" name="movie_genre">코미디<br>
		</div>
		
		<div id="q3">
			3.가장 좋아하는 술은?<br>
			<input type="radio" name="alcohol_type">소주<br>
			<input type="radio" name="alcohol_type">맥주<br>
			<input type="radio" name="alcohol_type">위스키<br>
			<input type="radio" name="alcohol_type">럼<br>
		</div>
		
		<div id="q4">
			4.응답자 위치:<br>
			<select>
				<option>서울</option>
				<option>부산</option>
				<option>대구</option>
			</select>
		</div>
		
		<div id="q5">
		
		</div>
	</form>

</body>
</html>