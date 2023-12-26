package test;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class test {
	public static void main(String[] args) {
		List<String> schoolList = new ArrayList<>();
		schoolList.add("숭실대학교");
		schoolList.add("건국대학교");
		schoolList.add("성수고등학교");
		Matcher matcher;
		matcher.
		
		schoolList.forEach((t) -> {
			matcher = Pattern.compile(".+[초등|중|고등|대]학교").matcher(t);
		});
		
		System.out.println(matcher.find());
		System.out.println(matcher.group());
	}
}
