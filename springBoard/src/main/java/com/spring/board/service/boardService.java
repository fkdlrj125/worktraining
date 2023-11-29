package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.vo.TypeVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt(PageVo pageVo) throws Exception;

	public int insertBoard(BoardVo boardVo) throws Exception;

	public int updateBoard(BoardVo boardVo) throws Exception;

	public int deleteBoard(String boardType, int boardNum) throws Exception;
	
	public List<TypeVo> selectTypeList() throws Exception;
}
