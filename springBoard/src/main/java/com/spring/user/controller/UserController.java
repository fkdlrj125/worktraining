package com.spring.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.common.CommonUtil;
import com.spring.common.vo.TypeVo;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/user/userJoin.do", method=RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception {
		List<TypeVo> typeList = userService.selectTypeList();
		
		System.out.println(typeList.get(0).getCodeId().getClass().getName());
		
		model.addAttribute("typeList", userService.selectTypeList());
		return "user/userJoin";
	}
	
	@RequestMapping(value="/user/userJoin.do", method=RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale, UserVo userVo) throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		Map<String, String> result = new HashMap<String, String>();
		
		result.put("success", userService.insertUser(userVo) > 0 ? "Y" : "N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg : " + callbackMsg);
		return callbackMsg;
	}
	
	@RequestMapping(value="/user/userIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String userIdCheck(String inputId) throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		Map<String, String> result = new HashMap<String, String>();
		
		result.put("success", userService.selectUserId(inputId).isEmpty() ? "Y" : "N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg : " + callbackMsg);
		return callbackMsg;
	}
 	
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.GET)
	public String userLogin(Locale locale) throws Exception {
		return "user/userLogin";
	}
	
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.POST)
	@ResponseBody
	public String userLoginAction(Locale locale, String loginId, String loginPw) throws Exception {
		UserVo userVo = new UserVo();
		CommonUtil commonUtil = new CommonUtil();
		Map<String, String> result = new HashMap<String, String>();
		String loginResult;
		
		userVo.setUserId(loginId);
		userVo.setUserPw(loginPw);
		
		loginResult = userService.loginUser(userVo);
		
		result.put("result",  loginResult);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg : " + callbackMsg);
		return callbackMsg;
	}
}
