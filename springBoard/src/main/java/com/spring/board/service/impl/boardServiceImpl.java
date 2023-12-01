package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.dao.TypeDao;
import com.spring.common.vo.TypeVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	TypeDao typeDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt(pageVo);
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		BoardVo resultBoard = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		resultBoard = boardDao.selectBoard(boardVo);
		
		if(resultBoard.getCreator().trim().equals("SYSTEM")) {
			resultBoard.setCreator("");
		}
		
		return resultBoard;
	}
	
	@Override
	public int insertBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.insertBoard(boardVo);
	}

	@Override
	public int updateBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		List<TypeVo> typeList = typeDao.selectBoardType();
		String result = "";
		
		for(TypeVo type : typeList) {
			if(type.getCodeName().equals(boardVo.getBoardType())) {
				result = type.getCodeId();
			}
		}
		
		boardVo.setBoardType(result);
		
		return boardDao.updateBoard(boardVo);
	}

	@Override
	public int deleteBoard(String boardType, int boardNum) throws Exception{
		BoardVo boardVo = new BoardVo();
		List<TypeVo> typeList = typeDao.selectBoardType();
		String result = "";
		
		for(TypeVo type : typeList) {
			if(type.getCodeName().equals(boardType)) {
				result = type.getCodeId();
			}
		}
		
		boardVo.setBoardType(result);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.deleteBoard(boardVo);
	}

	@Override
	public List<TypeVo> selectTypeList() throws Exception {
		// TODO Auto-generated method stub
		return typeDao.selectBoardType();
	}
	
	
	
}
