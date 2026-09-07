package com.itbank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/testMember")
public class TestMemberController {
	
	@GetMapping("/testMypage")
	public void testMypage() {}
	
	@GetMapping("/testJoin")
	public void testJoin() {}

}
