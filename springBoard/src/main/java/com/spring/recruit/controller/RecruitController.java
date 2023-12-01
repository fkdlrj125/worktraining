package com.spring.recruit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RecruitController {
	
	@RequestMapping(value="/recruit/login", method = RequestMethod.GET)
	public String recruitLogin() {
		return "recruit/login";
	}
	
	@RequestMapping(value="/recruit/main", method = RequestMethod.GET)
	public String recruitMain() {
		return "recruit/main";
	}
}
