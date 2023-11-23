package com.spring.user.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.HomeController;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/user/userJoin.do", method=RequestMethod.GET)
	public String userJoin(Locale locale) throws Exception {
		return "user/userJoin";
	}
	
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.GET)
	public String userLogin(Locale locale) throws Exception {
		return "user/userLogin";
	}
}
