package com.itbank.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

//import com.itbank.model.MessageDTO;

@Controller
public class TestStompController {
	
//	@MessageMapping("/testTryMatch/{respUser}")
//	@SendTo("/broker/{respUser}")
//	public MessageDTO testTryMatch(MessageDTO dto) {
//		dto.setText(dto.getTime() + "님이 요청을 보내왔습니다!");
//		return dto;
//	}

}
