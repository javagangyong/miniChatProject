package com.itbank.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.ChatRoomDTO;
import com.itbank.model.MemberDTO;
import com.itbank.service.ChatService;

@RestController
@RequestMapping("/homeAjax")
public class HomeAjaxController {
	
	@Autowired ChatService cs;
	
	@PostMapping("/createChatroom")
	public int createChatroom(@RequestBody ChatRoomDTO dto, HttpSession session) {
		MemberDTO userDto = (MemberDTO)session.getAttribute("login");
		String loginId = userDto.getUserid();
		
		int row = cs.createChatroom(dto, loginId);
		System.out.println(row == 1 ? "채팅방 생성 완" : "채팅방 생성 실패");
		return row;
	}
	
	@GetMapping("/chatList")
	public List<ChatRoomDTO> chatList() {
		List<ChatRoomDTO> list = cs.selectChatroom();
		return list;
	}

}
