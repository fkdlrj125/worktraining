package com.spring.recruit.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.common.CommonUtil;
import com.spring.recruit.service.RecruitService;
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
		System.out.println("Hello");
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		RecruitVo search = recruitService.selectRecruit(recruitVo);
		
		if(search == null) {
			recruitVo.setRecSubmit("N");
			result.put("success", recruitService.insertRecruit(recruitVo) > 0 ? "Y" : "N");
			session.setAttribute("userInfo", recruitVo);
			return CommonUtil.getJsonCallBackString("", result);
		}
		
		result.put("success", "Y");
		session.setAttribute("userInfo", search);
		System.out.println(search.getRecSeq());
		System.out.println(search.getRecSubmit());
		
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
		
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("location", recruitService.selectTypeList());
		model.addAttribute("eduList", recruitService.selectEdu(userInfo));
		model.addAttribute("carList", recruitService.selectCareer(userInfo));
		model.addAttribute("certList", recruitService.selectCert(userInfo));
		
		return "recruit/main";
	}
	
//	@RequestMapping(value="/recruit/save", method = RequestMethod.POST)
//	@ResponseBody
//	public String recruitSaveAction(HttpServletRequest request) throws Exception {
//		Map<String, Object> result = new HashMap<String, Object>();
//		HttpSession session = request.getSession(false);
//		RecruitVo userInfo = (RecruitVo) session.getAttribute("userInfo");
//		
////		RecruitVo recruitVo = new RecruitVo();
////		
////		JSONObject jsonObj = JSONObject.fromObject(data);
////		List<EduVo> eduList = new ArrayList<>();
////		List<CareerVo> carList = new ArrayList<>();
////		List<CertVo> certList = new ArrayList<>();
////		List<EduVo> selectEduList = recruitService.selectEdu(userInfo);
////		List<CareerVo> selectCarList = recruitService.selectCareer(userInfo);
////		List<CertVo> selectCertList = recruitService.selectCert(userInfo);
////		Iterator<EduVo> selectEduItr = selectEduList.iterator();
////		Iterator<CareerVo> selectCarItr = selectCarList.iterator();
////		Iterator<CertVo> selectCertItr = selectCertList.iterator();
////		
////		for(Object key : jsonObj.keySet()) {
////			for(Object values : jsonObj.getJSONArray((String)key)) {
////				switch ((String) key) {
////					case "recData": {
////						recruitVo = (RecruitVo)JSONObject.toBean((JSONObject)values, RecruitVo.class);
////						recruitVo.setRecSeq(userInfo.getRecSeq());
////						recruitVo.setRecSubmit(userInfo.getRecSubmit());
////						break;
////					}
////					case "eduData": {
////						EduVo eduVo = (EduVo)JSONObject.toBean((JSONObject)values, EduVo.class);
////						eduVo.setRecSeq(userInfo.getRecSeq());
////						eduVo.setEduSeq(selectEduItr.next().getEduSeq());
////						eduList.add(eduVo);
////						break;
////					}
////					case "carData": {
////						CareerVo carVo = (CareerVo)JSONObject.toBean((JSONObject)values, CareerVo.class);
////						carVo.setRecSeq(userInfo.getRecSeq());
////						carVo.setCarSeq(selectCarItr.next().getCarSeq());
////						carList.add(carVo);
////						break;
////					}
////					case "certData": {
////						CertVo certVo = (CertVo)JSONObject.toBean((JSONObject)values, CertVo.class);
////						certVo.setRecSeq(userInfo.getRecSeq());
////						certVo.setCertSeq(selectCertItr.next().getCertSeq());
////						certList.add(certVo);
////						break;
////					}
////					default: {
////						result.put("success", "N");
////						return CommonUtil.getJsonCallBackString("", result);
////					}
////				}
////			}
////		}
////		
////		String callbackMsg = "";
////		
////		switch (recruitVo.getRecSubmit()) {
////			case "save": {
////				session.setAttribute("userInfo", recruitVo);
////				callbackMsg = recruitService.updateRecruit(recruitVo) + recruitService.mergeEdu(eduList)
////				 + recruitService.mergeCareer(carList) + recruitService.mergeCert(certList)
////				 >= 4 ? "Y" : "N";
////				break;
////			}
////			
////			case "submit": {
////				result.put("success", "S");
////				return CommonUtil.getJsonCallBackString("", result);
////			}
////			
////		}
////		
////		result.put("success", callbackMsg);
////		return CommonUtil.getJsonCallBackString("", result);
//		return null;
//	}

