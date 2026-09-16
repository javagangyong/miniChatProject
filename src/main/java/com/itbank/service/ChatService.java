package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.ChatMessageDTO;
import com.itbank.model.ChatRoomDTO;
import com.itbank.model.ChatRoomJoinDTO;
import com.itbank.repository.ChatDAO;

@Service
public class ChatService {
	
	@Autowired ChatDAO dao;

	public int createChatroom(ChatRoomDTO dto, String loginId) {
		// 룸 타입 설정
		dto.setRoomType(dto.getMaxUserCount() > 2 ? "group" : "direct");
		
		// 이때 Mapper의 설정에 의해 roomDto 객체 안에 roomNo가 세팅되어 돌아옴
		int result = dao.createChatroom(dto);
		
		// chatRoomJoin insert
		if(result == 1) {
			// 방금 생성된 roomNo를 가져와서 chatRoomJoinDTO구성
			ChatRoomJoinDTO joinDto = new ChatRoomJoinDTO();
			joinDto.setRoomNo(dto.getRoomNo());
			joinDto.setUserid(loginId);
			joinDto.setIsWatching("Y");
			joinDto.setLastReadMsgNo(0);
			
			dao.insertChatRoomJoin(joinDto);
		}
		return result;
	}

	public List<ChatRoomDTO> selectChatroom() {
		return dao.selectChatroom();
	}

	public List<ChatMessageDTO> selectChatHistory(int roomNo) {
		return dao.selectChatHistory(roomNo);
	}

	public int insertChatMessage(ChatMessageDTO dto) {
		return dao.insertChatMessage(dto);
	}

}
