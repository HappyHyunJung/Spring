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
	// jsp를 리턴하므로 반환타입 String
	@GetMapping("/signup") 
	public String signupForm() {
		//화면에 회원가입페이지 가져오기
		return "/member/signupForm";
	}
	// 회원가입 버튼 클릭하면 form에 입력된 데이터를 가져온다
	@PostMapping("/signup")
	public String signupSubmit (MemberVO vo, HttpSession session, RedirectAttributes attr) {
		// 암호화 되기 전 비밀번호를 따로 저장해야 한다  
		// 따로 저장하지 않으면 authenticate() 매개변수 vo의 비밀번호가 암호된 비밀번호가 들어가서 오류가 된다 
		String rawpw = vo.getUserpw();
		log.info("$$$ my rawpw is " + rawpw);
		memberService.signup(vo);
		log.info("$$$ my encodedpw is " + vo.getUserpw());
		// 회원가입시 로그인 되기
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
			// 로그인 한 사람의 정보가 session에 저장 (키값 = auth)
			session.setAttribute("auth", authVO);
			// 필터 기능
			// object 형으로 리턴되므로 형변환해준다
			String userURI = (String)session.getAttribute("userURI");   // 필터에서 userURI를 받는다
			if (userURI != null) {
				// 값이 저장되면 로그인 된 상태이므로
				// 기존의 작업 삭제
				session.removeAttribute("userURI");

				return "redirect:"+userURI;
			} 
			return "redirect:/";
		} catch (Exception e) {
			// 입력한 id, pw가 없거나 안 맞으면
			// (memberService -> try/catch -> exception 예외 메시지 출력)
			attr.addFlashAttribute("error", e.getMessage());
			attr.addFlashAttribute("memberVO", vo);
			return "redirect:/member/login";
		}
	}
	// 로그아웃 - 세션 삭제 & 홈화면으로 이동 & 메시지 출력
	@GetMapping("/logout") 
	public String logout(HttpSession session, RedirectAttributes attr) {
		
		session.removeAttribute("auth");
		attr.addFlashAttribute("msg", "logout");
		return "redirect:/";
	}
}

