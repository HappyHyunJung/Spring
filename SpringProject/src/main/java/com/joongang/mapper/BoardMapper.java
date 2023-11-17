package com.joongang.mapper;

import java.util.List;

import com.joongang.domain.BoardVO;

public interface BoardMapper {
	
	public void insert(BoardVO vo);
	public List<BoardVO> getList();
	public BoardVO read(Long bno);
	public Integer update(BoardVO vo);
}
