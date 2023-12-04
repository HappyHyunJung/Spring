package com.joongang.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.ReplyVO;
import com.joongang.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,
		com.joongang.config.SecurityConfig.class})
@Log4j2
public class ReplyMapperTests {
	
	@Setter (onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
//	@Test
	public void testReplyInsert() {
		long bno = 28l;
		for(int i = 0; i < 10; i++) {
			ReplyVO replyVO = new ReplyVO();
			replyVO.setBno(bno);
			replyVO.setReply("test " + i);
			replyVO.setReplyer("tester " + i);
			replyMapper.insert(replyVO);
		}
	}
	
//	@Test
	public void testReplyRead() {
		long targetRno = 12l;
		ReplyVO replyVO = replyMapper.read(targetRno);
		log.info(replyVO);
	}
	
//	@Test
	public void testUpdate() {
		long targetRno = 12l;
		ReplyVO vo = replyMapper.read(targetRno);
		vo.setReply("Update Reply ");
		int count = replyMapper.update(vo);
		log.info("UPDATE COUNT : " + count);
	}
	
	//@Test
	public void testGetList() {
		long targetBno = 28l;
		List<ReplyVO> replies = replyMapper.getList(targetBno);
		for (ReplyVO vo : replies) {
			log.info("##" + vo);
		}
	}
	
//	@Test 
	public void testDelete() {
		long targetRno = 10l;
		int count = 0;
		count += replyMapper.delete(targetRno);
		log.info("DELETE COUNT : " + count);
	}
}
