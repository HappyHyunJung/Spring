package com.joongang.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.BoardVO;
import com.joongang.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class BoardMapperTests {

		@Setter (onMethod_ = @Autowired) 
		private BoardMapper boardMapper;
		
//		@Test
		public void testBoardInsert() {
			BoardVO bvo = new BoardVO();
			bvo.setTitle("오늘은");
			bvo.setContent("오늘은 평범한 일상이다");
			bvo.setWriter("최현정");
			boardMapper.insert(bvo);
		}
}
