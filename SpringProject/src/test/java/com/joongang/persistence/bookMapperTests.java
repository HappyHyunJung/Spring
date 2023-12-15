package com.joongang.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.BookVO;
import com.joongang.mapper.AdminMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class bookMapperTests {
	
	@Setter (onMethod_ = @Autowired)
	private AdminMapper bookMapper;
	
	@Test
	public void testBookenroll() {
		
		BookVO book = new BookVO();
		book.setBookName("mapper Test");
		book.setPubleYear("2021");
		book.setPublisher("출판사**");
		book.setCateCode("aaa");
		book.setBookPrice(20000);
		book.setBookDiscount(0.1);
		book.setBookIntro("Mapper TEST");
		book.setBookContents("book Mapper 테스트입니다");
		
		bookMapper.bookEnroll(book);
	}
}
