package com.spring.recruit.dao;

import java.util.List;

import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;
import com.spring.recruit.vo.UserInfoVo;

public interface RecruitDao {
	
	public RecruitVo selectRecruit(RecruitVo recruitVo) throws Exception;
	
	public List<EduVo> selectEdu(RecruitVo recruitVo) throws Exception;
	
	public List<CareerVo> selectCareer(RecruitVo recruitVo) throws Exception;
	
	public List<CertVo> selectCert(RecruitVo recruitVo) throws Exception;
	
	public int insertRecruit(RecruitVo recruitVo) throws Exception;
	
	public int updateRecruit(RecruitVo recruitVo) throws Exception;
	
	public int mergeCert(List<CertVo> eduList) throws Exception;
	
	public int mergeCareer(List<CareerVo> careerList) throws Exception;
	
	public int mergeEdu(List<EduVo> certList) throws Exception;
	
	public int deleteCert(List<CertVo> certVo) throws Exception;

	public int deleteCareer(List<CareerVo> carList) throws Exception;

	public int deleteEdu(List<EduVo> eduList) throws Exception;
	
	public UserInfoVo selectUserInfo(RecruitVo recruitVo) throws Exception;
}
