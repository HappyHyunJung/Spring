package com.joongang.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.joongang.domain.ArticleVO;

public class BoardDAO {
	private Connection con;
	private PreparedStatement pstmt;
	public DataSource dataFactory;
	
	public BoardDAO() {

		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List selectAllArticles() {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		
		try {
			con = dataFactory.getConnection();
			System.out.println("Connection 연결 성공");
			String query = "select LEVEL, articleNO, parentNO, title, content, id, writedate, imagefilename ";
				query += "FROM t_board ";
				query += "START WITH parentNO=0 CONNECT BY PRIOR articleNO = parentNO ";
				query += "ORDER SIBLINGS BY articleno DESC";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int level = rs.getInt("level");
				int articleNO = rs.getInt("articleNO");
				int parentNO = rs.getInt("parentNO");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String id = rs.getString("id");
				Date writeDate = rs.getDate("writeDate");
				String imageFileName = rs.getString("imageFileName");
				/*
				ArticleVO articlevo = new ArticleVO();
				articlevo.setLevel(level);
				articlevo.setArticleNO(articleNO);
				articlevo.setParentNO(parentNO);
				articlevo.setTitle(title);
				articlevo.setContent(content);
				articlevo.setId(id);
				articlevo.setWriteDate(writeDate);
				articlevo.setImageFileName(imageFileName);
				*/
				ArticleVO artVO = new ArticleVO(level, articleNO, parentNO, title, 
						content, imageFileName, id, writeDate);
//				list.add(articlevo);
				list.add(artVO);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	private int getNewArticleNO() {
		int retValue = 0;
		try {
			con = dataFactory.getConnection();
			String query = "select max(articleNO) from t_board ";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery(query);
			
			if(rs.next()) {
				retValue = (rs.getInt(1) + 1);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return retValue;
	}
	
	public int addArticle(ArticleVO vo) {
		int articleNo = getNewArticleNO();  // this.getNewArticleNO();
		System.out.println(articleNo);
		try {
			con = dataFactory.getConnection();
			int parentNO = vo.getParentNO();
			String title = vo.getTitle();
			String content = vo.getContent();
			String id = vo.getId();
			String imageFileName = vo.getImageFileName();
			String query = "insert into t_board (articleNO, parentNO, title, content, imageFileName, id) "
					+ "values (?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,  articleNo);
			pstmt.setInt(2,  parentNO);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, imageFileName);
			pstmt.setString(6, id);
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return articleNo;
	}

	public ArticleVO viewArticle(int articleNO) {
		ArticleVO vo = new ArticleVO();
		// 게시판 글 상세기능 구현
		// imageFileName 널인지 체크
		try {
			con = dataFactory.getConnection();
			System.out.println("Connection 연결 성공");
  			String query = "select articleNo, parentNO, title, content, NVL(imageFileName, 'null') ";
  				query += "as imageFileName, id, writedate ";
  				query += "from t_board ";
  				query += "where articleNO = ?";
  			System.out.println(query);
  			
  			pstmt = con.prepareStatement(query);
  			pstmt.setInt(1, articleNO);
  			ResultSet rs = pstmt.executeQuery();
  			if (rs.next()) {
  				int _articleNO = rs.getInt("articleNO");
  				int parentNO = rs.getInt("parentNO");
  				String title = rs.getString("title");
  				String content = rs.getString("content");
  				String id = rs.getString("id");
  				Date writedate = rs.getDate("writedate");
  				String imageFileName = rs.getString("imageFileName");
  				
  				vo.setArticleNO(_articleNO);
				vo.setParentNO(parentNO);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setId(id);
				
				if(imageFileName.equals("null")) {
					imageFileName = null;
				}
				vo.setImageFileName(imageFileName);
				vo.setWriteDate(writedate);
				
  			}
  			rs.close();
  			pstmt.close();
  			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public void modArticle(ArticleVO vo) {

		try {
			con = dataFactory.getConnection();
			int articleNo = vo.getArticleNO();  
			String title = vo.getTitle();
			String content = vo.getContent();
			String imageFileName = vo.getImageFileName();
			
			String query = "update t_board set title=?, content=?";
			if(imageFileName != null && imageFileName.length() != 0) {
				query += ", imageFileName=? ";
			}
				query += "where articleNO=? ";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,  title);
			pstmt.setString(2, content);
			if(imageFileName != null && imageFileName.length() != 0) {
				pstmt.setString(3, imageFileName);
				pstmt.setInt(4, articleNo);
			} else {
				pstmt.setInt(3, articleNo);
			}
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
