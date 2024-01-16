package com.spring.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.spring.common.CommonUtil;
import com.spring.common.TravelAPIUtil;
import com.spring.common.TravelUtil;
import com.spring.travel.dto.CalculateDTO;
import com.spring.travel.dto.FormDTO;
import com.spring.travel.service.TravelService;
import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

@Controller
public class TravelController {
	
	@Autowired
	TravelService travelService;
	
	@RequestMapping(value = "/travel/login", method = RequestMethod.GET) 
	public String travelLogin() throws Exception {
		return "travel/login";
	}
	
	@RequestMapping(value = "/travel/login", method = RequestMethod.POST) 
	@ResponseBody
	public String travelLoginAction(ClientInfoVo cInfoVo, HttpServletRequest request) throws Exception {
		Map<String, String> callbackMsg = new HashMap<>();
		HttpSession session = request.getSession();
		ClientInfoVo selectUser = travelService.selectUser(cInfoVo);
		
		if(selectUser == null) {
			int result = travelService.mergeUser(cInfoVo);
			callbackMsg.put("success",  result == 1 ? "Y" : "N");
			session.setAttribute("loginUser", travelService.selectUser(cInfoVo));
			return CommonUtil.getJsonCallBackString("", callbackMsg);
		}
		
		callbackMsg.put("success", "Y");
		session.setAttribute("loginUser", selectUser);
		return CommonUtil.getJsonCallBackString("", callbackMsg);
	}
	
	@RequestMapping(value = "/travel/book", method = RequestMethod.GET) 
	public String travelBook(HttpServletRequest request, 
							Model model,
							@RequestParam(required = false, defaultValue = "1") String day) throws Exception {
		HttpSession session = request.getSession();
		ClientInfoVo loginUser = (ClientInfoVo)session.getAttribute("loginUser");
		TravelInfoVo tInfoVo = new TravelInfoVo();
		tInfoVo.setUserSeq(loginUser.getUserSeq());
		tInfoVo.setTravelDay(day);
		
		List<TravelInfoVo> tInfoList = travelService.selectTravelList(tInfoVo);
		System.out.println(!tInfoList.isEmpty());
		
		if(!tInfoList.isEmpty())
			model.addAttribute("travelInfoList", tInfoList);
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("cityList", TravelAPIUtil.getData("city"));
		model.addAttribute("countyList", TravelAPIUtil.getData("county", loginUser.getTravelCity()));
		
		return "travel/book";
	}
	
	@RequestMapping(value = "/travel/book", method = RequestMethod.POST)
	@ResponseBody
	public String travelBookAction(@RequestBody FormDTO formDTO, Model model) throws Exception {
		Map<String, String> callbackMsg = new HashMap<>();
		int result = 0;
		result += travelService.mergeUser(formDTO.getClientVo());
		
		if(Optional.ofNullable(formDTO.getTravelList()).isPresent()) {
			formDTO.setModify();
			result += travelService.mergeTravelList(formDTO.getTravelList());
		}
		
		callbackMsg.put("success", result > 0 ? "Y" : "N");
		
		return CommonUtil.getJsonCallBackString("", callbackMsg);
	}
	
	@RequestMapping(value = "/travel/admin", method = RequestMethod.GET) 
	public String travelAdmin(@RequestParam(required = false) String userSeq,
							@RequestParam(required = false, defaultValue = "1") String day,
							Model model) throws Exception {
		if(userSeq == null) {
			model.addAttribute("userList", travelService.selectUserList());
			return "travel/admin";
		}
		
		TravelInfoVo tInfoVo = new TravelInfoVo();
		tInfoVo.setUserSeq(userSeq);
		tInfoVo.setTravelDay(day);
		
		ClientInfoVo cInfoVo = new ClientInfoVo();
		cInfoVo.setUserSeq(userSeq);
		
		cInfoVo = travelService.selectUser(cInfoVo);
		
		model.addAttribute("userList", travelService.selectUserList());
		model.addAttribute("travelList", travelService.selectTravelList(tInfoVo));
		model.addAttribute("selectUser", cInfoVo);
		model.addAttribute("selectDay", day);
		model.addAttribute("cityList", TravelAPIUtil.getData("city"));
		model.addAttribute("countyList", TravelAPIUtil.getData("county", cInfoVo.getTravelCity()));
		return "travel/admin";
	}
	
