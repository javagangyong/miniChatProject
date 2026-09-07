package com.itbank.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.component.TestMailComponent;
import com.itbank.model.MemberDTO;
import com.itbank.service.TestMemberService;

@RestController
@RequestMapping("/testMemberAjax")
public class TestMemberAjaxController {
	
	public Random ran = new Random();
	
	@Autowired TestMemberService tms;
	@Autowired TestMailComponent tmc;
	
	
	@PostMapping("/infoModify")
	public String infoModify(@RequestBody MemberDTO dto) {
		int row = tms.updateInfo(dto);
		if(row == 1) {
			return "정보 수정 완료. 다시 로그인 해주세요.";
		}
		return "정보 수정 실패. 관리자에 문의하세요.";
	}
	
	@PostMapping("/pwModify")
	public String pwModify(@RequestBody MemberDTO dto) {
		int row = tms.updatePw(dto);
		return row != 1 ? "비밀번호 변경 실패. 관리자에 문의하세요." : "비밀번호 변경. 다시 로그인 해주세요.";
	}
	
	@PostMapping("/testEmailSend")
	public int testEmailSend(@RequestBody HashMap<String, String> param, HttpSession session) {
		int num = ran.nextInt(999999);
		String authNumber = String.format("%06d", num);
		
		session.setAttribute("authNumber", authNumber);
		session.setMaxInactiveInterval(300);
		
		param.put("subject", "[듀세요] 회원가입 인증번호");
		param.put("content", authNumber);
		
		int row = tmc.sendMimeMessage(param);
		System.out.println("메일 잘 보내짐 숫자는 " + row);
		return row;
	}
	
	@GetMapping("/authNumberCheck")
	public int authNumberCheck(@RequestParam String checkNumber, HttpSession session) {
		String authNumber = (String) session.getAttribute("authNumber");
		if(checkNumber.equals(authNumber)) {
			return 1;
		} else {
			return 0;
		}
	}

}
