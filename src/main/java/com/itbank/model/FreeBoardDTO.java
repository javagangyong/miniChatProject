package com.itbank.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

//이름        널?       유형             
//--------- -------- -------------- 
//IDX       NOT NULL NUMBER         
//TITLE     NOT NULL VARCHAR2(100)  
//CONTENT   NOT NULL VARCHAR2(2000) 
//WRITER    NOT NULL VARCHAR2(50)   
//WRITEDATE          DATE 

public class FreeBoardDTO {
	private int idx;
	private String title;
	private String content;
	private String writer;
	private Date writeDate;
	private String img;
	
	private MultipartFile upload;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
	
}
