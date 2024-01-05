package com.spring.travel.dao;

import java.util.List;

import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

public interface TravelDao {
	public int insertUser(ClientInfoVo cInfoVo) throws Exception;
	public int updateUser(ClientInfoVo cInfoVo) throws Exception;
	public int mergeTravelList(List<TravelInfoVo> tInfoVoList) throws Exception;
	public int deleteTravelList(List<TravelInfoVo> tInfoVoList) throws Exception;
	public ClientInfoVo selectUser(ClientInfoVo cInfoVo) throws Exception;
	public List<ClientInfoVo> selectUserList() throws Exception;
	public List<TravelInfoVo> selectTravelList(ClientInfoVo cInfoVo) throws Exception;
}
