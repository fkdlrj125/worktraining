package com.spring.recruit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.common.CommonUtil;
import com.spring.recruit.dto.DeleteRequestDto;
import com.spring.recruit.dto.FormRequestDto;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;

@Controller
public class RecruitController {
	
	@Autowired
	RecruitService recruitService;
	
	@RequestMapping(value="/recruit/login", method = RequestMethod.GET)
	public String recruitLogin() {
		return "recruit/login";
	}
	
	@RequestMapping(value="/recruit/login", method = RequestMethod.POST)
	@ResponseBody
	public String recruitLoginAction(RecruitVo recruitVo, HttpServletRequest request)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		RecruitVo search = recruitService.selectRecruit(recruitVo);
		
		if(search == null) {
			recruitVo.setRecSubmit("N");
			result.put("success", recruitService.insertRecruit(recruitVo) > 0 ? "Y" : "N");
			session.setAttribute("userInfo", recruitService.selectRecruit(recruitVo));
			return CommonUtil.getJsonCallBackString("", result);
		}
		
		result.put("success", "Y");
		session.setAttribute("userInfo", search);
		return CommonUtil.getJsonCallBackString("", result);
	}
	
	@RequestMapping(value="/recruit/main", method = RequestMethod.GET)
	public String recruitMain(HttpServletRequest request, Model model) throws Exception {
		RecruitVo userInfo = (RecruitVo) request.getSession(false).getAttribute("userInfo");
		
		if(userInfo == null) {
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("location", recruitService.selectTypeList());
			return "recruit/main";
		}
		
		if(userInfo.getRecBirth() != null) {
			model.addAttribute("userBoxInfo", recruitService.selectUserBox(userInfo));
		}
		
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("location", recruitService.selectTypeList());
		model.addAttribute("eduList", recruitService.selectEdu(userInfo));
		model.addAttribute("carList", recruitService.selectCareer(userInfo));
		model.addAttribute("certList", recruitService.selectCert(userInfo));
		
		return "recruit/main";
	}
	
	@RequestMapping(value="/recruit/save", method = RequestMethod.POST)
	@ResponseBody
	public String recruitSaveAction(HttpServletRequest request, @RequestBody FormRequestDto data) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = request.getSession(false);
		RecruitVo userInfo = (RecruitVo) session.getAttribute("userInfo");
		String callbackMsg = "";
		int r = 0;
		
		System.out.println(userInfo.getRecSeq());
		data.setSeq(userInfo);
		
		switch (userInfo.getRecSubmit()) {
			case "N": {
				if(data.getCarData() != null && data.getCertData() != null) {
					r = recruitService.updateRecruit(data.getRecData().get(0)) + recruitService.mergeEdu(data.getEduData())
					 + recruitService.mergeCareer(data.getCarData()) + recruitService.mergeCert(data.getCertData());
					callbackMsg = r >= 3 ? "Y" : "N";
					break;
					
				}
				
				if(data.getCarData() != null) {
					r = recruitService.updateRecruit(data.getRecData().get(0)) + recruitService.mergeEdu(data.getEduData())
					+ recruitService.mergeCareer(data.getCarData());
					callbackMsg = r >= 2 ? "Y" : "N";
					break;
				}
				
				if(data.getCertData() != null) {
					r = recruitService.updateRecruit(data.getRecData().get(0)) + recruitService.mergeEdu(data.getEduData())
					+ recruitService.mergeCert(data.getCertData());
					callbackMsg = r >= 2 ? "Y" : "N";
					break;
				} 
				
				r = recruitService.updateRecruit(data.getRecData().get(0)) + recruitService.mergeEdu(data.getEduData());
				callbackMsg = r >= 1 ? "Y" : "N";
				break;
			}
			
			case "Y": {
				result.put("success", "S");
				return CommonUtil.getJsonCallBackString("", result);
			}
		}
		System.out.println(r);
		
		result.put("success", callbackMsg);
		return CommonUtil.getJsonCallBackString("", result);
	}

	@RequestMapping(value="/recruit/submit", method = RequestMethod.POST)
	@ResponseBody
	public String recruitSubmitAction(HttpServletRequest request, @RequestBody FormRequestDto data) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = request.getSession(false);
		RecruitVo userInfo = (RecruitVo) session.getAttribute("userInfo");
		
		String callbackMsg = "";
		
		switch (userInfo.getRecSubmit()) {
			case "N": {
				userInfo.setRecSubmit("Y");
				session.setAttribute("userInfo", userInfo);
				callbackMsg = recruitService.updateRecruit(data.getRecData().get(0)) + recruitService.mergeEdu(data.getEduData())
				 + recruitService.mergeCareer(data.getCarData()) + recruitService.mergeCert(data.getCertData())
				 >= 4 ? "Y" : "N";
				break;
			}
			
			case "Y": {
				result.put("success", "S");
				return CommonUtil.getJsonCallBackString("", result);
			}
			
		}
		
		result.put("success", callbackMsg);
		return CommonUtil.getJsonCallBackString("", result);
	}
	
	@RequestMapping(value = "/recruit/delete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteInfoAction(HttpServletRequest request, @RequestBody DeleteRequestDto checkSeq) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		HttpSession session = request.getSession(false);
		RecruitVo userInfo = (RecruitVo)session.getAttribute("userInfo");
		Map<String, Integer> sqlResult = new HashMap<>();
		sqlResult.put("eduResult", 1);
		sqlResult.put("carResult", 1);
		sqlResult.put("certResult", 1);
		
		if(checkSeq.getEdu() != null) {
			List<EduVo> eduList = new ArrayList<EduVo>();
			
			checkSeq.getEdu().forEach(new Consumer<String>() {
				@Override
				public void accept(String t) {
					EduVo eduVo = new EduVo();
					eduVo.setEduSeq(t);
					eduVo.setRecSeq(userInfo.getRecSeq());
					eduList.add(eduVo);
				}
			});
			sqlResult.replace("eduResult", recruitService.deleteEdu(eduList)) ;
		}
		
		if(checkSeq.getCar() != null) {
			List<CareerVo> carList = new ArrayList<CareerVo>();
			
			checkSeq.getCar().forEach(new Consumer<String>() {
				@Override
				public void accept(String t) {
					CareerVo carVo = new CareerVo();
					carVo.setCarSeq(t);
					carVo.setRecSeq(userInfo.getRecSeq());
					carList.add(carVo);
				}
			});
			sqlResult.replace("carResult", recruitService.deleteCareer(carList)) ;
		}
		
		if(checkSeq.getCert() != null) {
			List<CertVo> certList = new ArrayList<CertVo>();
			
			checkSeq.getCert().forEach(new Consumer<String>() {
				@Override
				public void accept(String t) {
					CertVo certVo = new CertVo();
					certVo.setCertSeq(t);
					certVo.setRecSeq(userInfo.getRecSeq());
					certList.add(certVo);
				}
			});
			sqlResult.replace("certResult", recruitService.deleteCert(certList)) ;
		}
		
		if(sqlResult.containsValue(0)) {
			result.put("success", "N");
			return CommonUtil.getJsonCallBackString("", result);
		} 
		
		result.put("success", "Y");
		return CommonUtil.getJsonCallBackString("", result);
	}
}

	

