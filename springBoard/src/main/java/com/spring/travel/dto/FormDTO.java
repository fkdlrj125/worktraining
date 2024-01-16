package com.spring.travel.dto;

import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;

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
	
	public void setSeq(ClientInfoVo cInfoVo) {
		clientVo.setUserSeq(cInfoVo.getUserSeq());
		
		travelList.forEach(new Consumer<TravelInfoVo>() {
			@Override
			public void accept(TravelInfoVo t) {
				t.setUserSeq(cInfoVo.getUserSeq());
			}
		});
	}

	public void setModify() {
		travelList.forEach(new Consumer<TravelInfoVo>() {
			@Override
			public void accept(TravelInfoVo t) {
				t.setUserSeq(clientVo.getUserSeq());
				t.setRequest("M");
			}
		});
	}
	
	public void setModify(ClientInfoVo cInfoVo) {
		travelList.forEach(new Consumer<TravelInfoVo>() {
			@Override
			public void accept(TravelInfoVo t) {
				t.setUserSeq(cInfoVo.getUserSeq());
				t.setRequest("M");
			}
		});
	}
}
