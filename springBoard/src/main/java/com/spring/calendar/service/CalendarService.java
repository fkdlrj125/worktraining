package com.spring.calendar.service;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

public interface CalendarService {
	public void downloadCalendar(File file, HttpServletResponse response) throws Exception;
}
