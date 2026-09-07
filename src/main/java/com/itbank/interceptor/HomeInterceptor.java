package com.itbank.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.itbank.model.MemberDTO;
import com.itbank.service.MemberService;

public class HomeInterceptor implements HandlerInterceptor {
	
	@Autowired private MemberService ms;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("login");
				
		if(login == null) {
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie c : cookies) {
					if(c.getName().equals("save")) {
						MemberDTO dto = ms.selectOneById(c.getValue());
						session.setAttribute("login", dto);
						break;
					}
				}	
			}
		}
		
		return true;
	}
}
