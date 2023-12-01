package com.spring.user.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.dao.TypeDao;
import com.spring.common.vo.TypeVo;
import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	TypeDao typeDao;

	@Override
	public int insertUser(UserVo userVo) throws Exception {
		return userDao.insertUser(userVo);
	}

	@Override
	public String selectUserId(String inputId) throws Exception {
		Optional<String> result = userDao.selectUserId(inputId);
		return result.isEmpty() ? "" : result.get();
	}
	
	@Override
	public String selectUserName(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		Optional<Object> result = userDao.selectUser(userVo);
		UserVo user = (UserVo) result.get();
		
		return user.getUserName();
	}
	
	@Override
	public String loginUser(UserVo userVo) throws Exception {
		Optional<Object> result = userDao.selectUser(userVo);
		UserVo searchResult;
		
		if(result.isEmpty()) {
			return "2";
		}
		
		searchResult = (UserVo)result.get();
		
		if(!userVo.getUserPw().strip().equals(searchResult.getUserPw().strip())) {
			return "1";
		} 
		
		return "";
	}
	
	@Override
	public List<TypeVo> selectTypeList() throws Exception {
		return typeDao.selectPhoneType();
	}


}
