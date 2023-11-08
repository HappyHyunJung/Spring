package com.jafa;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/test12")
public class TestServlet extends HttpServlet {
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet");
		String userName = request.getParameter("userName");
		String userId = request.getParameter("userId");
		System.out.println("이름 : " + userName);
		System.out.println("아이디 : " + userId);
		// localhost:8090/pro12/test12?userName=최현정&userId=skytop
	}
}
