package sec01;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/test01")
public class TestServlet extends HttpServlet {

	public TestServlet() {
		System.out.println("서블릿 생성");
	}
	
	public void init() throws ServletException {
		System.out.println("init 메서드 호출");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doget 메서드 호출");
		System.out.println();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("dopost 메서드 호출");
	}

	public void destroy() {
		System.out.println("destroy 메서드 호출");
	}
}
