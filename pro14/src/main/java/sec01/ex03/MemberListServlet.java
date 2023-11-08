package sec01.ex03;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberListServlet
 */
@WebServlet("/member/list")
public class MemberListServlet extends HttpServlet {
	private MemberDAO memberdao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		memberdao = new MemberDAO();
		MemberVO vo = new MemberVO();
		
		List<MemberVO> listMembers = memberdao.listMembers(request.getParameter("searchName"));

		request.setAttribute("memberList", listMembers);  // ${memberList}

		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/member/memberList.jsp");
		rd.forward(request, response);
	}
}
