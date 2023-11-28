package com.joongang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;
import com.joongang.domain.PageDTO;
import com.joongang.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board/*")
@Log4j2
public class BoardController {

		@Setter(onMethod_ = @Autowired)
		private BoardService boardService;
		
		@GetMapping("/register")
		public String registerForm() {
			return "/board/registerForm";
		}
		// 게시물 등록
		@PostMapping("/register")
		public String register(BoardVO vo, RedirectAttributes attr) {
			boardService.register(vo);
			attr.addFlashAttribute("result", vo.getBno());
			return "redirect:/board/list";
		}
		
		@GetMapping("/list")
		public String list (Criteria criteria, Model model) {
			List<BoardVO> list = boardService.getList(criteria);
			model.addAttribute("list", list);
			int total = boardService.getTotal(criteria);
			model.addAttribute("pageDTO", new PageDTO(criteria, total));
			log.info(list + "total: " + total + "  " + criteria.getListLink());
			return "/board/list";
		}
		
		@GetMapping("/get")
		public String get(Model model, @RequestParam("bno") Long bno, Criteria criteria) {
			BoardVO vo = boardService.get(bno);
			model.addAttribute("board", vo);
			return "/board/get";
		}
		
		@GetMapping("/modify")
		public String modify(@RequestParam("bno")Long bno, Criteria criteria, Model model) {
			model.addAttribute("board", boardService.get(bno));
			return "/board/modify";
		}
		
		@PostMapping("/modify") 
		public String modify(BoardVO vo, Criteria criteria, RedirectAttributes attr) { 
			if (boardService.modify(vo)) {
				attr.addFlashAttribute("result", "success");
			}
			log.info("modify Control");
			
			attr.addAttribute("pageNum", criteria.getPageNum());
			attr.addAttribute("amount", criteria.getAmount());
			return "redirect:/board/list";
		}
		
		@PostMapping("/remove")
		public String remove(@RequestParam("bno") Long bno, Criteria criteria, RedirectAttributes attr) {
			if (boardService.remove(bno)) {
				attr.addFlashAttribute("result", "success");
			}
			attr.addAttribute("pageNum", criteria.getPageNum());
			attr.addAttribute("amount", criteria.getAmount());
			return "redirect:/board/list";
		}
		
		@GetMapping(value = "/getAttachList/{bno}",
				produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public ResponseEntity<List<BoardAttachVO>> getAttachList (
				@PathVariable("bno") Long bno) {
			log.info("getAttachList" + bno);
			return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
		}
		
		
}
