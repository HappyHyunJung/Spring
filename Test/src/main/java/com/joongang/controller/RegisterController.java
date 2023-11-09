package com.joongang.controller;

import java.net.URLEncoder;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.RegisterRequest;
import com.joongang.service.MemberRegisterService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/register/*")
//@AllArgsConstructor
public class RegisterController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private MemberRegisterService memberRegisterService;
		
//	@Autowired
//	public RegisterController(MemberRegisterService memberRegisterService) {
//		this.memberRegisterService = memberRegisterService;
//	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/step1", method = RequestMethod.GET)  // value는 url 의미
	public String handleStep1(Locale locale , Model model) {
		
		return "register/step1";  
	}	
	
	@PostMapping("/step2")
	public String handleStep2(
			@RequestParam(value="agree", defaultValue="false") Boolean agree) {
		
		if (!agree) {  // 미체크시 step1으로 이동
			return "redirect:/register/step1"; // -> url : step 1, 내용 : step1 
			
//			return "/register/step1";  // -> url: step2  , 내용 : step1 
		}
		return "register/step2";
	}
	/*
	@RequestMapping(value = "/step3", method = RequestMethod.POST)
	public String handleStep3(
			@RequestParam(value="name") String name, @RequestParam(value="email") String email,
			@RequestParam(value="pwd") String pwd, @RequestParam(value="cfpwd") String cfpwd)
		
	{
		System.out.println(name + "\n" + email + "\n" + pwd + "\n" + cfpwd);
		memberRegisterService.regist(new RegisterRequest(email, name, pwd, cfpwd));
		StringBuffer buf = new StringBuffer();
		try {
			buf.append("email=");
			buf.append(URLEncoder.encode(email, "UTF-8"));
			buf.append("&");
			buf.append("name=");
			buf.append(URLEncoder.encode(name, "UTF-8"));
			buf.append("&");
			buf.append("pwd=");
			buf.append(pwd);
			buf.append("&");
			buf.append("cfpwd=");
			buf.append(cfpwd);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		return "redirect:/?" + buf.toString();
	}
	*/
	
	/* @ModelAttribute() 
	 * /register/step2.jsp 의 데이터를 RegisterRequest 타입 클래스에 저장
	*/
	@PostMapping(value = "/step3")
	public String handleStep3(@ModelAttribute("step2") RegisterRequest regi, RedirectAttributes attr)
	{
		System.out.println(regi.getEmail() + "\n" + regi.getName() + "\n" + regi.getPwd() + "\n");
		memberRegisterService.regist(regi);
		attr.addFlashAttribute("regi", regi);
		return "redirect:/";
	}

	public RegisterController() {
		this.memberRegisterService = new MemberRegisterService();
	}
}
