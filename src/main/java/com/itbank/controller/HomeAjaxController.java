package com.itbank.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.ChatMessageDTO;
import com.itbank.model.ChatRoomDTO;
import com.itbank.model.ChatRoomJoinDTO;
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
	
	@GetMapping("/chatHistory")
	public List<ChatMessageDTO> chatHistory(@RequestParam("roomNo") int roomNo,
											@RequestParam("userid") String userid) {
		List<ChatMessageDTO> chatHistoryList = cs.selectChatHistory(roomNo, userid);
		return chatHistoryList;
	}
	
	@PostMapping("/insertRoomJoin")
	public int insertRoomJoin(@RequestBody ChatRoomJoinDTO joinDto) {
		int row = cs.insertRoomJoin(joinDto);
		return row;
	}
	
	@PostMapping("/updateWatching")
	public int updateWatching(@RequestBody ChatRoomJoinDTO joinDto) {
		int row = cs.updateWatching(joinDto);
		return row;
	}
	
	@PostMapping("/updateLastReadMsgNo")
	public int updateLastReadMsgNo(@RequestBody ChatRoomJoinDTO dto) {
		int row = cs.updateLastReadMsgNo(dto);
		return row;
	}
	
	@GetMapping("/myRoomsCount")
	public int myRoomsCount(@RequestParam("userid") String userid) {
		int row = cs.countMyRooms(userid);
		return row;
	}
	
	@GetMapping("/selectMyRooms")
	public List<ChatRoomDTO> myRoomList(@RequestParam("userid") String userid) {
		List<ChatRoomDTO> list = cs.selectMyRooms(userid);
		return list;
	}


}
