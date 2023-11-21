package com.joongang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongang.domain.ReplyVO;
import com.joongang.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	public int register(ReplyVO vo) {
		return replyMapper.insert(vo);
	}
	
	public ReplyVO get (Long rno) {
		return replyMapper.read(rno);
	}
	
	public int modify(ReplyVO vo) {
		return replyMapper.update(vo);
	}
	
	public int remove(Long rno) {
		return replyMapper.delete(rno);
	}
	
	public List<ReplyVO> getList(Long bno) {
		return replyMapper.getList(bno);
	}
}
