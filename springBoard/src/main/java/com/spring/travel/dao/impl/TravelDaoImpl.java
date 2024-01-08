package com.spring.travel.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.travel.dao.TravelDao;
import com.spring.travel.vo.ClientInfoVo;
import com.spring.travel.vo.TravelInfoVo;

@Repository
public class TravelDaoImpl implements TravelDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int mergeUser(ClientInfoVo cInfoVo) throws Exception {
		return sqlSession.update("travel.mergeUser", cInfoVo);
	}

	@Override
	public int mergeTravelList(List<TravelInfoVo> tInfoVoList) throws Exception {
		return sqlSession.update("travel.mergeTravelList", tInfoVoList);
	}

	@Override
	public int deleteTravel(TravelInfoVo tInfoVo) throws Exception {
		return sqlSession.delete("travel.deleteTravel", tInfoVo);
	}

	@Override
	public ClientInfoVo selectUser(ClientInfoVo cInfoVo) throws Exception {
		return sqlSession.selectOne("travel.selectUser", cInfoVo);
	}

	@Override
	public List<ClientInfoVo> selectUserList() throws Exception {
		return sqlSession.selectList("travel.selectUserList");
	}

	@Override
	public List<TravelInfoVo> selectTravelList(TravelInfoVo tInfoVo) throws Exception {
		return sqlSession.selectList("travel.selectTravelList", tInfoVo);
	}

}
