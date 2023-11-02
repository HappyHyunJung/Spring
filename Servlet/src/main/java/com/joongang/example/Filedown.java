package com.joongang.example;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Filedown
 */
@WebServlet("/download.do")
public class Filedown extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// file_repo(경로)에 있는 것을 읽어온다
		String file_repo = "D:\\JAVA\\eclipse-workspace\\FileUpload";
		String fileName = request.getParameter("fileName");
		
		// 파일이름 한글 깨지는 것 막기위해 사용
		String encodeFileName = URLEncoder.encode(fileName,
				StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
		String downFile = file_repo + "\\" + fileName;
		System.out.println("downFile " + downFile);
		
		File file = new File(downFile);  // file object 만들기
		response.addHeader("Content-Disposition", "attachment;filename*=UTF-8''" + encodeFileName);
		
		FileInputStream is = new FileInputStream(file);
		OutputStream os = response.getOutputStream();
		byte[] buffer = new byte[1024*8];  // 한 번에 파일을 읽어오는 크기
		
		while(true) {
			int count = is.read(buffer);
			if(count == -1) {   // 더이상 읽을 것이 없다
				break;
			}
			os.write(buffer, 0, count);
		}
		os.close();
		is.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
