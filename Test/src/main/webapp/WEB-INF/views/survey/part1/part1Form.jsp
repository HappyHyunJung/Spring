<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post">
		<h1>설문조사</h1>
		<div id="q1">
			1.가장 좋아하는 과일은?<br>
			<input type="radio" name="fruits" value="포도">포도<br>
			<input type="radio" name="fruits" value="사과">사과<br>
			<input type="radio" name="fruits" value="메론">메론<br>
			<input type="radio" name="fruits" value="체리">체리<br>
		</div>
		
		<div id="q2">
			2.가장 좋아하는 영화 장르는?<br>
			<input type="radio" name="movie_genre" value="멜로">멜로<br>
			<input type="radio" name="movie_genre" value="호러">호러<br>
			<input type="radio" name="movie_genre" value="액션">액션<br>
			<input type="radio" name="movie_genre" value="코메디">코미디<br>
		</div>
		
		<div id="q3">
			3.가장 좋아하는 술은?<br>
			<input type="radio" name="alcohol_type" value="소주">소주<br>
			<input type="radio" name="alcohol_type" value="맥주">맥주<br>
			<input type="radio" name="alcohol_type" value="위스키">위스키<br>
			<input type="radio" name="alcohol_type" value="럼">럼<br>
		</div>
		
		<div id="q4">
			4.응답자 위치:<br>
			<select name = "area">
				<option>-선택-</option>
				<option value="서울">서울</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
				<option value="인천">인천</option>
				<option value="광주">광주</option>
				<option value="대전">대전</option>
				<option value="울산">울산</option>
				<option value="강원">강원</option>
				<option value="경기">경기</option>
				<option value="경남">경남</option>
				<option value="경북">경북</option>
				<option value="전남">전남</option>
				<option value="전북">전북</option>
				<option value="제주">제주</option>
				<option value="충남">충남</option>
				<option value="충북">충북</option>
			</select>
		</div>
		
		<div id="q5">
			5.응답자 나이:<br>
			<input type="text" name="age">
		</div>
		<input type="submit" value="전송">
	</form>

</body>
</html>