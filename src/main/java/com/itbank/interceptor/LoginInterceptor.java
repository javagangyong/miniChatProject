package com.itbank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.itbank.model.MemberDTO;
import com.itbank.service.MemberService;


public class LoginInterceptor implements HandlerInterceptor {
   
   
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
      HttpSession session = request.getSession();
      String url = request.getRequestURI();
      String cpath = request.getContextPath();
      MemberDTO login = (MemberDTO) session.getAttribute("login");
//      if(login == null) {
//         response.sendRedirect(cpath + "/member/login");
//      }
      // 접근하려는 URL이 마이멤버십 페이지인지 확인
        if ((url.contains("/membership/myMembership") && login == null) || login == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            response.sendRedirect(cpath + "/member/login");
            return false; // 이후의 요청 처리를 중단
        }
       
      
      return true;
   }
}