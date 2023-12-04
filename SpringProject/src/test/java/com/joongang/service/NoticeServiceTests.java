package com.joongang.service;

import static org.hamcrest.CoreMatchers.not;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class NoticeServiceTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;
	
	//@Test
	public void testRegister() {
		NoticeVO vo = new NoticeVO();
		vo.setNotice("NoticeService 테스트입니다");
		vo.setNoticer("tester");
		noticeService.register(vo);
	}
	
	@Test
	public void testGetList() {
		noticeService.getList();
	}
}
