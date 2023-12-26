package com.spring.recruit.service.impl;

import java.util.ArrayList;
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
import com.spring.recruit.vo.UserBoxVo;

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
	public UserBoxVo makeUserBoxVo(RecruitVo userInfo) throws Exception {
		List<EduVo> eduList = selectEdu(userInfo);
		List<CareerVo> carList = selectCareer(userInfo);
		List<CertVo> certList = selectCert(userInfo);
		List<String> strList = new ArrayList<>();
		
		eduList.forEach(new Consumer<EduVo>() {
			@Override
			public void accept(EduVo t) {
				strList.add(t.getEduSchool());
			}
		});
		
		Matcher matcher = Pattern.compile(".+[초|중|고등|대]학교").matcher("숭실대학교");
		
		return null;
	}
	
	
}
