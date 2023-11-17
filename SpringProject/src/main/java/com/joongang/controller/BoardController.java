package com.joongang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.BoardVO;
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
		
		@PostMapping("/register")
		public String register(BoardVO vo, RedirectAttributes attr) {
			boardService.register(vo);
			attr.addFlashAttribute("result", vo.getBno());
			return "redirect:/board/list";
		}
		
		@GetMapping("/list")
		public String list(Model model) {
			List<BoardVO> ListBoardVO = boardService.getList();
			model.addAttribute("ListBoardVO", ListBoardVO);
			log.info(ListBoardVO);
			return "/board/list";
		}
		
		@GetMapping("/get")
		public String get(Model model, @RequestParam("bno") Long bno) {
			BoardVO vo = boardService.get(bno);
			model.addAttribute("board", vo);
			return "/board/get";
		}
		
		@GetMapping("/modify")
		public String modify(@RequestParam("bno")Long bno, Model model) {
			model.addAttribute("board", boardService.get(bno));
			return "/board/modify";
		}
		
		/*
		 * @PostMapping("/modify") public String modifyDo(BoardVO vo, RedirectAttributes
		 * attr) { 
		 * if(boardService.modify(vo)) { attr.addFlashAttribute("modified", vo);
		 * return "redirect:/board/list"; 
		 * }
		 * 
		 * return "/board/modify"; }
		 */
}
