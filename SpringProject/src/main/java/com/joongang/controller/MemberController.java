package com.joongang.controller;

import javax.servlet.http.HttpSession;

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

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@GetMapping("/signup") 
	public String signupForm() {
		return "/member/signupForm";
	}
	
	@PostMapping("/signup")
	public String signupSubmit (MemberVO vo) {
		memberService.signup(vo);
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	@PostMapping("/login")
	public String loginSubmit (MemberVO vo, HttpSession session, RedirectAttributes attr) {
		AuthVO authVO;
		try {
			authVO = memberService.authenticate(vo);
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

