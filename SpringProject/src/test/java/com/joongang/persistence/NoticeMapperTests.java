package com.joongang.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.NoticeVO;
import com.joongang.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class NoticeMapperTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	
	//@Test
	public void testInsert() {
		NoticeVO vo = new NoticeVO();
		vo.setNoticer("tester");
		vo.setNotice("NoticeMapper3 테스트입니다.");
		noticeMapper.insert(vo);
	}
	
	@Test
	public void testGetList() {
		List<NoticeVO> notices = noticeMapper.getList();
		//log.info(notices.size());
		for(NoticeVO vo : notices) {
			log.info("##" + vo);
		}
	}
}
