package com.itbank.repository;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itbank.model.ChatMessageDTO;
import com.itbank.model.ChatRoomDTO;
import com.itbank.model.ChatRoomJoinDTO;

public interface ChatDAO {

	int createChatroom(ChatRoomDTO dto);

	int insertChatRoomJoin(ChatRoomJoinDTO joinDto);

	List<ChatRoomDTO> selectChatroom();

	List<ChatMessageDTO> selectChatHistory(@Param("roomNo") int roomNo,@Param("userid") String userid);

	int insertChatMessage(ChatMessageDTO dto);

	int updateWatching(ChatRoomJoinDTO joinDto);

	int countMyRooms(String userid);

	List<ChatRoomDTO> selectMyRooms(String userid);

	int updateAllLastReadMsgNo(ChatMessageDTO dto);

	int updateLastReadMsgNo(ChatMessageDTO dto);

	int updateUnReadCount(ChatMessageDTO dto);

	// '내가 보낸' 메세지 번호를 스크립트에 저장하기 위해
	int selectMsgNo(ChatMessageDTO dto);

	int selectLastReadMsgNo(ChatRoomJoinDTO dto);

	// 방에서 가장 최신 메세지 번호
	int selectMaxMsgNo(int roomNo);




}
