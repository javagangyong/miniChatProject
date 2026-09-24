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
		
		// 이때 Mapper의 설정에 의해 dto 객체 안에 roomNo가 세팅되어 돌아옴
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

	public List<ChatMessageDTO> selectChatHistory(int roomNo, String userid) {
		return dao.selectChatHistory(roomNo, userid);
	}

	public int insertChatMessage(ChatMessageDTO dto) {
		int row = dao.insertChatMessage(dto);
		
		// 실시간 안읽은 사람 수 로직계산을 위한 메세지 번호 저장
		int msgNo = dao.selectMsgNo(dto);
		dto.setMsgNo(msgNo);
		System.out.println("보낸 메세지 번호는 : " + msgNo);
		
		// isWatching = 'Y'인 사람들 모두 lastReadMsgNo 최신화
		int result = dao.updateAllLastReadMsgNo(dto);
		return row + result;
	}

	public int insertRoomJoin(ChatRoomJoinDTO joinDto) {
		joinDto.setIsWatching("Y");
		joinDto.setLastReadMsgNo(0);
		return dao.insertChatRoomJoin(joinDto);
	}

	public int updateWatching(ChatRoomJoinDTO joinDto) {
		return dao.updateWatching(joinDto);
	}

	public int countMyRooms(String userid) {
		return dao.countMyRooms(userid);
	}

	public List<ChatRoomDTO> selectMyRooms(String userid) {
		return dao.selectMyRooms(userid);
	}

	public int updateLastReadMsgNo(ChatRoomJoinDTO dto) {
		// 채팅창 읽은 이 '한 사람'만 lastReadMsgNo 최신화
		return dao.updateLastReadMsgNo(dto);
	}

	public int updateUnReadCount(ChatRoomJoinDTO dto) {
		return dao.updateUnReadCount(dto);
	}

}
