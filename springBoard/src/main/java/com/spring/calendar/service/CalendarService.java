package com.spring.calendar.service;

import com.spring.calendar.vo.CalendarVo;

public interface CalendarService {
	public void downloadCalendar(CalendarVo calendarVo) throws Exception;
}
