package com.spring.user.dao.impl;

import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertUser(UserVo userVo) throws Exception {
		return sqlSession.insert("user.insertUser", userVo);
	}

	@Override
	public Optional<String> selectUserId(String inputId) throws Exception {
		return Optional.ofNullable(sqlSession.selectOne("user.selectUserId", inputId));
	}

	@Override
	public Optional<Object> selectUser(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("user.selectUser", userVo).stream().findAny();
	}
}
