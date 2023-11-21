package com.joongang.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
	
	@GetMapping(value = "/pages/{bno}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno) {
		List<ReplyVO> list = replyService.getList(bno);
		log.info("list : " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
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
}
