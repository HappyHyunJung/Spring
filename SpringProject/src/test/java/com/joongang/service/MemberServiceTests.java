package com.joongang.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.config.RootConfig;
import com.joongang.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class MemberServiceTests {
	
	@Setter (onMethod_ = @Autowired)
	private MemberService mapService;
	
//	@Test
	public void testSignup() {
		MemberVO vo = new MemberVO();
		vo.setUserid("sky11");
		vo.setUsername("하늘11");
		vo.setUserpw("12311");
		vo.setLocation("제주11");
		vo.setGender("남11");
		mapService.signup(vo);
	}
}
