package com.spring.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.spring.calendar.vo.CalendarVo;

public class CalendarUtil {
	public static DateTimeFormatter format = DateTimeFormatter.ofPattern("YYYY-MM");
	public static String path = CalendarUtil.class.getResource("").getPath();

	private static Map<Integer, CellStyle> calendarStyle(XSSFWorkbook wb) {
		Map<Integer, CellStyle> calendarForm = new HashMap<>();
		String filePath = "D:\\coding\\worktraining";
		String fileNm = "달력폼.xlsx";
		
		try (FileInputStream file = new FileInputStream(new File(filePath, fileNm))){

            // 엑셀 파일로 Workbook instance를 생성한다.
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            
            // workbook의 첫번째 sheet를 가저온다.
            XSSFSheet sheet = workbook.getSheetAt(0);
            
            int cnt = 0;
            // 모든 행(row)들을 조회한다.
            for (Row row : sheet) {
                // 각각의 행에 존재하는 모든 열(cell)을 순회한다.
                Iterator<Cell> cellIterator = row.cellIterator();

                while (cellIterator.hasNext()) {
                	Cell cell = cellIterator.next();
                	CellStyle style =  wb.createCellStyle();
                	style.cloneStyleFrom(cell.getCellStyle());
                    calendarForm.put(cnt++, style);
                }
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        }
		return calendarForm;
	}
	
	public static File writeCalendar(CalendarVo calendarVo) {
		LocalDate calendarDate = LocalDate.of(Integer.parseInt(calendarVo.getYear())
												,Integer.parseInt(calendarVo.getMonth())
												,1);
		File file = new File(path + calendarDate.format(format) +"_calendar.xlsx");
		
//		if(file.exists())
//			return file;
		
		int day = calendarDate.getDayOfWeek().getValue();
		int lastDay = calendarDate.lengthOfMonth();
		List<String> dayOfWeek = Arrays.asList("월", "화", "수", "목", "금", "토", "일");
		
		// 빈 Workbook 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        Map<Integer, CellStyle> styleList = calendarStyle(workbook);
        
        CellStyle satStyle = workbook.createCellStyle();
        satStyle.cloneStyleFrom(styleList.get(2));
        Font satFont = workbook.createFont();
        satFont.setColor(IndexedColors.GREEN.getIndex());
        satStyle.setFont(satFont);
        
        CellStyle sunStyle = workbook.createCellStyle();
        sunStyle.cloneStyleFrom(styleList.get(2));
        Font sunFont = workbook.createFont();
        sunFont.setColor(IndexedColors.RED.getIndex());
        sunStyle.setFont(sunFont);
        
        // 빈 Sheet를 생성
        XSSFSheet sheet = workbook.createSheet(calendarVo.getYear() + "-" + calendarVo.getMonth() + "달력");
        
        // 달력 헤더 작성
        // 행 지정
        XSSFRow row = sheet.createRow(0);
        
        // 열 지정
        Cell cell = row.createCell(1);
        
        // 지정한 행열위치에 데이터 삽입
        cell.setCellValue(calendarVo.getYear() + "년");
        
        cell = row.createCell(2);
        cell.setCellValue(calendarVo.getMonth() + "월");
        
        // 달력 제작
        // 요일 출력
        row = sheet.createRow(1);
        
        for(int i = 0; i < 7; i++) {
        	cell = row.createCell(i*3+2);
        	cell.setCellValue(dayOfWeek.get(i));
        }
        // 달력 출력
        int date = 1;
        int dayCheck = 1;
        int maxRow = (lastDay + day - 1) % 7 > 0 ? ((lastDay + day - 1) / 7) + 1 : (lastDay + day - 1) / 7;
         
        for(int j = 0; j < maxRow; j++) {
        	row = sheet.createRow(j * 4 + 2);
        	for(int i = 1; i < 8; i++) {
        		cell = row.createCell((i-1)*3);
        		cell.setCellStyle(styleList.get(0));
        		
        		cell = row.createCell((i-1)*3+1);
        		cell.setCellStyle(styleList.get(1));
        		
        		cell = row.createCell((i-1)*3+2);
        		cell.setCellStyle(styleList.get(2));
        		
        		if(dayCheck++ < day) continue;
        		
    			if(i > 5) cell.setCellStyle(i == 6 ? satStyle : sunStyle);

    			if(date <= lastDay) cell.setCellValue(date++);
        	}
        	
        	row = sheet.createRow(j * 4 + 3);
        	for(int i = 1; i < 8; i++) {
        		cell = row.createCell((i-1)*3);
        		cell.setCellStyle(styleList.get(3));
        		
        		cell = row.createCell((i-1)*3+2);
        		cell.setCellStyle(styleList.get(4));
        	}
        	
        	row = sheet.createRow(j * 4 + 4);
        	for(int i = 1; i < 8; i++) {
        		cell = row.createCell((i-1)*3);
        		cell.setCellStyle(styleList.get(5));
        		
        		cell = row.createCell((i-1)*3+2);
        		cell.setCellStyle(styleList.get(6));
        	}
        	
        	row = sheet.createRow(j * 4 + 5);
        	for(int i = 1; i < 8; i++) {
        		cell = row.createCell((i-1)*3);
        		cell.setCellStyle(styleList.get(7));
        		
        		cell = row.createCell((i-1)*3+1);
        		cell.setCellStyle(styleList.get(8));
        		
        		cell = row.createCell((i-1)*3+2);
        		cell.setCellStyle(styleList.get(9));
        	}
        	
        }
    	
        // 엑셀파일로 저장
        try {
			workbook.write(new FileOutputStream(file));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        System.out.println(file);
        return file;
	}
}
