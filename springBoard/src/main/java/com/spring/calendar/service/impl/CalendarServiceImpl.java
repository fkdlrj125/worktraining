package com.spring.calendar.service.impl;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.spring.calendar.service.CalendarService;
import com.spring.calendar.vo.CalendarVo;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Override
	public void downloadCalendar(File file, HttpServletResponse response) throws Exception {
		byte[] files = Files.readAllBytes(file.toPath());
		response.setContentType("application/octet-stream");
        response.setContentLength((int)file.length());
        response.setHeader("Content-disposition", "attachment;filename=\"" + URLEncoder.encode(file.getName(), StandardCharsets.UTF_8) + "\"");
        response.setHeader("Content-Transfer-Encoding","binary");
        
        response.getOutputStream().write(files);
        response.getOutputStream().flush();
        response.getOutputStream().close();
	}
	
}