	@RequestMapping(value = "/travel/admin", method = RequestMethod.POST) 
	@ResponseBody
	public String travelAdminAction(@RequestBody FormDTO formDTO) throws Exception {
		Map<String, String> callbackMsg = new HashMap<>();
		ClientInfoVo cInfoVo = formDTO.getClientVo();
		
		formDTO.setSeq(cInfoVo);
		
		callbackMsg.put("success", travelService.mergeTravelList(formDTO.getTravelList())
				== formDTO.getTravelList().size() ? "Y" : "N") ;
		
		return CommonUtil.getJsonCallBackString("", callbackMsg);
	}
	
	@RequestMapping(value = "/travel/delete", method = RequestMethod.POST) 
	@ResponseBody
	public String travelDelete(TravelInfoVo tInfoVo) throws Exception {
		Map<String, String> callbackMsg = new HashMap<>();
		callbackMsg.put("success", travelService.deleteTravel(tInfoVo) == 1 ? "Y" : "N"); 
		
		return CommonUtil.getJsonCallBackString("", callbackMsg);
	}
	
	@RequestMapping(value = "/travel/county", method = RequestMethod.POST)
	@ResponseBody
	public JsonArray travelCounty(String city) throws Exception {
		JsonArray jsonArray = new JsonArray();
		
		for(Map<String, Object> map : TravelAPIUtil.getData("county", city)) {
			JsonObject jsonObject = new JsonObject();
			
			for(Map.Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				jsonObject.add(key, (JsonElement) value);
				jsonArray.add(jsonObject);
			}
		}
		
		return jsonArray;
	}
	
	@RequestMapping(value = "/travel/calculate", method = RequestMethod.GET)
	@ResponseBody
	public String travelCalculate(CalculateDTO cal) throws Exception {
		Map<String, Integer> result = new HashMap<>();
		
		result.put("expend", TravelUtil.CalculateExpend(cal));

		return CommonUtil.getJsonCallBackString("", result);
	}
	
	@RequestMapping(value = "/travel/mod", method = RequestMethod.POST)
	@ResponseBody
	public String travelMod(@RequestBody FormDTO formDTO, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		ClientInfoVo cInfoVo = (ClientInfoVo)session.getAttribute("loginUser");
		
		formDTO.setModify(cInfoVo);
		
		Map<String, String> result = new HashMap<>();
		
		String callBackMsg = travelService.mergeTravelList(formDTO.getTravelList()) > 1 ? "Y" : "N";
		
		result.put("success", callBackMsg);
		
		return CommonUtil.getJsonCallBackString("", result);
	}
	
	@RequestMapping(value = "/travel/logout", method = RequestMethod.POST)
	@ResponseBody
	public String travelLogout(HttpServletRequest request) throws Exception {
		request.getSession(false).invalidate();
		
		return "Y";
	}
}

