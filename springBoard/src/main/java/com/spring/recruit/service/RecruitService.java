package com.spring.recruit.service;

import java.util.List;

import com.spring.common.vo.TypeVo;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;
import com.spring.recruit.vo.UserBoxVo;

public interface RecruitService {
	public RecruitVo selectRecruit(RecruitVo recruitVo) throws Exception;
	
	public List<CertVo> selectCert(RecruitVo recruitVo) throws Exception;
	
	public List<CareerVo> selectCareer(RecruitVo recruitVo) throws Exception;
	
	public List<EduVo> selectEdu(RecruitVo recruitVo) throws Exception;
	
	public int insertRecruit(RecruitVo recruitVo) throws Exception;
	
	public int updateRecruit(RecruitVo recruitVo) throws Exception;
	
	public int mergeCert(List<CertVo> certVo) throws Exception;
	
	public int mergeCareer(List<CareerVo> careerVo) throws Exception;
	
	public int mergeEdu(List<EduVo> eduVo) throws Exception;
	
	public int deleteCert(List<CertVo> certVo) throws Exception;
	
	public int deleteCareer(List<CareerVo> careerVo) throws Exception;
	
	public int deleteEdu(List<EduVo> eduVo) throws Exception;
	
	public List<TypeVo> selectTypeList() throws Exception;
	
	public UserBoxVo makeUserBoxVo(RecruitVo userInfo) throws Exception;
}
