package com.joongang.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import com.joongang.domain.ArticleVO;
import com.joongang.service.BoardService;

/**
 * Servlet implementation class BoardContoller
 */
@WebServlet({"/board/listArticles.do", "/board/articleForm.do" ,
	"/board/addArticle.do", "/board/viewArticle.do", "/board/modArticle.do",
	"/board/removeArticle.do", "/board/listArticles2.do"})
public class BoardController extends HttpServlet {
	private BoardService boardService;
	public static final String ARTICLE_IMAGE_REPO = "D:\\JAVA\\eclipse-workspace\\FileUpload";
	private ArticleVO articleVO;

	public BoardController() {
        super();
        boardService = new BoardService();
        articleVO = new ArticleVO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String uri = request.getRequestURI();  // uri 받아옴
		int index = uri.lastIndexOf("/");  // 받아온 uri의 마지막 '/' 인덱스 받아옴
		String path = uri.substring(index);  // 받아온 인덱스에서 마지막까지 자르면 'listMembers.do'가 저장됨
		System.out.println("path: " + path);
		
		List<ArticleVO> articlesList = new ArrayList<ArticleVO>();
		
		if(path == null || path.equals("/listArticles.do")) {
		// 게시판 목록 보여주기
//			request.setAttribute("articlesList", boardService.listArticles()) ;   // 동작가능
			articlesList = boardService.listArticles();
			request.setAttribute("articlesList", articlesList);
			nextPage = "/board/listArticles.jsp";
		
		} else if(path.equals("/articleForm.do")) {
			nextPage = "/board/articleForm.jsp";
		
		} else if(path.equals("/addArticle.do")) {
			Map<String, String> articleMap = new HashMap<String,String>();
			int articleNO = 0;
			upload(request, response, articleMap);
			System.out.println("파일 업로드 완료");
			
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			System.out.println(title  + "\t" + content + "\t" + imageFileName);
			
			// id를 'lee'가 아닌 choi, kang으로 바꾸면 오류가 난다 - db에 저장된 id만 글쓰기가 된다
			// t_board id 속성이 t_member의 id 속성과 외래키로 연관되기 때문
			articleVO.setParentNO(0);
			articleVO.setId("lee");
			articleVO.setTitle(title);
			articleVO.setContent(content);
			articleVO.setImageFileName(imageFileName);
			articleNO = boardService.addArticle(articleVO);
			// imageFileName이 있으면 이미지 파일을 destDir로 옮겨야 한다
			if(imageFileName != null && imageFileName.length() != 0) {
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();
				FileUtils.moveToDirectory(srcFile, destDir, true);
			}
			/*
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					+ " alert('새글추가');"
					+ " location.href='" + request.getContextPath() + "/board/listArticles.do';"
					+ " </script>");
			*/
			response.sendRedirect(request.getContextPath() + "/board/listArticles.do?addItem=true");
			return;
		
		} else if(path.equals("/viewArticle.do")) {
			String articleNO = request.getParameter("articleNO");
			articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
			System.out.println("articleVO\t" + articleVO.getArticleNO());
			request.setAttribute("article", articleVO);
			nextPage = "/board/viewArticle.jsp";
		
		} else if(path.equals("/modArticle.do")) {   // 게시글 수정
			Map<String, String> articleMap = new HashMap<String,String>();
			upload(request, response, articleMap);
			System.out.println("파일 업로드 완료");
			
			int articleNO = Integer.parseInt(articleMap.get("articleNO"));  // viewArticle.jsp에서 hidden으로 표시한 
			articleVO.setArticleNO(articleNO);
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			System.out.println(title  + "\t" + content + "\t" + imageFileName);
			
			// id를 'lee'가 아닌 choi, kang으로 바꾸면 오류가 난다 - db에 저장된 id만 글쓰기가 된다
			// t_board id 속성이 t_member의 id 속성과 외래키로 연관되기 때문
			articleVO.setParentNO(0);
			articleVO.setId("lee");
			articleVO.setTitle(title);
			articleVO.setContent(content);
			articleVO.setImageFileName(imageFileName);
			
			boardService.modArticle(articleVO);
			// imageFileName이 있으면 이미지 파일을 destDir로 옮겨야 한다
			if(imageFileName != null && imageFileName.length() != 0) {
				String originalFileName = articleMap.get("originalFileName");  // 이동하기 전 원래 파일이름
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();
				FileUtils.moveToDirectory(srcFile, destDir, true);
				File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + originalFileName);
				oldFile.delete();
			}
			/*
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					+ "  alert('수정완료');"
					+ "  location.href='" + request.getContextPath() +  "/board/viewArticle.do?articleNO="
					+ articleNO + "';"
					+ "</script>");  */
			
			response.sendRedirect(request.getContextPath() + "/board/viewArticle.do?articleNO=" + articleNO
					+ "&modItem=true");
			return;
		
		// 게시글을 삭제해야 하므로 삭제 게시글을 특정하는 articleNO가 있을 것이다
		// viewArticle.jsp에서 articleNO를 받아온다
		} else if (path.equals("/removeArticle.do")) {
			int articleNO = Integer.parseInt(request.getParameter("articleNO"));  
			// viewArticle.jsp에서 articleNO를 받아온다
			System.out.println(articleNO);
			List<Integer> articleNOList = boardService.removeArticle(articleNO);
			
			// 파일 디렉터리 삭제 ???  많이 헤매다가 스스로 해결못했으니 연습 필요
			for(int i = 0; i < articleNOList.size(); i++) {
				int FileNO = articleNOList.get(i);
				File removedDir = new File(ARTICLE_IMAGE_REPO + "\\" + FileNO);
				if(removedDir.exists()) {
					FileUtils.deleteDirectory(removedDir);
				}
			}
				/*
				PrintWriter pw = response.getWriter();
				pw.print("<script>" 
						+ " alert('게시글이 삭제되었습니다');"
						+ " location.href='" + request.getContextPath() + "/board/listArticles.do';"
						+ " </script>");*/
			response.sendRedirect(request.getContextPath() + "/board/listArticles.do?" + "&delItem=true");
			
			return;
		} else if(path == null || path.equals("/listArticles2.do")) {
			// 게시판 목록 보여주기
//				request.setAttribute("articlesList", boardService.listArticles()) ;   // 동작가능
				articlesList = boardService.listArticles();
				request.setAttribute("articlesList", articlesList);
				nextPage = "/board/listArticles2.jsp";
			
			}

		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}

	private void upload(HttpServletRequest request, HttpServletResponse response, Map<String, String> articleMap) 
			throws ServletException, IOException {
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try {
			
			List<FileItem> items = upload.parseRequest(request);
			
			for(int i = 0; i < items.size(); i++) {
				FileItem fileItem = items.get(i);
				
				if(fileItem.isFormField()) {
					articleMap.put(fileItem.getFieldName(), fileItem.getString("utf-8"));
					System.out.println(fileItem.getFieldName() + ">>\t" + fileItem.getString("utf-8"));
				} else {
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");
					if(fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						String fileName = fileItem.getName().substring(idx + 1);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
						
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
