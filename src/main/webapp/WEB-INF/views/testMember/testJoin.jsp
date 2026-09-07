<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	section {
		height: 1000px;
		padding-top: 95px;
	}
	div.innerBlock {
		margin: 200px 0 0 300px;
	}
	div.authNumerMention1 {
		color: red;
	}
	div.authNumerMention2, div.emailSendMention {
		color: blue;
	}
	.marginBox {
		margin: 5px 0 0 300px;
	}
	
</style>

<section>
	<div class="innerBlock">
		<form onSubmit="testEmailHandler(event)">
			<input type="email" name="email" placeholder="이메일">
			<button>보내기</button>
		</form>
	</div>
	<div class="emailSendMention marginBox hidden">인증번호를 발송하였습니다</div>
	
	<form id="numberCheckForm" class="hidden marginBox">
		<input type="text" name="numberCheck" placeholder="인증번호 확인">
		<button>확인</button>
	</form>
	<div class="authNumerMention1 marginBox hidden">인증 실패</div>
	<div class="authNumerMention2 marginBox hidden">인증 성공</div>
	
	
	
	
</section>


<script>
//	이메일로 인증번호 보내기
	async function testEmailHandler(event) {
		event.preventDefault();
		
		const url = cpath + '/testMemberAjax/testEmailSend';
		const ob = {address: event.target.email.value}
		const opt = {
				method: 'POST',
				body: JSON.stringify(ob),
				headers: {
					'Content-Type': 'application/json;charset=utf-8'
				}
		}
		
		const result = await fetch(url, opt).then(resp => resp.text());
		if(result === '1') {
			const numberCheckForm = document.getElementById('numberCheckForm')
			const emailSendMention = document.querySelector('.emailSendMention')
			
			numberCheckForm.classList.remove('hidden')
			emailSendMention.classList.remove('hidden')
		} else {
			alert('메일 전송 실패')
		}
	}
	
//	인증번호 확인
	const numberCheckForm = document.getElementById('numberCheckForm');
	numberCheckForm.addEventListener('submit', async (e) => {
		e.preventDefault();
		const numberCheck = document.querySelector('input[name="numberCheck"]');
		const url = cpath + '/testMemberAjax/authNumberCheck?checkNumber=' + numberCheck.value;

		const result = await fetch(url).then(resp => resp.text());
		const authNumerMention1 = document.querySelector('.authNumerMention1');
		const authNumerMention2 = document.querySelector('.authNumerMention2');
		
		if(result == 1) {
			authNumerMention2.classList.remove('hidden')
			authNumerMention1.classList.add('hidden')
		} else {
			authNumerMention1.classList.remove('hidden')
			authNumerMention2.classList.add('hidden')
		}
		
	})



</script>