//	@RequestMapping(value="/recruit/submit", method = RequestMethod.POST)
//	@ResponseBody
//	public String recruitSubmitAction(HttpServletRequest request, String data) throws Exception {
//		Map<String, Object> result = new HashMap<String, Object>();
//		HttpSession session = request.getSession(false);
//		RecruitVo userInfo = (RecruitVo) session.getAttribute("userInfo");
//		
//		JSONObject jsonObj = JSONObject.fromObject(data);
//		RecruitVo recruitVo = new RecruitVo();
//		List<EduVo> eduList = new ArrayList<>();
//		List<CareerVo> carList = new ArrayList<>();
//		List<CertVo> certList = new ArrayList<>();
//		List<EduVo> selectEduList = recruitService.selectEdu(userInfo);
//		List<CareerVo> selectCarList = recruitService.selectCareer(userInfo);
//		List<CertVo> selectCertList = recruitService.selectCert(userInfo);
//		Iterator<EduVo> selectEduItr = recruitService.selectEdu(userInfo).iterator();
//		Iterator<CareerVo> selectCarItr = recruitService.selectCareer(userInfo).iterator();
//		Iterator<CertVo> selectCertItr = recruitService.selectCert(userInfo).iterator();
//		
//		for(Object key : jsonObj.keySet()) {
//			for(Object values : jsonObj.getJSONArray((String)key)) {
//				switch ((String) key) {
//					case "recData": {
//						recruitVo = (RecruitVo)JSONObject.toBean((JSONObject)values, RecruitVo.class);
//						recruitVo.setRecSeq(userInfo.getRecSeq());
//						recruitVo.setRecSubmit(userInfo.getRecSubmit());
//						break;
//					}
//					case "eduData": {
//						EduVo eduVo = (EduVo)JSONObject.toBean((JSONObject)values, EduVo.class);
//						eduVo.setRecSeq(userInfo.getRecSeq());
//						eduVo.setEduSeq(selectEduItr.next().getEduSeq());
//						eduList.add(eduVo);
//						break;
//					}
//					case "carData": {
//						CareerVo carVo = (CareerVo)JSONObject.toBean((JSONObject)values, CareerVo.class);
//						carVo.setRecSeq(userInfo.getRecSeq());
//						carVo.setCarSeq(selectCarItr.next().getCarSeq());
//						carList.add(carVo);
//						break;
//					}
//					case "certData": {
//						CertVo certVo = (CertVo)JSONObject.toBean((JSONObject)values, CertVo.class);
//						certVo.setRecSeq(userInfo.getRecSeq());
//						certVo.setCertSeq(selectCertItr.next().getCertSeq());
//						certList.add(certVo);
//						break;
//					}
//					default: {
//						result.put("success", "N");
//						return CommonUtil.getJsonCallBackString("", result);
//					}
//				}
//			}
//		}
//		
//		String callbackMsg = "";
//		
//		switch (recruitVo.getRecSubmit()) {
//			case "N": {
//				recruitVo.setRecSubmit("Y");
//				session.setAttribute("userInfo", recruitVo);
//				 callbackMsg = recruitService.updateRecruit(recruitVo) + recruitService.mergeEdu(eduList)
//				 + recruitService.mergeCareer(carList) + recruitService.mergeCert(certList)
//				 >= 4 ? "Y" : "N";
//				break;
//			}
//			
//			case "Y": {
//				result.put("success", "S");
//				return CommonUtil.getJsonCallBackString("", result);
//			}
//		}
//		
//		result.put("success", callbackMsg);
//		return CommonUtil.getJsonCallBackString("", result);
//	}
	
//	@RequestMapping(value = "/recruit/delete", method = RequestMethod.POST)
//	@ResponseBody
//	public String deleteInfoAction(HttpServletRequest request, @RequestBody DeleteRequestDto checkSeq) throws Exception {
//		Map<String, String> result = new HashMap<>();
//		HttpSession session = request.getSession(false);
//		RecruitVo userInfo = (RecruitVo)session.getAttribute("userInfo");
//		
//		if(!checkSeq.getEdu().isEmpty()) {
//			List<EduVo> eduList = new ArrayList<>();
//			EduVo eduVo = new EduVo();
//			checkSeq.getEdu().forEach((seq) -> {
//				eduVo.setEduSeq(seq);
//				eduVo.setRecSeq(userInfo.getRecSeq());
//				eduList.add(eduVo);
//			});
//			
//			recruitService.deleteEdu(eduList);
//		}
//		
//		if(!checkSeq.getCar().isEmpty()) {
//			List<CareerVo> carList = new ArrayList<>();
//			CareerVo carVo = new CareerVo();
//			checkSeq.getEdu().forEach((seq) -> {
//				carVo.setCarSeq(seq);
//				carVo.setRecSeq(userInfo.getRecSeq());
//				carList.add(carVo);
//			});
//			
//			recruitService.deleteCareer(carList);
//		}
//		
//		if(!checkSeq.getCert().isEmpty()) {
//			List<CertVo> certList = new ArrayList<>();
//			CertVo certVo = new CertVo();
//			checkSeq.getCert().forEach((seq) -> {
//				certVo.setCertSeq(seq);
//				certVo.setRecSeq(userInfo.getRecSeq());
//				certList.add(certVo);
//			});
//			
//			result.put("success", recruitService.deleteCert(certList) == 0 ? "N" : "Y");
//		}
//		
//		result.put("success", "N");
//		return CommonUtil.getJsonCallBackString("", result);
//	}
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
