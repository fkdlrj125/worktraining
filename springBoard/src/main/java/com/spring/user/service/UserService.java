package com.spring.user.service;

import java.util.List;
import java.util.Optional;

import com.spring.common.vo.TypeVo;
import com.spring.user.vo.UserVo;

public interface UserService {
	public int insertUser(UserVo userVo) throws Exception;
	
	public String selectUserId(String inputId) throws Exception;
	
	public String loginUser(UserVo userVo) throws Exception;
	
	public List<TypeVo> selectTypeList() throws Exception;

}
