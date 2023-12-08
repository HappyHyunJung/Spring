package com.joongang.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joongang.domain.NoticeVO;
import com.joongang.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/notices/*")
@AllArgsConstructor
@Log4j2
public class NoticeController {
	private NoticeService noticeService;
	
	@GetMapping("list")
	public String list(Model model) {
		List<NoticeVO> list = noticeService.getList();
		model.addAttribute("list", list);
		log.info("list : " + list);
		return "/notice/list";
	}
	
	@GetMapping(value = "/pages",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	@ResponseBody
	public ResponseEntity<List<NoticeVO>> getList() {
		List<NoticeVO> list = noticeService.getList();
		log.info("list : " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<NoticeVO> get (@PathVariable("rno") Long rno) {
		log.info("get : " + rno);
		return new ResponseEntity<>(noticeService.get(rno), HttpStatus.OK);
	}
}

