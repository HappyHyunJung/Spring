package com.joongang.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SetCookie
 */
@WebServlet("/setCookie")
public class SetCookie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Date d = new Date();
		Cookie c = new Cookie("cookieTest",
				URLEncoder.encode("Spring 개발자", "utf-8"));
		Cookie cId = new Cookie("id",
				URLEncoder.encode("hong", "utf-8"));
		Cookie cPw = new Cookie("pw",
				URLEncoder.encode("1212", "utf-8"));
//		c.setMaxAge(24 * 60 * 60);
		c.setMaxAge(-1);
		cId.setMaxAge(-1);
		cPw.setMaxAge(-1);
		response.addCookie(c);
		response.addCookie(cId);
		response.addCookie(cPw);
		
		out.println("현재시간 : " + d);
		out.println("<br> 문자열을 Cookie에 저장합니다.");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
