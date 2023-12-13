package com.spring.recruit.service.impl;

import java.util.List;

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

@Service
public class RecruitServiceImpl implements RecruitService {

	@Autowired
	RecruitDao recruitDao;
	
	@Autowired
	TypeDao typeDao;
	
	@Override
	public RecruitVo selectRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.selectRecruit(recruitVo);
	}

	@Override
	public List<EduVo> selectEdu(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.selectEdu(recruitVo);
	}

	@Override
	public List<CareerVo> selectCareer(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.selectCareer(recruitVo);
	}

	@Override
	public List<CertVo> selectCert(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.selectCert(recruitVo);
	}
	
	@Override
	public int insertRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.insertRecruit(recruitVo);
	}

	@Override
	public int updateRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.updateRecruit(recruitVo);
	}

	@Override
	public int mergeCert(List<CertVo> certList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.mergeCert(certList);
	}

	@Override
	public int mergeCareer(List<CareerVo> careerList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.mergeCareer(careerList);
	}

	@Override
	public int mergeEdu(List<EduVo> eduList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.mergeEdu(eduList);
	}

	@Override
	public int deleteCert(List<CertVo> certList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteCert(certList);
	}

	@Override
	public int deleteCareer(List<CareerVo> careerList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteCareer(careerList);
	}

	@Override
	public int deleteEdu(List<EduVo> eduList) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteEdu(eduList);
	}

	@Override
	public List<TypeVo> selectTypeList() throws Exception {
		// TODO Auto-generated method stub
		TypeVo typeVo = new TypeVo();
		typeVo.setCodeType("location");
		return typeDao.selectType(typeVo);
	}
}
