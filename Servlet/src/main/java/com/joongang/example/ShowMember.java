package com.joongang.example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShowMember
 */
@WebServlet("/show")
public class ShowMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		Boolean isLogon = false;
		HttpSession session = request.getSession(false);
		//System.out.println(session);
		
		// session이 없으면 안 만들므로 null 체크를 해야 한다
		if(session != null) {
			// session null이 아니라면
			//System.out.println(session);
			isLogon = (Boolean) session.getAttribute("isLogon");
			
			if (isLogon == true) {
				// isLogon이 true 라면 -> 형변환 하는 부분에서 헤맸다.
				String id = (String) session.getAttribute("login.id");
				String pwd = (String) session.getAttribute("login.pwd");
				
				out.print("<html><body>");
				out.print("아이디 : " + id + "<br>" + "비밀번호 : " + pwd);
				out.print("</body></html>");
			} else {
				response.sendRedirect("logIn.html");
			}
		} else {
			response.sendRedirect("logIn.html");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}