/*
여행스케쥴관리
1. 고객 로그인
- 이름과 휴대폰번호 입력
  - 이름 유효성 검사(한글 체크, 최대 입력길이 10 설정)
  - 휴대폰번호 유효성 검사(xxx-xxxx-xxxx형태 체크, 입력 시 자동으로 하이픈생성)
  - 로그인 시 기존에 있는 고객인지 확인 후 세션에 저장
  
2. 고객 여행견적 신청
- 로그인 한 고객 정보 자동 출력(이름, 휴대폰번호)
  - 세션에 저장된 고객정보 전달
  - 이름과 휴대폰번호는 변경 불가능하게 readonly설정
  - 신청버튼 로그아웃으로 변경
- 여행 기간, 이동수단, 여행경비, 여행지 선택 및 입력 후 신청버튼 클릭
  - 여행기간 : 1~30
    - 숫자로 입력제한
    - 입력값이 1~30 사이인지 유효성 검사
  - 이동수단 : 렌트(R), 대중교통(B), 자차(C)
  - 여행경비
    - 숫자와 ","로 입력제한
    - "," 자동 입력
  - 여행지 : 전국 시/도
- 신청 시 모든 값이 입력 됐나 검사

3. 여행 일정 관리(관리자 페이지)
- [고객리스트]
  여행관리 신청한 고객 리스트 출력
  고객리스트에서 고객명 클릭 시 하단에 여행 스케쥴 일정 리스트 출력
- 선택한 고객의 여행 기간에 따라 일별 버튼 생성
- 추가 및 삭제 버튼으로 일정 리스트 추가 및 삭제
- [일정리스트]
  시간, 지역(시/도, 시군구), 장소, 이동수단, 이동시간, 이용요금, 계획상세 입력
  교통비는 교통편 및 예상이동시간에 따라 계산하여 출력
  - 스케쥴이 겹치는 시간은 선택 불가
    시간은 오전 7시 ~ 다음날 오전 4시까지 등록 가능
  - 이동수단
    - 도보(W)
    - 버스(B)
      - 1400원
      - 20분 초과시 200원씩 할증
    - 지하철(S)
      - 1450원
      - 20분 초과시 200원씩 할증
    - 택시(T)
      - 시간대 별로 할증 계산
        22시~24시 20프로
        24시~04시 40프로
      - 기본요금 3800원(10분)
        - 이동거리 10분당 5000원
    - 렌트(R)
      - 10분당 500원 연료비
      - 1~2일 10만원 렌트기간에 따라 일 1만원 할인(최저 7만원)
        (3~4일 9만원, 5~6일 8만원)
    - 자차(C)
- 일정 리스트 작성 후 저장버튼 클릭 시 이용요금 및 교통비 합산하여 고객 리스트 견적경비에 출력
  예상 경비 초과 시 견적경비는 붉은색으로 변경

4. 고객 여행견적 확인 및 수정요청
- 신청한 고객 재로그인 시 신청한 견적 상세 출력
- 등록된 여행 일정 리스트 확인 및 체크박스 선택 후 일정 수정요청 가능
  - 수정요청 시 값은 M, 체크박스 비활성화(disabled)
  - 수정완료 시 값은 C, 체크박스 활성화
- 로그아웃 버튼 클릭 시 로그인 화면으로 이동

[Controller]
 - travelLogin(GET) 
   - 로그인페이지 전달
 - travelLoginAction(POST) 
   - 로그인 요청한 유저가 기존 유저인지 확인
   - 기존 유저라면 유저정보와 일정 리스트 전달
 - travelBook(GET)
   - 여행 견적 신청 페이지 전달
 - travelBookAction(POST)
   - 유저 정보 저장
   - 유저의 수정 요청이 있는지 확인
 - travelAdmin(GET)
   - 여행 일정 관리 페이지 전달
   - 여행관리 신청 고객 리스트 전달
 - travelAdminAction(POST)
   - 여행 일정 저장
 - travelList(GET)
   - 일정 리스트 전달(1일차)
 - travelDelete(POST)
   - 일정 삭제
   
[Service, Dao]
 - insertUser
 - updateUser
 - mergeTravelList
 - deleteTravelList
 - selectUser
 - selectUserList()
 - selectTravelList
 
[VO]
ClientInfoVo 
 - userSeq;
 - userName;
 - userPhone;
 - travelCity;
 - period;
 - expend;
 - transport;

TravelInfoVo 
 - userSeq;
 - travelSeq;
 - travelDay;
 - travelTime;
 - travelCity;
 - travelCounty;
 - travelLoc;
 - travelTrans;
 - transTime;
 - useTime;
 - useExpend;
 - travelDetail;
 - request;
 */
