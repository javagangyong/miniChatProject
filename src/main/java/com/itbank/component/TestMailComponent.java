package com.itbank.component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;
import java.util.Scanner;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Component
public class TestMailComponent {

	// 접속 정보, 우체국 주소와 신분증
	private final String host = "smtp.gmail.com";
	private final int port = 465;
	private String serverId = "kenjisun123";
	private String serverPw = "rsblvfduzojpcryr";
	
	// 우체국 환경설정, 우체국 이용 규칙 모음집
	private Properties props;
	
	// 편지지
	@Value("classpath:mail/testMailForm.html")
	private Resource testMailForm;
	
	// 1단계: 환경설정 미리 해두기(init() 메서드)
	// 객체가 만들어지자마자 딱 1번 실행되는 초기화 메서드. PostConstruct
	// 우체국 환경설정에 우체국주소, 포트 등 값 입력
	@PostConstruct
	private void init() {
		props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
	}
	
	public int sendMimeMessage(HashMap<String, String> param) {
		// 2단계: 로그인 및 통신 연결하기(Sessiom 생성)
		// 통신세션, 구글 우체국과 연결통로
		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
			// Authenticator은 아이디, 비밀번호를 미리 쥐고있는 '인증대리인'
			String un = serverId;
			String pw = serverPw;
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// 서버에 아이디 비밀번호 제출
				return new PasswordAuthentication(un, pw);
			}
		});
		// 통신하는 모든 과정을 콘솔창에 보여준다(true)
		mailSession.setDebug(true);
	
		
		// 3단계: 편지 봉투 작성하기(MimeMessage)
		// 편지 봉투, 실제 발송할 편지 객체
		Message message = new MimeMessage(mailSession); // 구글과 연결된 세션을 바탕으로 빈 메일 객체 생성
		String address = param.get("address");
		String subject = param.get("subject");
		String content = param.get("content");
		
		try {
			// 인터넷 메일 주소 형식인 InternetAddress. 봉투 겉면에 보내는 사람 등등을 적는다.
			message.setFrom(new InternetAddress(serverId + "@gmail.com"));	// 보내는 사람
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(address));	// 받는사람
			message.setSubject(subject);
			
			
			// 4단계: HTML 편지지 읽어서 인증번호 집어넣기
			String tag = "";
			Scanner sc = new Scanner(testMailForm.getFile());
			while(sc.hasNextLine()) {
				tag += sc.nextLine();
			}
			sc.close();
			content = String.format(tag, content);
			message.setContent(content, "text/html; charset=utf-8");
			
			// 우체부
			Transport.send(message);
			 return 1;
		} catch (MessagingException | IOException e) {
			e.printStackTrace();
			return 0;
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
