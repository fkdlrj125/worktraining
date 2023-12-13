//package com.spring.mbti.service.impl;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.spring.board.vo.BoardVo;
//import com.spring.board.vo.PageVo;
//import com.spring.mbti.dao.MBTIDao;
//import com.spring.mbti.service.MBTIService;
//
//import net.sf.json.JSONArray;
//import net.sf.json.JSONObject;
//
//@Service
//public class MBTIServiceImpl implements MBTIService{
//	
//	@Autowired
//	MBTIDao mbtiDao;
//
//	@Override
//	public List<BoardVo> selectMBTIList(PageVo pageVo) throws Exception {
//		// TODO Auto-generated method stub
//		return mbtiDao.selectMBTIList(pageVo);
//	}
//
//	@Override
//	public String calculateMBTI(String data) throws Exception {
//		String key = "";
//		Map<String, Integer> result = new HashMap<>();
//		JSONArray jArr = JSONArray.fromObject(data);
//		
//		result.put("i", 0);
//		result.put("e", 0);
//		result.put("s", 0);
//		result.put("n", 0);
//		result.put("t", 0);
//		result.put("f", 0);
//		result.put("j", 0);
//		result.put("p", 0);
//		
//		for(Object inArr : jArr) {
//			for(Object obj : (JSONArray)inArr) {
//				JSONObject jObj = (JSONObject)obj;
//				switch (jObj.getString("value")) {
//					case "1": {
//						key = jObj.getString("name").substring(0, 1);
//						result.put(key, result.get(key)+3);
//						break;
//					}
//					case "2": {
//						key = jObj.getString("name").substring(0, 1);
//						result.put(key, result.get(key)+2);
//						break;
//					}
//					case "3": {
//						key = jObj.getString("name").substring(0, 1);
//						result.put(key, result.get(key)+1);
//						break;
//					}
//					case "5": {
//						key = jObj.getString("name").substring(1, 2);
//						result.put(key, result.get(key)+1);
//						break;
//					}
//					case "6": {
//						key = jObj.getString("name").substring(1, 2);
//						result.put(key, result.get(key)+2);
//						break;
//					}
//					case "7": {
//						key = jObj.getString("name").substring(1, 2);
//						result.put(key, result.get(key)+3);
//						break;
//					}
//				}
//			}
//		}
//		
//		System.out.println(result);
//		
//		return compareMBTI(result);
//	}
//	
//	
//	public String compareMBTI(Map<String, Integer> data) {
//		String[] first = {"i", "n", "t", "p"};
//		String[] second = {"e", "s", "f", "j"};
//		String result = "";
//		
//		
//		for(int i=0; i < first.length; i++) {
//			if(data.get(first[i]) != data.get(second[i])) {
//				result = result.concat(data.get(first[i]) > data.get(second[i]) ? first[i] : second[i]);
//			} else {
//				result = result.concat(first[i].charAt(0) > second[i].charAt(0) ? second[i] : first[i]);
//			}
//		}
//		return result;
//	}
//}
//
//
////JSONObject jObj = (JSONObject)jArr.get(i);
////System.out.println(String.valueOf(jObj.get("value")));
////
////switch (String.valueOf(jObj.get("value"))) {
////case "1": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(3);
////	break;
////}
////case "2": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(2);
////	break;
////}
////case "3": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(1);
////	break;
////}
////case "5": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(1);
////	break;
////}
////case "6": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(2);
////	break;
////}
////case "7": {
////	nameList.add(String.valueOf(jObj.get("name")));
////	valueList.add(3);
////	break;
////}
////default:
////	throw new IllegalArgumentException("Unexpected value: " + (int)jObj.get("value"));
////}