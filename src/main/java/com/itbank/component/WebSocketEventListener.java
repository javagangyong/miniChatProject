package com.itbank.component;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class WebSocketEventListener{
	
	
	  // 유저가 웹소켓에 처음 연결했을 때 실행되는 메서드
	  @EventListener 
	  public void handleWebSocketConnectListenser(SessionConnectedEvent event) { 
		  
		  // 이벤트 메시지에서 STOMP 헤더 정보(돋보기)를 추출 
		  StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
		  
		  // 현재 연결된 유저 전화선의 고유 번호(Session ID)를 가져옴 
		  String sessionId = headerAccessor.getSessionId();
		  
		  log.info("[STOMP Connected] 새로운 웹소켓 세션 연결 완료 - Session ID: {}", sessionId);
	  
	  }
	  
	  
	  // 유저의 웹소켓 연결이 끊겼을 때(브라우저 닫기, 와이파이 끊김 등) 실행되는 메서드
	  @EventListener 
	  public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) { 
		  
		  // 헤더 정보 추출
		  StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
		  
		  // 끊어진 유저 전화선의 고유 번호 가져오기 
		  String sessionId = headerAccessor.getSessionId();
		  
		  log.warn("[STOMP Disconnected] 웹소켓 세션 연결 끊김 - Session ID: {}", sessionId);
	  
	  }
	 
	 

}
