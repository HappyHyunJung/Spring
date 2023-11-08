package sec01.ex01;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestTest
 */
@WebServlet("/req")
public class RequestTest extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// request 객체에 데이터 바인딩
		request.setAttribute("content", "request Binding");
		
		//forwarding  // 1 para : 이동할 경로 //
		RequestDispatcher rd = request.getRequestDispatcher("test01/request01.jsp");
		rd.forward(request, response);
	}
}
