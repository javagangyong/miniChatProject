package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.HashComponent;
import com.itbank.model.MemberDTO;
import com.itbank.repository.TestMemberDAO;

@Service
public class TestMemberService {
	
	@Autowired TestMemberDAO dao;
	@Autowired HashComponent hash;


	public int updateInfo(MemberDTO dto) {
		return dao.updateInfo(dto);
	}

	public int updatePw(MemberDTO dto) {
		String hashPass = hash.getHash(dto.getUserpw());
		dto.setUserpw(hashPass);
		return dao.updatePw(dto);
	}

}
