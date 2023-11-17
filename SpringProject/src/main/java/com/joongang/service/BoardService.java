package com.joongang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongang.domain.BoardVO;
import com.joongang.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardService {

		@Setter(onMethod_ = @Autowired)
		private BoardMapper boardMapper;
		
		public void register(BoardVO vo) {
			boardMapper.insert(vo);
		}
		
		public List<BoardVO> getList() {
			return boardMapper.getList();
		} 
		
		public BoardVO get(Long bno) {
			return boardMapper.read(bno);
		}

		/*
		 * public boolean modify(BoardVO vo) { boolean chk = false; if
		 * (boardMapper.update(vo) != null) { chk = true; }
		 * 
		 * return chk;
		 * 
		 * }
		 */
}
