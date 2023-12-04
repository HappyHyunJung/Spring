package com.joongang.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.joongang.domain.NoticeVO;
import com.joongang.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequestMapping("/notices/*")
@AllArgsConstructor
@Log4j2
public class NoticeController {
	private NoticeService noticeService;
	
	@GetMapping(value = "/pages",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<NoticeVO>> getList() {
		List<NoticeVO> list = noticeService.getList();
		log.info("list : " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}

