package com.joongang.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.config.RootConfig;
import com.joongang.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j2
public class TimeMapperTests {
	@Setter (onMethod_ = @Autowired)
	private TimeMapper timeMapper;
	
//	@Test
	public void testGetTime() {
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime());
	}

	@Test
	public void testGetTime2() {
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime());
	}
}
