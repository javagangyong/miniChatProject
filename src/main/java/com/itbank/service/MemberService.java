package com.itbank.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.HashComponent;
import com.itbank.component.TestMailComponent;
import com.itbank.model.MemberDTO;
import com.itbank.repository.MemberDAO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO dao;
	@Autowired
	private HashComponent hash;
	@Autowired
	private TestMailComponent mail;
	
	private String saveDirectory = "C:\\upload";

	public int join(MemberDTO dto) {
		return dao.join(dto);
	}

	public int check(String userid) {
		return dao.check(userid);
	}

	public MemberDTO selectOne(MemberDTO dto) {
		return dao.selectOne(dto);
	}

	public MemberDTO selectCheck(MemberDTO dto) {
		return dao.selectCheck(dto);
	}

	public String resetPass(MemberDTO dto) {
		String newPassword = UUID.randomUUID().toString().replace("-", "").substring(0, 8);
//	      String hash = hashComponent.getHash(newPassword);
//	      
//	      System.out.println("newPassword : " + newPassword);
//	      System.out.println("hash : " + hash);
//	      
//	      dto.setUserpw(hash);
		int row = dao.updatePassword(dto);
		return row != 0 ? newPassword : null;
	}



	public MemberDTO selectOneById(String userid) {
		return dao.selectOneById(userid);
	}

	public List<MemberDTO> selectList() {
		return dao.selectList();
	}

	public int mpModify(MemberDTO dto) {
		int row = dao.update(dto);
		return row;
	}


	public int newPw(MemberDTO dto) {
		String hashPass = hash.getHash(dto.getUserpw());
		dto.setUserpw(hashPass);
		int row = dao.pwUpdate(dto);
		return row;
	}

	public MemberDTO memberOne(int idx) {
		return dao.memberOne(idx);
	}

	public int memberDelete(MemberDTO dto) {
		String hashPass = hash.getHash(dto.getUserpw());
		dto.setUserpw(hashPass);
		return dao.memberDelete(dto);
	}

	public int updateLastLogin(String userid) {
		return dao.updateLastLogin(userid);
	}


	// 아이디 찾기
	public String findID(MemberDTO dto) {
		// 데이터베이스에서 사용자의 아이디를 찾는 쿼리를 실행하여 결과를 가져옵니다.
		String userId = dao.findUserId(dto);

		if (userId != null) {
			// 사용자의 아이디가 존재하는 경우에는 해당 아이디를 반환합니다.
			return userId;
		} else {
			// 사용자의 아이디가 존재하지 않는 경우를 처리할 수 있는 방법에 따라 적절한 처리를 수행합니다.
			// 예를 들어, 사용자에게 존재하지 않는 아이디임을 알리는 메시지를 반환하거나, 특정 값을 반환할 수 있습니다.
			return "not_found";
		}
	}

	public String resetPassword(MemberDTO dto) {
		String newPassword = generateRandomPassword(); // 임시 비밀번호 생성
		String hashedPassword = hash.getHash(newPassword); // 비밀번호를 해시화

		// 비밀번호 업데이트
		dto.setUserpw(hashedPassword);
		int result = dao.newPw(dto);

		// 비밀번호 업데이트 성공하면 임시 비밀번호 반환
		return result != 0 ? newPassword : null;
	}

	// 임시 비밀번호 생성 메서드
	private String generateRandomPassword() {
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder newPassword = new StringBuilder();
		for (int i = 0; i < 8; i++) {
			int index = (int) (Math.random() * characters.length());
			newPassword.append(characters.charAt(index));
		}
		return newPassword.toString();
	}


	public List<String> getProfiles(String gender) {
		return dao.getProfiles(gender);
	}

	public int getMemberCount() {
		return dao.getMemberCount();
	}

}