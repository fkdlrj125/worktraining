package com.spring.travel.dto;

import java.util.List;
import java.util.Optional;

import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

public class FormDTO {
	ClientInfoVo clientVo;
	List<TravelInfoVo> travelList;
	
	public ClientInfoVo getClientVo() {
		return clientVo;
	}
	
	public void setClientVo(ClientInfoVo clientVo) {
		this.clientVo = clientVo;
	}
	
	public List<TravelInfoVo> getTravelList() {
		return travelList;
	}

	public void setTravelList(List<TravelInfoVo> travelList) {
		this.travelList = travelList;
	}

	public void setModify() {
		for(TravelInfoVo tinfoVo : travelList) {
			tinfoVo.setUserSeq(clientVo.getUserSeq());
			tinfoVo.setRequest("M");
		}
	}
}
