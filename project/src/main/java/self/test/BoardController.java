package self.test;

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

import oracle.jdbc.oracore.OracleTypeSINT32;

/**
 * Servlet implementation class BoardContoller
 */
//@WebServlet({"/board/listArticles.do", "/board/articleForm.do" ,
//	"/board/addArticle.do", "/board/viewArticle.do", "/board/modArticle.do"})
public class BoardController extends HttpServlet {
	private BoardService boardService;
	private static final String ARTICLE_IMAGE_REPO = "D:\\JAVA\\eclipse-workspace\\FileUpload";
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
			Map<String, String> articleMap = new HashMap<String, String>();
			int articleNO = 0;
			upload(request, response, articleMap);
			System.out.println("파일업로드 완료");
			
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			
			articleVO.setParentNO(0);
			articleVO.setId("kim");
			articleVO.setTitle(title);
			articleVO.setContent(content);
			articleVO.setImageFileName(imageFileName);
			
			articleNO = boardService.addArticle(articleVO);
			if(imageFileName != null && imageFileName.length() != 0) {
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();
				FileUtils.moveToDirectory(srcFile, destDir, true);
			}
			
			response.sendRedirect(request.getContextPath() + "/board/listArticles.do?addItem=true");
			return;
			
		} else if(path.equals("/viewArticle.do")) {
			String articleNO = request.getParameter("articleNO");
			articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
			request.setAttribute("article", articleVO);
			nextPage = "/board/viewArticle.jsp";
			
		} else if (path.equals("/modArticle.do")) {
			Map<String, String> articleMap = new HashMap<String, String>();
			upload(request, response, articleMap);
			System.out.println("파일업로드 완료");
			
			int articleNO = Integer.parseInt(articleMap.get("articleNO"));
			articleVO.setArticleNO(articleNO);
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			
			articleVO.setParentNO(0);
			articleVO.setId("lee");
			articleVO.setTitle(title);
			articleVO.setContent(content);
			articleVO.setImageFileName(imageFileName);
			boardService.modArticle(articleVO);
			
			//이미지파일 옮기기
			if(imageFileName != null && imageFileName.length() != 0) {
				String originalFileName = articleMap.get("originalFileName");
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();
				FileUtils.moveToDirectory(srcFile, destDir, true);
				File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + originalFileName);
				oldFile.delete();
			}
			
			// 자바
			PrintWriter pw = response.getWriter();
			pw.print("<script>"
					+ " alert('수정완료');"
					+ " location.href='" + request.getContextPath() + "/board/viewArticle.do?articleNO="
					+ articleNO + "';"
					+ "</script>");
			return;
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
