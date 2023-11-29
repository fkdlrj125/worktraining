package com.spring.board.vo;

import java.util.List;

public class PageVo {
	
	private int pageNo = 0;
	private List<String> boardType;
	
	public int getPageNo() {
		return pageNo;
	}

	public List<String> getBoardType() {
		return boardType;
	}

	public void setBoardType(List<String> boardType) {
		this.boardType = boardType;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
