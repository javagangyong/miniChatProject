package com.itbank.model;

import java.sql.Date;

//JOINNO        NOT NULL NUMBER        
//ROOMNO        NOT NULL NUMBER        
//USERID        NOT NULL VARCHAR2(100) 
//ISWATCHING             CHAR(1)       
//LASTREADMSGNO NOT NULL NUMBER        
//JOINDATE               DATE  

public class ChatRoomJoinDTO {

	private int joinNo;
	private int roomNo;
	private String userid;
	private String isWatching;
	private int lastReadMsgNo;
	private Date joinDate;
	
	public int getJoinNo() {
		return joinNo;
	}
	public void setJoinNo(int joinNo) {
		this.joinNo = joinNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getIsWatching() {
		return isWatching;
	}
	public void setIsWatching(String isWatching) {
		this.isWatching = isWatching;
	}
	public int getLastReadMsgNo() {
		return lastReadMsgNo;
	}
	public void setLastReadMsgNo(int lastReadMsgNo) {
		this.lastReadMsgNo = lastReadMsgNo;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
}
