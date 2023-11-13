package com.joongang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.Result;

@Controller
@RequestMapping("/game/*")
public class GameController {
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String game() {
		return "game";
	}
	
	@GetMapping("/score1")
	public String score1(/*@ModelAttribute("data")*/ Result result ) {
		
		return "game";
	}

	@GetMapping("/score2")
	public String score2(@ModelAttribute("team") String team, @ModelAttribute("score") int score, Model model ) {
		model.addAttribute("msg","wonderful game");
		return "game";
	}
}
