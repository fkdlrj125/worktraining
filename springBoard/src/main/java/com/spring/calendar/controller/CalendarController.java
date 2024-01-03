package com.spring.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.calendar.service.CalendarService;
import com.spring.calendar.vo.CalendarVo;

@Controller
public class CalendarController {
	
	@Autowired
	CalendarService calendarService;
	
	@RequestMapping(value= "/recruit", method=RequestMethod.GET)
	public String test() throws Exception {
		return "board/boardList";
	}
	
	@RequestMapping(value = "/download/calendar", method=RequestMethod.POST)
	public void CalendarDownload(CalendarVo calendarVo) throws Exception {
		System.out.println(calendarVo.getYear());
		System.out.println(calendarVo.getMonth());
		calendarService.downloadCalendar(calendarVo);
	}
}
