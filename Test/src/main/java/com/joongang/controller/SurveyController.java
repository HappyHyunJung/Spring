package com.joongang.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.SurveyData;
import com.joongang.service.SurveyService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/survey/*")
public class SurveyController {
	private SurveyService surveyService;
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@Autowired
	public SurveyController(SurveyService surveyService) {
		this.surveyService = surveyService;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)  
	public String main() {
		log.info("Log4j2.......................");
		log.info("Welcome to survey main view");
		return "/survey/main"; 
	}
	
	@GetMapping("/part1")
	public String part1Form() {
		return "/survey/part1/part1Form";
	}

	@PostMapping("/part1" )
	public String part1Submit(@ModelAttribute SurveyData data, RedirectAttributes attr) {
		System.out.println(data.toString());
		attr.addFlashAttribute("data", data);
		return "redirect:/survey/";
	}

	@GetMapping("/part2")
	public String part2Form(Model model) {
		model.addAttribute("questions", surveyService.getSurveyQuestions());
		return "/survey/part2/part2Form";
	}
	
	@PostMapping("/part2" )
	public String part2Submit(@ModelAttribute SurveyData data, RedirectAttributes attr) {
		System.out.println(data.toString());
		attr.addFlashAttribute("data", data);
		return "redirect:/survey/";
	}
	
}
