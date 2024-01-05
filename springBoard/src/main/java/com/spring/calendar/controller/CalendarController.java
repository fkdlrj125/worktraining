package com.spring.calendar.controller;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.calendar.service.CalendarService;
import com.spring.calendar.vo.CalendarVo;
import com.spring.common.CalendarUtil;

@Controller
public class CalendarController {
	
	@Autowired
	CalendarService calendarService;
	
	@RequestMapping(value = "/download/calendar", method=RequestMethod.GET)
	public void CalendarDownload(CalendarVo calendarVo, HttpServletResponse response) throws Exception {
		File file = CalendarUtil.writeCalendar(calendarVo);
		calendarService.downloadCalendar(file, response);
	}
}