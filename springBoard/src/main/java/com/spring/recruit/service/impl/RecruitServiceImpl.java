package com.spring.recruit.service.impl;

import java.time.LocalDate;
import java.time.Year;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.function.Consumer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.dao.TypeDao;
import com.spring.common.vo.TypeVo;
import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;
import com.spring.recruit.vo.UserInfoVo;

@Service
public class RecruitServiceImpl implements RecruitService {

	@Autowired
	RecruitDao recruitDao;
	
	@Autowired
	TypeDao typeDao;
	
	@Override
	public RecruitVo selectRecruit(RecruitVo recruitVo) throws Exception {
		return recruitDao.selectRecruit(recruitVo);
	}

	@Override
	public List<EduVo> selectEdu(RecruitVo recruitVo) throws Exception {
		return recruitDao.selectEdu(recruitVo);
	}

	@Override
	public List<CareerVo> selectCareer(RecruitVo recruitVo) throws Exception {
		return recruitDao.selectCareer(recruitVo);
	}

	@Override
	public List<CertVo> selectCert(RecruitVo recruitVo) throws Exception {
		return recruitDao.selectCert(recruitVo);
	}
	
	@Override
	public int insertRecruit(RecruitVo recruitVo) throws Exception {
		return recruitDao.insertRecruit(recruitVo);
	}

	@Override
	public int updateRecruit(RecruitVo recruitVo) throws Exception {
		return recruitDao.updateRecruit(recruitVo);
	}

	@Override
	public int mergeCert(List<CertVo> certList) throws Exception {
		return recruitDao.mergeCert(certList);
	}

	@Override
	public int mergeCareer(List<CareerVo> careerList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.mergeCareer(careerList);
	}

	@Override
	public int mergeEdu(List<EduVo> eduList) throws Exception {
		return recruitDao.mergeEdu(eduList);
	}

	@Override
	public int deleteCert(List<CertVo> certList) throws Exception {
		return recruitDao.deleteCert(certList);
	}

	@Override
	public int deleteCareer(List<CareerVo> careerList) throws Exception {
		return recruitDao.deleteCareer(careerList);
	}

	@Override
	public int deleteEdu(List<EduVo> eduList) throws Exception {
		return recruitDao.deleteEdu(eduList);
	}

	@Override
	public List<TypeVo> selectTypeList() throws Exception {
		TypeVo typeVo = new TypeVo();
		typeVo.setCodeType("location");
		return typeDao.selectType(typeVo);
	}

	@Override
	public UserInfoVo selectUserBox(RecruitVo recruitVo) throws Exception {
		UserInfoVo userInfo = recruitDao.selectUserInfo(recruitVo);
		
		Pattern pattern = Pattern.compile("(대|고등|중|초등)학교");
		Matcher matcher = pattern.matcher(userInfo.getSchool());
		if(matcher.find()) userInfo.setSchool(matcher.group());
		
		if(userInfo.getCarPeriod() != null) {
			int year = Integer.parseInt(userInfo.getCarPeriod()) / 12;
			int month = Integer.parseInt(userInfo.getCarPeriod()) % 12;
			userInfo.setCarPeriod("경력" + (year == 0 ?  "" : " " + year + "년")  
					+ (month == 0 ? "" : " " + month + "개월"));
		}
		
		return userInfo;
	}
}
