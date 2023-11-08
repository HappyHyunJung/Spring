package com.joongang.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.SurvayData;

@Controller
public class SurvayController {
	
	private static final Logger logger = LoggerFactory.getLogger(SurvayController.class);
	
	@RequestMapping(value = "/survay", method = RequestMethod.GET)  
	public String home(Locale locale , Model model) {
		return "main"; 
	}
	
	@RequestMapping(value="/survey/part1/", method=RequestMethod.GET)
	public String part1() 
	{
		return "survay/part1";
	}
	
	@RequestMapping(value = "/survay/part2" )
	public String part2() {
		return "redirect:/";
	}
	
}
