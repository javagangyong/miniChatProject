package com.itbank.model;

import java.sql.Date;

//ROOMNO       NOT NULL NUMBER        
//ROOMTITLE    NOT NULL VARCHAR2(200) 
//MAXUSERCOUNT          NUMBER        
//ROOMTYPE              VARCHAR2(100) 
//CREATEDATE            DATE    

public class ChatRoomDTO {
	
	private int roomNo;
	private String roomTitle;
	private int maxUserCount;
	private String roomType;
	private Date createDate;
	
	
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getRoomTitle() {
		return roomTitle;
	}
	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public int getMaxUserCount() {
		return maxUserCount;
	}
	public void setMaxUserCount(int maxUserCount) {
		this.maxUserCount = maxUserCount;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
