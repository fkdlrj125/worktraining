package com.spring.common.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.common.dao.TypeDao;
import com.spring.common.vo.TypeVo;

@Repository
public class TypeDaoImpl implements TypeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<TypeVo> selectType(TypeVo typeVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("type.typeList", typeVo);
	}
	
}
