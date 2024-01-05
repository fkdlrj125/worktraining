package com.spring.travel.vo;

public class ClientInfoVo {
	Long userSeq;
	String userName;
	String userPhone;
	String travelCity;
	String period;
	String expend;
	String transport;
	
	public Long getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(Long userSeq) {
		this.userSeq = userSeq;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getTravelCity() {
		return travelCity;
	}
	public void setTravelCity(String travelCity) {
		this.travelCity = travelCity;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getExpend() {
		return expend;
	}
	public void setExpend(String expend) {
		this.expend = expend;
	}
	public String getTransport() {
		return transport;
	}
	public void setTransport(String transport) {
		this.transport = transport;
	}
	
}
