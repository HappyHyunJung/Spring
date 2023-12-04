package com.joongang.mapper;

import java.util.List;

import com.joongang.domain.NoticeVO;

public interface NoticeMapper {
	public int insert(NoticeVO noticeVO);
	public NoticeVO read(Long rno);
//	수정 , 삭제는 관리자만 할 수 있다 -> 나중에 관리자 계정 만들면 ReplyMapper 참고
	public List<NoticeVO> getList();
}
