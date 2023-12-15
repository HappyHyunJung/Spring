package com.joongang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.AuthVO;
import com.joongang.domain.BookVO;
import com.joongang.domain.MemberVO;
import com.joongang.service.AdminService;
import com.joongang.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/admin/*")
@Log4j2
public class AdminController {
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_ = @Autowired)
	private AdminService bookService;
	
	@PostMapping("/header")
	public String adminSubmit (MemberVO vo, HttpSession session, RedirectAttributes attr) {
		try {
			AuthVO authVO = memberService.authenticate(vo);
			session.setAttribute("auth", authVO);
			String userURI = (String)session.getAttribute("userURI");
			if (userURI != null) {
				session.removeAttribute("userURI");
				return "redirect:"+userURI;
			}
			return "/admin/header";
		} catch (Exception e) {
			attr.addFlashAttribute("error", e.getMessage());
			attr.addFlashAttribute("memberVO", vo);
			return "redirect:/member/login";
		}
	}
	
	// 상품등록 페이지로 이동
	@GetMapping("/bookEnroll")
	public String Enroll() {
		return "/admin/bookEnroll";
	}
	
	// 상품 등록 수행하면 상품관리 페이지/admin/bookManage.jsp로 이동
	@PostMapping("/bookEnroll")
	public String bookEnroll(BookVO book, RedirectAttributes rttr) {
		bookService.bookEnroll(book);
		rttr.addFlashAttribute("enroll_result", book.getBookName());
		return "redirect:/admin/bookManage";
	}
	
	@RequestMapping(value = "bookManage", method = RequestMethod.GET)
	public void bookManage(Model model) throws Exception {
		log.info("상품 관리 페이지 접속");
		
		
	}
}
