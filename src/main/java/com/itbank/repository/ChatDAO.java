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



}
