package com.joongang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.joongang.domain.MemberVO;
import com.joongang.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	public void signup (MemberVO vo) {
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		mapper.insert(vo);
	}
}
