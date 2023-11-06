package com.joongang.service;

import java.util.List;

import com.joongang.dao.BoardDAO;
import com.joongang.domain.ArticleVO;

public class BoardService {
	private BoardDAO boardDAO;
	
	public BoardService() {
		
		boardDAO = new BoardDAO();
	}
	
	public List<ArticleVO> listArticles() {
		
		return boardDAO.selectAllArticles();
	}

	public int addArticle(ArticleVO vo) {
		return boardDAO.addArticle(vo);
	}

	public ArticleVO viewArticle(int articleNO) {
		// TODO Auto-generated method stub
		return boardDAO.viewArticle(articleNO);
	}

	public void modArticle(ArticleVO articleVO) {
		boardDAO.modArticle(articleVO);
		
	}

	public List<Integer> removeArticle(int articleNO) {
		List<Integer> articleNOList = boardDAO.selectRemovedArticles(articleNO);
		boardDAO.removeArticle(articleNO);
		return articleNOList;  
		// 첨부파일이 저장된 폴더도 삭제하기 위해 articleNOList 반환
	}
	
}
