package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;
import com.spring.common.vo.TypeVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, String pageNo) throws Exception{
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<TypeVo> typeList = new ArrayList<TypeVo>();
		
		int page = 1;
		int totalCnt = 0;
		PageVo pageVo = new PageVo();
		
		pageVo.setPageNo(NumberUtils.toInt(pageNo));
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		typeList = boardService.selectTypeList();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("typeList", typeList);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> boardList(Locale locale, String param, String pageNo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<String> boardType = new ArrayList<String>();
		List<TypeVo> typeList = new ArrayList<TypeVo>();

		int page = 1;
		int totalCnt = 0;
		PageVo pageVo = new PageVo();
		
		pageVo.setPageNo(NumberUtils.toInt(pageNo));
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		Pattern pattern = Pattern.compile("a..");
		Matcher matcher = pattern.matcher(param);
		
		while(matcher.find()) {
			boardType.add(matcher.group());
		}
		
		pageVo.setBoardType(boardType);
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		typeList = boardService.selectTypeList();
		
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		map.put("totalCnt", totalCnt);
		map.put("pageNo", page);
		map.put("typeList", typeList);
		result.add(map);
		
		return result;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		model.addAttribute("typeList", boardService.selectTypeList());
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, @RequestParam(value="param") String jsonData) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = 0;
		
		JSONArray jsonArr = JSONArray.fromObject(jsonData);
		
		for(int i=0; i<jsonArr.size(); i++){
		   JSONObject jsonObj = (JSONObject)jsonArr.get(i);
		   BoardVo board = new BoardVo();
		   board.setBoardType(jsonObj.getString("boardType"));
		   board.setBoardTitle(jsonObj.getString("boardTitle"));
		   board.setBoardComment(jsonObj.getString("boardComment"));
		        
		   resultCnt = (boardService.insertBoard(board) > 0) ? ++resultCnt : resultCnt;
		}
		 
		result.put("success", (resultCnt == jsonArr.size())?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
//	ver.2 -> ,로 나눠지기 때문에 문자열로
/*	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, List<Map<String, String>> boardList) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = 0;
		
		for(int i = 0; i < boardList.size(); i++) {
			BoardVo board = new BoardVo();
			board.setBoardTitle(boardList.get(i).get("boardTitle"));
			board.setBoardComment(boardList.get(i).get("boardComment"));
			resultCnt = (boardService.boardInsert(board) > 0) ? ++resultCnt : resultCnt+0;
		}
		
		result.put("success", (resultCnt == boardList.size())?"Y":"N");
		
//		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	*/
	
//	ver.1 -> ,로 나눴을 때 제목에 ,가 들어가면 2개의 게시물로 나눠짐
//	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
//	@ResponseBody
//	public String boardWriteAction(Locale locale, BoardVo boardVo) throws Exception{
//		
//		HashMap<String, String> result = new HashMap<String, String>();
//		CommonUtil commonUtil = new CommonUtil();
//		
//		String[] boardTitles = boardVo.getBoardTitle().split(",");
//		String[] boardComments = boardVo.getBoardComment().split(",");
//		int resultCnt = 0;
//		
//		for(int i = 0; i < boardTitles.length; i++) {
//			BoardVo board = new BoardVo();
//			board.setBoardTitle(boardTitles[i]);
//			board.setBoardComment((boardComments.length > i) ? boardComments[i] : "");
//			resultCnt = (boardService.boardInsert(board) > 0) ? ++resultCnt : resultCnt+0;
//		}
//		
//		result.put("success", (resultCnt == boardTitles.length)?"Y":"N");
//		
////		result.put("success", (resultCnt > 0)?"Y":"N");
//		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
//		
//		System.out.println("callbackMsg::"+callbackMsg);
//		
//		return callbackMsg;
//	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("board", boardVo);
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		int resultCnt = boardService.updateBoard(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.deleteBoard(boardType,boardNum);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
}
