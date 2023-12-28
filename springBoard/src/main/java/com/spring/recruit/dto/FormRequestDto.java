package com.spring.recruit.dto;

import java.util.List;
import java.util.function.Consumer;

import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;

public class FormRequestDto {
	public List<RecruitVo> recData;
	public List<EduVo> eduData;
	public List<CareerVo> carData;
	public List<CertVo> certData;
	
	public List<RecruitVo> getRecData() {
		return recData;
	}
	public void setRecData(List<RecruitVo> recData) {
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
	
	public void setSeq(RecruitVo userInfo) {
		recData.forEach(new Consumer<RecruitVo>() {
			@Override
			public void accept(RecruitVo recruitVo) {
				recruitVo.setRecSeq(userInfo.getRecSeq());
				recruitVo.setRecSubmit(userInfo.getRecSubmit());
			}
		});
		
		eduData.forEach(new Consumer<EduVo>() {
			@Override
			public void accept(EduVo eduVo) {
				eduVo.setRecSeq(userInfo.getRecSeq());
			}
		});
		
		if(carData != null)
		carData.forEach(new Consumer<CareerVo>() {
			@Override
			public void accept(CareerVo carVo) {
				carVo.setRecSeq(userInfo.getRecSeq());
			}
		});
		
		if(certData != null)
		certData.forEach(new Consumer<CertVo>() {
			@Override
			public void accept(CertVo certVo) {
				certVo.setRecSeq(userInfo.getRecSeq());
			}
		});
	}
}
