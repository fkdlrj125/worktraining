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

public class ApiTest {
	public static void main(String[] args) throws Exception {
		// URL 변수
		// 인증키 (개인이 받아와야함)
    	String key = "990C9653-E457-3637-8610-FFE3CA0A9247";
    	String domain = "http://localhost:8080/travel/book";
    	int size = 1000;
    	int countyCode = 26;
    	
    	// id값을 저장한 맵 객체
    	Map<String, String> typeMap = new HashMap<>();
    	typeMap.put("cityCode", "ctprvn_cd");
    	typeMap.put("cityName", "ctp_kor_nm");
    	typeMap.put("countyCode", "sig_cd");
    	typeMap.put("countyName", "sig_kor_nm");
    	
    	
    	// url을 저장한 맵 객체
    	Map<String, String> urlMap = new HashMap<>();
    	urlMap.put("city", "https://api.vworld.kr/req/data?key=" + key + "&domain=" + domain + "&service=data&version=2.0&request=getfeature&format=json&size="+ size +"&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIDO_INFO&_=1704700345341");
    	urlMap.put("county", "https://api.vworld.kr/req/data?key=" + key + "&domain=" + domain + "&service=data&version=2.0&request=GetFeature&format=json&size="+ size +"&page=1&data=LT_C_ADSIGG_INFO&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&attrfilter=sig_cd:like:"+ countyCode +"&columns=sig_cd,full_nm,sig_kor_nm,sig_eng_nm,ag_geom&geometry=false&attribute=true&crs=EPSG:900913&");

    	// 파싱한 데이터를 저장할 변수
    	String result = "";
    	
    	// 시군구 및 코드를 저장할 변수
    	List<Map<String, Object>> resultListMap = new ArrayList<Map<String, Object>>();
    	    	
    	try {
    		URL url = new URL(urlMap.get("city"));
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
    			
				map.put("code", properties.get(typeMap.get("city" + "Code")));
    			map.put("name", properties.get(typeMap.get("city" + "Name")).replaceFirst("(특별시|광역시|특별자치시|특별자치)", ""));
    			resultListMap.add(map);
    		}
    		
    		System.out.println(resultListMap);

    	}catch(Exception e) {
    		e.printStackTrace();
    	}
	}
}
