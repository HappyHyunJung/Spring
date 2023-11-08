<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%! 
	//선언문 : 클래스 멤버
	String name = "듀크";	  // 변수 선언 -> 자바 파일에 멤버변수로 들어간다
	// method
	public String getName() {
		return this.name;
	}
	
	//선언문에서 중첩클래스 선언 된다
	class TestA {
		
	}
	
	// 정적 블록
	static {
		
	}
	// 중첩 인터페이스
	interface TestH {
		
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%   // 스크립트릿
	// 변수 선언 -> 자바 파일에 지역변수로 들어간다
	String email = "choi@naver.com";
	// 스크립트릿에서 메소드 선언이 안 된다
	
	// 중첩클래스 선언된다
	class TestB {
		
	}
%>


안녕하세요. <%=
	// 표현식
	name
%>님! <br>

이메일 : <%=email %> <br>
<%-- 
	나이: <%=age %> 
--%>
주소: 필드 - <%=addr %> <br>
주소 : 메서드 - <%=getAddr() %> <br>
<%
	int age = 30;
%>

<%!
	String addr="대구시 수성구";
	public String getAddr() {
		return addr;
	}
%>

</body>
</html>