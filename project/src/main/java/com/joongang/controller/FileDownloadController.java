package com.joongang.controller;

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

@WebServlet("/download.do")
public class FileDownloadController extends HttpServlet {
    public FileDownloadController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String imageFileName = request.getParameter("imageFileName");
		String encodedFileName = URLEncoder.encode(imageFileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
		String articleNO = request.getParameter("articleNO");
		
		OutputStream os =response.getOutputStream();
		// 파일 저장위치 가져오기
		String downFile = BoardController.ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + imageFileName;
		File file = new File(downFile);
		response.addHeader("Content-Disposition", "attachment;filename*=UTF-8''" + encodedFileName);
		FileInputStream is = new FileInputStream(file);
		byte[] buffer = new byte[1024*8];
		while(true) {
			int count = is.read(buffer);
			if(count == -1) {
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
