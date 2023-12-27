package test;

import java.time.YearMonth;
import java.time.temporal.ChronoUnit;

public class test {
	public static void main(String[] args) {
		YearMonth start = YearMonth.now();
		YearMonth end = YearMonth.parse("2019.01".replace(".", "-"));
		
		System.out.println(start);
		System.out.println(end);
		System.out.println(ChronoUnit.MONTHS.between(end, start));
		System.out.println(59 / 12 + "," + 59 % 12);
	}
}
