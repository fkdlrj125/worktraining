package com.spring.common.dao;

import java.util.List;

import com.spring.common.vo.TypeVo;

public interface TypeDao {

	public List<TypeVo> selectBoardType() throws Exception;
	
	public List<TypeVo> selectPhoneType() throws Exception;

}
