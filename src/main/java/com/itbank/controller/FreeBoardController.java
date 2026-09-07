package com.itbank.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.BoardPaging;
import com.itbank.model.FreeBoardDTO;
import com.itbank.service.FreeBoardService;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {
	
	@Autowired private FreeBoardService fs;
	
	@GetMapping("/fbList/{page}")
	public ModelAndView freeBoardList(@PathVariable int page, String search) { //데이터를 변경하지않는 form태그는 GetMapping
		ModelAndView mav = new ModelAndView("/freeBoard/fbList");
		if(search == null) {search = "";}
		int boardCount = fs.boardCount(search);
		BoardPaging boardPaging = new BoardPaging(page, boardCount);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardPaging", boardPaging);
		
		List<FreeBoardDTO> fbList = fs.fbList(map);
		mav.addObject("fbList", fbList);
		mav.addObject("boardPaging", boardPaging);
		return mav;
	}
	
	@GetMapping("/fbWrite")
	public void freeBoardWrite() {}
	
	
	@PostMapping("/fbWrite")
	public String freeBoardWrite(FreeBoardDTO dto) {
		int row = fs.fbWrite(dto);
		System.out.println(row != 0 ? "자유게시판 작성 성공" : "자유게시판 작성 실패");
		return "redirect:/freeBoard/fbList/1";
	}
	
	@GetMapping("/fbView/{idx}")
	public ModelAndView freeBoardView(@PathVariable("idx") int idx) {
		ModelAndView mav = new ModelAndView("/freeBoard/fbView");
		FreeBoardDTO dto = fs.fbView(idx);
		mav.addObject("dto", dto);
		return mav;
	}
	
	
}