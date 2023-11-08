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
@WebServlet("/member/list2")
public class MemberListServlet2 extends HttpServlet {
	private MemberDAO memberdao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		memberdao = new MemberDAO();
		
		List<MemberVO> listMembers = memberdao.listMembers(null);

		request.setAttribute("memberList", listMembers);  // ${memberList}

		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/member/memberList2.jsp");
		rd.forward(request, response);
	}
}
