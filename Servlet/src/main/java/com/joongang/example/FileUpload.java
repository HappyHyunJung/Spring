package com.joongang.example;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class FileUpload
 */
//@WebServlet("/upload.do")
public class FileUpload extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
//		request.setCharacterEncoding("utf-8");
//		File path = new File("D:\\JAVA\\eclipse-workspace\\FileUpload");
//		DiskFileItemFactory factory = new DiskFileItemFactory();
//		factory.setRepository(path);
//		factory.setSizeThreshold(1024*1024);  // 1024 = 1키로 바이트
//		ServletFileUpload upload = new ServletFileUpload(factory);
//		
//		try {
//			List<FileItem> items = upload.parseRequest(request);  // 클라이언트에서 들어온 요청을 List 형태로 분리한다  
//														// request 클라이언트 요청 데이터(파일, 파일, 파라미터, 파라미터, 파라미터)가 있다
//			for(int i = 0; i < items.size(); i++) {
//				FileItem fileItem = items.get(i);
//				if (fileItem.isFormField()) {  // 파라미터인 경우
//					System.out.println(fileItem.getFieldName() + 
//							"=" + fileItem.getString("utf-8"));
//				} else {                       // 파일인 경우
//					System.out.println(fileItem.getFieldName());  // uploadForm.jsp 파일에서 form 태그의 file 타입 input name
//					System.out.println(fileItem.getName());    // 실제로 전송한 파일 이름
//					System.out.println(fileItem.getSize());
//					
//					if(fileItem. getSize() > 0) {
//						int idx = fileItem.getName().lastIndexOf("\\");
//						if(idx == -1) {   // idx가 없다면
//							idx = fileItem.getName().lastIndexOf("/");
//						}
//						String fileName = fileItem.getName().substring(idx + 1);
//						File uploadFile = new File(path+"\\"+fileName);   // 경로 + 파일이름
//						fileItem.write(uploadFile);
//					}
//				}
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
		
		cosUpload(request, response);
	}
	// cos.jar을 이용한 파일업로드
	// https://ninearies.tistory.com/92
	private void cosUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		request.setCharacterEncoding("utf-8");
		// 실제 파일이 저장되는 물리 경로
		String path = "D:\\JAVA\\eclipse-workspace\\FileUpload";
		// 최대 저장 용량
		int max = 1024 * 1024 * 10;
		
		try {
			// 사용자가 전송한 파일을 path 경로에 저장하기
			
			MultipartRequest mr = new MultipartRequest(request, path, max, "utf-8", new DefaultFileRenamePolicy());
		 	// 사용자가 전송시킨 것을 MultipartRequest에 담고 , MultipartRequest에서 <input type=file>을 전부가져온다
			Enumeration<String> en = mr.getFileNames();
		 	
			// en에서 가지고 있는 값에서 개별 접근
			// 파일이 여러개 있을 수도 있기 때문에 그걳을 각자 개별 접근
		 	while(en.hasMoreElements()) {
		 		String file = en.nextElement();
		 		
		 		// file로 전송된 실제 파일을 MultipartRequest 객체에서 가져오기
		 		String origin = mr.getOriginalFileName(file);  // 원폰 파일
		 		String upload = mr.getFilesystemName(file);  // 리네임파일 ??
		 		System.out.println("origin " + origin + " upload " + upload);
		 	}
		 	
		 	System.out.println("request:param1 " + request.getParameter("param1"));
		 	System.out.println("request:param2 " + request.getParameter("param2"));
		 	System.out.println("request:param3 " + request.getParameter("param3"));
		 	System.out.println("mr:param1 " + mr.getParameter("param1"));
		 	System.out.println("mr:param2 " + mr.getParameter("param2"));
		 	System.out.println("mr:param3 " + mr.getParameter("param3"));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