/*
 * 1.이름 휴대폰번호 입력 후 입사지원 로그인
 * 	-> 유효성검사 필요
 * 		- 이름은 한글만 입력하게 하고 5글자 넘어가면 자동으로 지워지게
 * 		- 비어있거나 단어가 아니라면 알람창으로 알림
 * 		- 휴대폰번호는 숫자와 '-'만 입력하게 하고 정규표현식을 통해 형식확인
 * 		- 비어있거나 형식이 다르다면 알람창으로 알림
 * 
 * 2. 로그인에 사용한 이름과 휴대폰번호 자동입력
 * 	-> 로그인에 성공하면 사용한 이름과 휴대폰번호 시퀀스로 순번 저장
 * 
 * 3. 경력, 자격증 항목 제외 나머지 항목은 필수 체크
 * 	-> 학력에 값이 있는지 검사 없으면 알람창
 * 
 * 4. 학력, 경력, 자격증 각각 입력항목 추가, 삭제(체크박스 선택 후 삭제 버튼 클릭 시 삭제)
 * 	-> 로우 복사 가능할듯?
 * 	-> 로우 삭제해버리기
 * 
 * 5. 모든 항목 입력 후 저장 및 제출(저장은 수정가능, 제출은 수정불가능)
 * 	-> recruit테이블에 submit값을 통해 판단
 * 
 * 6. 최초 등록 후 재로그인 시에 학력사항, 경력사항, 희망연봉(값고정), 희망근무지
 * 근무형태 테이블 추가
 * 	-> 값 가져온 거 적당히 뿌려주면 될듯?
 * 
 * 필요한 것
 * 1. 로그인 기능
 * 2. 인력사항 저장
 * 3. 학력 저장(외래키로 인력사항의 seq값 사용)
 * 4. 경력 저장(외래키로 인력사항의 seq값 사용)
 * 5. 자격증 저장(외래키로 인력사항의 seq값 사용)
 * 6. 인력사항 조회
 * 7. 학력 조회
 * 8. 경력 조회
 * 9. 자격증 조회
 * 10. 인력사항 수정
 * 11. 학력 수정
 * 12. 경력 수정
 * 13. 자격증 수정
 * 14. 학력 삭제
 * 15. 경력 삭제
 * 16. 자격증 삭제
 */
