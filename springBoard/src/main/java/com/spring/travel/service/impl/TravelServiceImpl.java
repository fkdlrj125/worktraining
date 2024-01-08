package com.spring.travel.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.travel.dao.TravelDao;
import com.spring.travel.service.TravelService;
import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

@Service
public class TravelServiceImpl implements TravelService{

	@Autowired
	TravelDao travelDao;
	
	@Override
	public int mergeUser(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return travelDao.mergeUser(cInfoVo);
	}

	@Override
	public int mergeTravelList(List<TravelInfoVo> tInfoVoList) throws Exception {
		// TODO Auto-generated method stub
		return travelDao.mergeTravelList(tInfoVoList);
	}

	@Override
	public int deleteTravel(TravelInfoVo tInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return travelDao.deleteTravel(tInfoVo);
	}

	@Override
	public ClientInfoVo selectUser(ClientInfoVo cInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return travelDao.selectUser(cInfoVo);
	}

	@Override
	public List<ClientInfoVo> selectUserList() throws Exception {
		// TODO Auto-generated method stub
		return travelDao.selectUserList();
	}

	@Override
	public List<TravelInfoVo> selectTravelList(TravelInfoVo tInfoVo) throws Exception {
		// TODO Auto-generated method stub
		return travelDao.selectTravelList(tInfoVo);
	}

}
