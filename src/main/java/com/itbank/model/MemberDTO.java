package com.itbank.model;

import java.sql.Date;

//이름         널?       유형            
//---------- -------- ------------- 
//USERID     NOT NULL VARCHAR2(100) 
//USERPW     NOT NULL VARCHAR2(200) 
//NICKNAME   NOT NULL VARCHAR2(100) 
//PROFILEIMG          VARCHAR2(300) 
//EMAIL      NOT NULL VARCHAR2(200) 
//ONLINEYN            CHAR(1)       
//ENROLLDATE          DATE   


public class MemberDTO {
	
	private String userid;
	private String userpw;
	private String nickname;
	private String profileImg;
	private String email;
	private String onlineYN;
	private Date enrollDate;
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOnlineYN() {
		return onlineYN;
	}
	public void setOnlineYN(String onlineYN) {
		this.onlineYN = onlineYN;
	}
	public Date getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}
	
}
