package com.joongang.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.joongang.domain.Criteria;
import com.joongang.domain.ReplyPageDTO;
import com.joongang.domain.ReplyVO;
import com.joongang.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequestMapping("/replies/*")
@AllArgsConstructor
@Log4j2
public class ReplyController {
	private ReplyService replyService;
	// produces = {**} -> ** 해당 형태로 데이터를 보낸다
	@GetMapping(value = "/pages/{bno}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno) {
		// 리스트 형태로 가져온다 (json 형변환 알아서 해준다)
		List<ReplyVO> list = replyService.getList(bno);
		log.info("list : " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// consumes -> json 형으로 데이터가 들어오는 것을 처리한다
	// produces (최종 결과물)String형으로 보내겠다
	@PostMapping(value = "/new", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
		log.info("ReplyVO: " + vo);
		int registerCount = replyService.register(vo);
		log.info("Reply REGISTER COUNT : " + registerCount);
		return registerCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{rno}", 
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyVO> get (@PathVariable("rno") Long rno) {
		log.info("get : " + rno);
		return new ResponseEntity<>(replyService.get(rno), HttpStatus.OK);
	}
	// 댓글 수정
	@PatchMapping(value = "/{rno}", consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify (@RequestBody ReplyVO vo ,
			@PathVariable("rno") Long rno) {
		log.info("rno  : " + rno);
		log.info("modify  : " + vo);
		return replyService.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	// 댓글 삭제
	@DeleteMapping(value = "/{rno}" ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("remove : " + rno);
		return replyService.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyPageDTO> getListWithPaging(
			@PathVariable("bno") Long bno, @PathVariable("page") int page) {
		Criteria criteria = new Criteria(page, 10);
		ReplyPageDTO dto = replyService.getListWithPaging(criteria, bno);
		log.info("list : " + dto.getList());
		return new ResponseEntity<>(dto, HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/cnt",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getReplyCnt(
			@RequestParam(value = "list[]") List<Long> list) {
		JsonObject jobj = new JsonObject();
		for(Long bno : list) {
			jobj.addProperty(String.valueOf(bno), replyService.getReplyCnt(bno));
		}
		return new ResponseEntity<>(jobj.toString(), HttpStatus.OK);
	}
}
