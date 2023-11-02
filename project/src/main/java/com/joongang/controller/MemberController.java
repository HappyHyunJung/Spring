package com.joongang.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.joongang.dao.MemberDAO;
import com.joongang.domain.MemberVO;

/**
 * Servlet implementation class MemberController
 */

/*
@WebServlet({"/member/listMembers.do", "/member/memberForm.do",
	"/member/addMember.do", "/member/modMemberForm.do",
	"/member/modMember.do", "/member/delMember.do"})
*/
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
			// 브라우저에서 'addMembers.do'로 요청이 오면 데이터 추가
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
			request.setAttribute("msg", "addMember");
			nextPage = "/member/listMembers.do";
			
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
			request.setAttribute("msg", "modified");
			nextPage = "/member/listMembers.do";
		
		} else if(path.equals("/delMember.do")) {
			String _id = request.getParameter("id");
			memberDAO.delMember(_id);
			request.setAttribute("msg", "deleted");
			nextPage = "/member/listMembers.do";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
