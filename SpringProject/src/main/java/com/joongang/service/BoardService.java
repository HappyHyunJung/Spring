package com.joongang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;
import com.joongang.mapper.BoardAttachMapper;
import com.joongang.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardService {

		@Setter(onMethod_ = @Autowired)
		private BoardMapper boardMapper;
		
		@Setter(onMethod_ = @Autowired)
		private BoardAttachMapper attachMapper;
		
		@Transactional
		public void register(BoardVO vo) {
			boardMapper.insert(vo);
			
			// list 형태로 BoardAttachVO를 받아오기 위해 getAttachList() 사용
			List<BoardAttachVO> list = vo.getAttachList();
			if (list == null || list.isEmpty()) {
				return; // 받아온 list가 null이면 호출된 함수로 반환
			}
			
			for(BoardAttachVO attach : list) {
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			}
		}
		
		public List<BoardVO> getList() {
			return boardMapper.getList();
		} 
		
		// 비교
		public List<BoardVO> getList(Criteria criteria) {
			return boardMapper.getListWithPaging(criteria);
		}
		
		public int getTotal(Criteria criteria) {
			return boardMapper.getTotalCount(criteria);
		}

		public BoardVO get(Long bno) {
			return boardMapper.read(bno);
		}

		@Transactional
		public boolean modify(BoardVO vo) {
			log.info("modify service");
			log.info("modify..." + vo);
			attachMapper.deleteAll(vo.getBno());
			boolean modifyResult = boardMapper.update(vo) == 1;
			List<BoardAttachVO> list = vo.getAttachList();
			if(modifyResult && list != null) {
				for(BoardAttachVO attachVO : list) {
					attachVO.setBno(vo.getBno());
					attachMapper.insert(attachVO);
				}
			}
			return modifyResult;
		}

		public boolean remove(Long bno) {
			return boardMapper.delete(bno) == 1;
		}

		public List<BoardAttachVO> getAttachList(Long bno) {
			log.info("get Attach list by bno " + bno);
			return attachMapper.findByBno(bno);
		}

		
}
