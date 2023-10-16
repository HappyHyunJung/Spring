package com.joongang.example;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SecondServlet extends HttpServlet{
	public void init() throws ServletException {
		System.out.println("SecondServlet.init 메서드 호출");
	}

	protected void doGet (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		System.out.println("SecondServlet.init 메서드 호출");
	}
	public void destroy()  {
		System.out.println("SecondServlet.destroy 메서드 호출");
	}
}
