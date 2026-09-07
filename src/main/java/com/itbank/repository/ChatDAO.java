package com.itbank.repository;


import java.util.List;

import com.itbank.model.ChatRoomDTO;
import com.itbank.model.ChatRoomJoinDTO;

public interface ChatDAO {

	int createChatroom(ChatRoomDTO dto);

	int insertChatRoomJoin(ChatRoomJoinDTO joinDto);

	List<ChatRoomDTO> selectChatroom();


}
