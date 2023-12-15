package com.joongang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongang.domain.BookVO;
import com.joongang.mapper.AdminMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class AdminService {
	@Setter(onMethod_ = @Autowired)
	private AdminMapper adminMapper;
	
	public void bookEnroll(BookVO book) {
		adminMapper.bookEnroll(book);
	}
}
