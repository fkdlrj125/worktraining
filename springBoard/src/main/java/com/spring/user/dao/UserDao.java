package com.spring.user.dao;

import java.util.Optional;

import com.spring.user.vo.UserVo;

public interface UserDao {
	public int insertUser(UserVo userVo) throws Exception;
	
	public Optional<String> selectUserId(String inputId) throws Exception;
	
	public Optional<Object> selectUser(UserVo userVo) throws Exception;
}
