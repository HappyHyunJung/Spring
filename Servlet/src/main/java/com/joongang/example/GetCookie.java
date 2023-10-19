package com.joongang.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetCookie
 */
@WebServlet("/getCookie")
public class GetCookie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Cookie[] allValues = request.getCookies();
		for (int i = 0; i < allValues.length; i++) {
			if (allValues[i].getName().equals("cookieTest")) {
				out.println("<h2>Cookie cookieTest : " + URLDecoder.decode(allValues[i].getValue(), "utf-8"));
			} else if(allValues[i].getName().equals("id")) {
				out.println("<h2>Cookie id : " + URLDecoder.decode(allValues[i].getValue(), "utf-8"));
			} else if (allValues[i].getName().equals("pw")) {
				out.println("<h2>Cookie pw : " + URLDecoder.decode(allValues[i].getValue(), "utf-8"));
			}
		}
		for(int i = 0; i < allValues.length; i++) {
			System.out.println(allValues[i].getName() + "  :  " + allValues[i].getValue());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
