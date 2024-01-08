package com.spring.travel.service;

import java.util.List;

import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

public interface TravelService {
	public int mergeUser(ClientInfoVo cInfoVo) throws Exception;
	public int mergeTravelList(List<TravelInfoVo> tInfoVoList) throws Exception;
	public int deleteTravel(TravelInfoVo tInfoVo) throws Exception;
	public ClientInfoVo selectUser(ClientInfoVo cInfoVo) throws Exception;
	public List<ClientInfoVo> selectUserList() throws Exception;
	public List<TravelInfoVo> selectTravelList(TravelInfoVo tInfoVo) throws Exception;
}
