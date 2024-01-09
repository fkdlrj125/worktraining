package com.spring.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class TravelAPIUtil {
	public static List<Map<String, Object>> getData(String type, String ...args) throws Exception {
		// URL 변수
		// 인증키 (개인이 받아와야함)
    	final String KEY = "990C9653-E457-3637-8610-FFE3CA0A9247";
    	final String DOMAIN = "http://localhost:8080/travel/book";
    	int size = 1000;
    	String cityName = args.length > 0 ? args[0] : "";
    	
    	//
    	Map<String, Integer> codeMap = new HashMap<>();
    	codeMap.put("서울", 11);
    	codeMap.put("부산", 26);
    	codeMap.put("대구", 27);
    	codeMap.put("인천", 28);
    	codeMap.put("광주", 29);
    	codeMap.put("대전", 30);
    	codeMap.put("울산", 31);
    	codeMap.put("세종", 36);
    	codeMap.put("경기도", 41);
    	codeMap.put("충청북도", 43);
    	codeMap.put("충청남도", 44);
    	codeMap.put("전라북도", 45);
    	codeMap.put("전라남도", 46);
    	codeMap.put("경상북도", 47);
    	codeMap.put("경상남도", 48);
    	codeMap.put("제주도", 50);
    	codeMap.put("강원도", 51);
    	
    	// id값을 저장한 맵 객체
    	Map<String, String> typeMap = new HashMap<>();
    	typeMap.put("cityCode", "ctprvn_cd");
    	typeMap.put("cityName", "ctp_kor_nm");
    	typeMap.put("countyCode", "sig_cd");
    	typeMap.put("countyName", "sig_kor_nm");
    	
    	
    	// url을 저장한 맵 객체
    	Map<String, String> urlMap = new HashMap<>();
    	urlMap.put("city", "https://api.vworld.kr/req/data?key=" + KEY + "&domain=" + DOMAIN + "&service=data&version=2.0&request=getfeature&format=json&size="+ size +"&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIDO_INFO&_=1704700345341");
    	urlMap.put("county", "https://api.vworld.kr/req/data?key=" + KEY + "&domain=" + DOMAIN + "&service=data&version=2.0&request=GetFeature&format=json&size="+ size +"&page=1&data=LT_C_ADSIGG_INFO&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&attrfilter=sig_cd:like:"+ codeMap.get(cityName) +"&columns=sig_cd,full_nm,sig_kor_nm,sig_eng_nm,ag_geom&geometry=false&attribute=true&crs=EPSG:900913&");

    	// 파싱한 데이터를 저장할 변수
    	String result = "";
    	
    	// 시군구 및 코드를 저장할 변수
    	List<Map<String, Object>> resultListMap = new ArrayList<Map<String, Object>>();
    	
    	try {
    		URL url = new URL(urlMap.get(type));
    		BufferedReader bf;

    		bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
    		result = bf.readLine();
    		result = result.concat("}}}");
    		
    		Gson gson = new Gson();
    		Map<String, Object> gsonMap = gson.fromJson(result, new TypeToken<Map<String, Object>>(){}.getType());;
    		Map resultMap = (Map)((Map)gsonMap.get("response")).get("result");
    		List features = (List) ((Map) resultMap.get("featureCollection")).get("features");
    		
    		for(Object feature : features) {
    			Map<String, Object> map = new HashMap<String, Object>();
    			Map properties = (Map)((Map)feature).get("properties");
    			
    			if(type.equals("city") || ((String)properties.get(typeMap.get(type + "Code"))).matches("^" + codeMap.get(cityName) + "\\d*$")) {
    				map.put("code", properties.get(typeMap.get(type + "Code")));
        			map.put("name", ((String)properties.get(typeMap.get(type + "Name"))).replaceFirst("(특별시|광역시|특별자치시|특별자치)", ""));
        			resultListMap.add(map);
    			}
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	System.out.println(resultListMap);
    	return resultListMap;
	}
}
