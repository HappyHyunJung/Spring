package com.joongang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongang.domain.NoticeVO;
import com.joongang.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class NoticeService {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	
	public int register(NoticeVO vo) {
		return noticeMapper.insert(vo);
	}
	
	public List<NoticeVO> getList() {
		return noticeMapper.getList();
	}

	public NoticeVO get(Long rno) {
		return noticeMapper.read(rno);
	}
}
