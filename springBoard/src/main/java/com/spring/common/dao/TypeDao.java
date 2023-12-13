package com.spring.common.dao;

import java.util.List;

import com.spring.common.vo.TypeVo;

public interface TypeDao {

	public List<TypeVo> selectType(TypeVo typeVo) throws Exception;
	
}
