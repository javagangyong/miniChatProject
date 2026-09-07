package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.FreeBoardReplyDTO;
import com.itbank.service.FreeBoardService;

@RestController
@RequestMapping("/freeBoardAjax")
public class FreeBoardAjaxController {
	
	@Autowired FreeBoardService fs;
	
	@PostMapping("/replyWrite")
	public int freeBoardReplyWrite(@RequestBody FreeBoardReplyDTO dto) {
		int result = 0;
		result = fs.fbReply(dto);
		System.out.println(result != 0 ? "자유게시판 댓글 작성완료" : "자유게시판 댓글 작성실패");
		
		return result;
	}
	
	@GetMapping("/replyView/{idx}")
	public List<FreeBoardReplyDTO> getReplyList(@PathVariable("idx") int board_idx) {
		List<FreeBoardReplyDTO> list = fs.selectList(board_idx);
		return list;
	}
	
}
