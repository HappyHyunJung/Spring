package com.joongang.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
}

