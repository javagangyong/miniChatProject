package com.itbank.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.FreeBoardDTO;
import com.itbank.model.FreeBoardReplyDTO;
import com.itbank.repository.FreeBoardDAO;

@Service
public class FreeBoardService {

	@Autowired FreeBoardDAO dao;
	private String saveDirectory = "C:\\upload";

	public int fbWrite(FreeBoardDTO dto) {
		String img = dto.getUpload().getOriginalFilename();
		File f = new File(saveDirectory, img);
		try {
			dto.getUpload().transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		dto.setImg(img);
		
		return dao.insertFreeBoard(dto);
	}

	public List<FreeBoardDTO> fbList(Map<String, Object> map) {
		List<FreeBoardDTO> fbList = dao.selectList(map);
		return fbList;
	}

	public FreeBoardDTO fbView(int idx) {
		return dao.selectOne(idx);
	}

	public int fbReply(FreeBoardReplyDTO dto) {
		return dao.insertReply(dto);
	}

	public List<FreeBoardReplyDTO> selectList(int board_idx) {
		return dao.selectReplyList(board_idx);
	}

	public int boardCount(String search) {
		return dao.countFreeBoard(search);
	}
	
}
