package com.joongang.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.AuthVO;
import com.joongang.domain.MemberVO;
import com.joongang.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/member/*")
@Log4j2
public class MemberController {
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@GetMapping("/signup") 
	public String signupForm() {
		return "/member/signupForm";
	}
	
	@PostMapping("/signup")
	public String signupSubmit (MemberVO vo, HttpSession session, RedirectAttributes attr) {
		// 암호화 되기 전 비밀번호를 따로 저장해야 한다  
		// 따로 저장하지 않으면 authenticate() 매개변수 vo의 비밀번호가 암호된 비밀번호가 들어가서 오류가 된다 
		String rawpw = vo.getUserpw();
		log.info("$$$ my rawpw is " + rawpw);
		memberService.signup(vo);
		log.info("$$$ my encodedpw is " + vo.getUserpw());
		
		try {
			vo.setUserpw(rawpw);
			AuthVO authVO = memberService.authenticate(vo);
			session.setAttribute("auth", authVO);

		} catch (Exception e) {
			
		}
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	@PostMapping("/login")
	public String loginSubmit (MemberVO vo, HttpSession session, RedirectAttributes attr) {

		try {
			AuthVO authVO = memberService.authenticate(vo);
			// session에 authVO를 추가한다 ???
			session.setAttribute("auth", authVO);
			String userURI = (String)session.getAttribute("userURI");   // 필터에서 userURI를 받는다
			if (userURI != null) {
				session.removeAttribute("userURI");

				return "redirect:"+userURI;
			} 
			return "redirect:/";
		} catch (Exception e) {
			attr.addFlashAttribute("error", e.getMessage());
			attr.addFlashAttribute("memberVO", vo);
			return "redirect:/member/login";
		}
	}
	
	@GetMapping("/logout") 
	public String logout(HttpSession session, RedirectAttributes attr) {
		
		session.removeAttribute("auth");
		attr.addFlashAttribute("msg", "logout");
		return "redirect:/";
	}
}

