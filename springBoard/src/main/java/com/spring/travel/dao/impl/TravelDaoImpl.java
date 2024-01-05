package com.spring.travel.dao.impl;

import java.util.List;

import com.spring.travel.dao.TravelDao;
import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

public class TravelDaoImpl implements TravelDao{

	@Override
	public int insertUser(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateUser(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int mergeTravelList(List<TravelInfoVo> tInfoVoList) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteTravelList(List<TravelInfoVo> tInfoVoList) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ClientInfoVo selectUser(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ClientInfoVo> selectUserList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TravelInfoVo> selectTravelList(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
