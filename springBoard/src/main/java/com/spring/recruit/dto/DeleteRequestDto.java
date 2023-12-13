package com.spring.recruit.dto;

import java.util.List;

public class DeleteRequestDto {
	List<String> edu;
	List<String> car;
	List<String> cert;
	
	public List<String> getEdu() {
		return edu;
	}
	public void setEdu(List<String> edu) {
		this.edu = edu;
	}
	public List<String> getCar() {
		return car;
	}
	public void setCar(List<String> car) {
		this.car = car;
	}
	public List<String> getCert() {
		return cert;
	}
	public void setCert(List<String> cert) {
		this.cert = cert;
	}
}
