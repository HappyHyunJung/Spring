package com.joongang.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class})
@Log4j2
public class BoardServiceTests {
	@Setter (onMethod_ = @Autowired)
	private BoardService boardService;
	
//	@Test
	public void testregister() {
		BoardVO boardvo = new BoardVO();
		boardvo.setTitle("serviceTest");
		boardvo.setContent("TestTestTest");
		boardvo.setWriter("who??");
		boardService.register(boardvo);
	}
	
}
