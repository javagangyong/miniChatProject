package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.MemberDTO;
import com.itbank.service.MemberService;

@RestController
@RequestMapping("/memberAjax")
public class MemberAjaxController {

	@Autowired MemberService ms;
	
	@GetMapping("/selectOne")
	public MemberDTO selectOne(@RequestParam("userid") String userid) {
		MemberDTO dto = ms.selectOneById(userid);
		return dto;
	}
	
}
