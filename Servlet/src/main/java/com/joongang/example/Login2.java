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
 * Servlet implementation class Login2
 */
@WebServlet("/login2")
public class Login2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		//logIn.html 에서 입력한 id, pwd 불러오기 - logIn.html name과 같아야 한다
		String id = request.getParameter("user_id");
		String pwd = request.getParameter("user_pw");
		System.out.println(id + "\n" + pwd);
		
		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setPwd(pwd);
		MemberDAO2 dao2 = new MemberDAO2();
		// 입력한 정보가 있는 체크
		boolean res = dao2.isExisted(vo);
		if(res) {
			//login process
			HttpSession session = request.getSession();
			session.setAttribute("isLogon", true);
			session.setAttribute("login.id", id);
			session.setAttribute("login.pwd", pwd);
			out.println("<html><body>");
			out.println("안녕하세요 " + id + "님! <br>");
			out.println("<a href='showMember'>회원정보보기</a>");
			out.println("</body></html>");
		} else {
			// not login - retry login - logIn.html로 이동
			out.println("<html><body>");
			out.println("회원아이디가 조회되지 않습니다.<br>");
			out.println("<a href='logIn.html'>다시로그인하기</a>");
			out.println("</body></html>");
			
		}
	}

}
