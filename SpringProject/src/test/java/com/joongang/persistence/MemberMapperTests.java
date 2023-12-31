package com.joongang.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.MemberVO;
import com.joongang.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class MemberMapperTests {
	
	@Setter (onMethod_ = @Autowired)
	private MemberMapper map;
	
//	@Test
	public void testInsert() {
		MemberVO vo = new MemberVO();
		vo.setUserid("sky100");
		vo.setUsername("하늘11");
		vo.setUserpw("12311");
		vo.setLocation("제주11");
		vo.setGender("남11");
		map.insert(vo);
	}
}
