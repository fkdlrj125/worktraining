package com.spring.common;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import com.spring.travel.dto.CalculateDTO;

enum TravelExpend {
	W(0, 0),
	C(0, 0),
	B(1400, 200),
	S(1450, 200),
	T(3800, 5000);
	
	private int expend;
	private int addExpend;
	
	private TravelExpend(int expend, int addExpend) {
		this.expend = expend;
		this.addExpend = addExpend;
	}
	
	public int getExpend() {
		return expend;
	}
	
	public int getAddExpend() {
		return addExpend;
	}
}

public class TravelUtil {
	public static int CalculateExpend(CalculateDTO cal) {
		int resultExpend = 0;
		int defaultExpend = TravelExpend.valueOf(cal.getTs()).getExpend();
		int addExpend = TravelExpend.valueOf(cal.getTs()).getAddExpend();
		
		switch (cal.getTs()) {
		case "B": case"S":
			resultExpend += defaultExpend 
					+ addExpend
					* (Integer.parseInt(cal.getTst()) > 20 ? Integer.parseInt(cal.getTst()) / 20 : 0);
			break;
			
		case "T": 
			LocalDateTime travelTime = LocalDateTime.of(LocalDate.now(), LocalTime.parse(cal.getTlt()));
			LocalDateTime fourClock = LocalDateTime.of(LocalDate.now(), LocalTime.parse("04:00"));
			LocalDateTime twentyTwoClock = LocalDateTime.of(LocalDate.now(), LocalTime.parse("22:00"));
			LocalDateTime twentyFourClock = LocalDateTime.of(LocalDate.now().plusDays(1), LocalTime.parse("00:00"));
			
			resultExpend += defaultExpend 
					+ addExpend
					* (Integer.parseInt(cal.getTst()) > 9 ? Integer.parseInt(cal.getTst()) / 10 : 0);
			
			if(travelTime.isBefore(fourClock))
				travelTime = travelTime.plusDays(1);
			
			LocalDateTime totalTime = travelTime.plusMinutes(Integer.parseInt(cal.getTst()));
			
			// 04:00 탑승 22:00 이전 하차
			if(totalTime.isBefore(twentyTwoClock) && travelTime.isAfter(fourClock)) 
				break;
			
			// 24:00 이후 탑승
			if(travelTime.isAfter(twentyFourClock)) {
				resultExpend += resultExpend * (0.4);
				break;
			}
			
			// 22:00 이후 하차
			Duration duration = Duration.between(twentyFourClock, totalTime);
			
			// 24:00 이후 하차
			if(duration.toMinutes() > 0) resultExpend += addExpend
													* (0.4) * (duration.toMinutes() / 10);

			// 22:00 이후 승차
			if(travelTime.isAfter(twentyTwoClock)) {
				duration = Duration.between(travelTime, twentyFourClock);
				resultExpend += defaultExpend * (0.2)
						+ addExpend
						* (0.2) * (duration.toMinutes() / 10);
				return resultExpend;
			}
			
			duration = Duration.between(twentyTwoClock, totalTime.minusMinutes(duration.toMinutes()));
			resultExpend += addExpend
							* (0.2) * (duration.toMinutes() / 10);
			break;
		}
		
		return resultExpend;
	}
}
