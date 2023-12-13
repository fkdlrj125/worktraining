package com.spring.recruit.dto;

import java.util.List;

import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;

public class FormRequestDto {
	public RecruitVo recData;
	public List<EduVo> eduData;
	public List<CareerVo> carData;
	public List<CertVo> certData;
	
	public RecruitVo getRecData() {
		return recData;
	}
	public void setRecData(RecruitVo recData) {
		this.recData = recData;
	}
	public List<EduVo> getEduData() {
		return eduData;
	}
	public void setEduData(List<EduVo> eduData) {
		this.eduData = eduData;
	}
	public List<CareerVo> getCarData() {
		return carData;
	}
	public void setCarData(List<CareerVo> carData) {
		this.carData = carData;
	}
	public List<CertVo> getCertData() {
		return certData;
	}
	public void setCertData(List<CertVo> certData) {
		this.certData = certData;
	}
	
	
}
