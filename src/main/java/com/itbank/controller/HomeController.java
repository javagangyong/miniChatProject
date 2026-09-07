package com.itbank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.ChatRoomDTO;
import com.itbank.service.ChatService;
import com.itbank.service.MemberService;

@Controller
public class HomeController {

	@Autowired private MemberService ms;
	@Autowired private ChatService cs;
	
	@RequestMapping("/")
	public ModelAndView home(HttpSession session) {
		ModelAndView mav = new ModelAndView("home");
		Integer dologin = (Integer) session.getAttribute("dologin");
		if(dologin != null) {			
			session.removeAttribute("dologin");
		}
		return mav;
	}
	
	@GetMapping("/alert")
	public String alert() {
		return "alert";
	}
	
}
