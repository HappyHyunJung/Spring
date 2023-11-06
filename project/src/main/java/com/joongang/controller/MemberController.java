package com.joongang.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.joongang.dao.MemberDAO;
import com.joongang.domain.AuthVO;
import com.joongang.domain.MemberVO;

/**
 * Servlet implementation class MemberController
 */


@WebServlet({"/member/listMembers.do", "/member/memberForm.do",
	"/member/addMember.do", "/member/modMemberForm.do",
	"/member/modMember.do", "/member/delMember.do", "/member/loginForm.do",
	"/member/login.do", "/member/logout.do"})

public class MemberController extends HttpServlet {
	private MemberDAO memberDAO;

	@Override
	public void init() throws ServletException {
		memberDAO = new MemberDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String uri = request.getRequestURI();  // uri 받아옴
		int index = uri.lastIndexOf("/");  // 받아온 uri의 마지막 '/' 인덱스 받아옴
		String path = uri.substring(index);  // 받아온 인덱스에서 마지막까지 자르면 'listMembers.do'가 저장됨
		System.out.println("path: " + path);
		
		if(path == null || path.equals("/listMembers.do")) {

			List<MemberVO> list = memberDAO.listMembers();
			request.setAttribute("membersList", list);
			System.out.println(list);

			/*
			 * List<MemberVO> list2 = new ArrayList<MemberVO>();
			 * memberDAO.listMembers2(list2);
			 * request.setAttribute("membersList", list2);
			 * System.out.println(list2);
			 */
			nextPage = "/member/listMembers.jsp";
		} else if(path.equals("/memberForm.do")) {
			nextPage = "/member/memberForm.jsp";
			
		} else if(path.equals("/addMember.do")) {  //  ※  오타주의
			// 브라우저에서 'addMembers.do'로 요청이 오면 회원 데이터 추가
			// 입력받은 id, 패스워드, 이름 , 이메일 을 DB에 추가
			// ??? 입력받은 데이터를 불러오고 MemberVO에 저장
			// ??? addMember()가 매개변수가 필요한지 생각하기
			// ??? 프론트에 전달 -> request.setAttribute("msg", "addMember")
			// ??? 회원 추가했으면 listMembers()로 회원 조회하게 하기 위해 설정
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			MemberVO memberVO = new MemberVO();
			memberVO.setId(id);
			memberVO.setPwd(pwd);
			memberVO.setName(name);
			memberVO.setEmail(email);

			memberDAO.addMember(memberVO);
			
			// ???
			request.setAttribute("msg", "addMember");
			HttpSession session = request.getSession();
			AuthVO authVO = new AuthVO();
			authVO.setId(memberVO.getId());
			session.setAttribute("auth", authVO);
			response.sendRedirect(request.getContextPath() + "/index.jsp?addMember=true");
			
//			nextPage = "/member/listMembers.do";
			
		// listMembers.jsp 화면에서 수정버튼 눌렀을 때 action 이 실행된다
		} else if(path.equals("/modMemberForm.do")) {
			String id = request.getParameter("id");
			MemberVO memberInfo = memberDAO.findMember(id);
			request.setAttribute("memberInfo", memberInfo);
			nextPage = "/member/modMemberForm.jsp";
		
			// 해당 아이디의 수정화면 (modMemberForm.jsp)에서 수정버튼 클릭
		} else if(path.equals("/modMember.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			vo.setName(name);
			vo.setEmail(email);
			
			memberDAO.modMember(vo);
			request.setAttribute("msg", "modMember");
			response.sendRedirect(request.getContextPath() + "/index.jsp?modMember=true");

//			nextPage = "/member/listMembers.do";
			return;
		
		} else if(path.equals("/delMember.do")) {
			String _id = request.getParameter("id");
			memberDAO.delMember(_id);
			request.setAttribute("msg", "deleted");
			nextPage = "/member/listMembers.do";
	
		} else if(path.equals("/loginForm.do")) {
			nextPage = "/member/loginForm.jsp";
			
		} else if(path.equals("/login.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			
			if(memberDAO.isRegistered(vo)) {
				HttpSession session = request.getSession();
				AuthVO authVO = new AuthVO();
				authVO.setId(id);
				// ???  loginForm.jsp에서 입력된 id를 authVO 에 설정하고 authVO를 session에 넣는다
				// "auth" 키로 header.jsp에 전달되어 아이디가 출력된다
				session.setAttribute("auth", authVO);  
				String userURI = (String) session.getAttribute("userURI");

				if (userURI != null) {
					session.removeAttribute("userURI");
					response.sendRedirect(userURI);
					return;
				}
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				System.out.println("existed...");
				return;
			
			} else {  // id, password가 다르면
				// 다시 입력할 수 있는 상태가 되게 만든다
				response.sendRedirect(request.getContextPath() + "/member/loginForm.do?error=true");
				/*
				PrintWriter out = response.getWriter();
				out.print("<script> alert('아이디 혹은 비밀번호 입력 오류입니다'); history.go(-1); </script>");
				out.flush();*/
				System.out.println("not existed...");
				return;
			}
		
		} else if(path.equals("/logout.do")) {  // 로그아웃 상태 -> session 삭제
			HttpSession session = request.getSession(false);
			if(session != null) {
				session.removeAttribute("auth");
			}
			
			PrintWriter pw = response.getWriter();
			pw.print("<script> alert('로그아웃 되었습니다'); "
					+ "location.href='" + request.getContextPath() + "/index.jsp';</script>");
			
			// sendRedirect -> listArticles2.jsp에 파라미터 전달
//			response.sendRedirect(request.getContextPath() + "/member/listArticles2.do");
			return;
		}

		if(nextPage != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
