package com.itbank.model;

import java.sql.Date;

//MSGNO          NOT NULL NUMBER         
//ROOMNO         NOT NULL NUMBER         
//SENDERID       NOT NULL VARCHAR2(100)  
//MESSAGECONTENT NOT NULL VARCHAR2(4000) 
//UNREADCOUNT             NUMBER         
//SENDTIME                DATE 

public class ChatMessageDTO {

	private int msgNo;
	private int roomNo;
	private String senderId;
	private String messageContent;
	private int unreadCount;
	private Date sendTime;
	
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getSenderId() {
		return senderId;
	}
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public int getUnreadCount() {
		return unreadCount;
	}
	public void setUnreadCount(int unreadCount) {
		this.unreadCount = unreadCount;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	
}
