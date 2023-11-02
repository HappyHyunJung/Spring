package com.joongang.example;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberServlet
 */
//@WebServlet("/member")
public class MemberServlet extends HttpServlet {
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
		
		MemberDAO2 dao2 = new MemberDAO2();
		String command = request.getParameter("command");
		if(command != null && command.equals("addMember")) {
			
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			System.out.println("command : " + command + "\nid : " + id + "\npwd : " + pwd
					+ "\nname : " + name + "\nemail : " + email);
			
			MemberVO vo = new MemberVO();
			 vo.setId(id);
			 vo.setPwd(pwd);
			 vo.setName(name);
			 vo.setEmail(email);
			 
			 dao2.addMember(vo);
		} else if(command != null && command.equals("delMember")) {
			
			String id = request.getParameter("id");
			System.out.println("command : " + command + "\nid : " + id);
			
			 dao2.delMember(id);
		}
		List<MemberVO> list = dao2.listMembers();
		request.setAttribute("list", list);
		RequestDispatcher dispatcher = request.getRequestDispatcher("member.jsp");
		dispatcher.forward(request, response);
	}
}
