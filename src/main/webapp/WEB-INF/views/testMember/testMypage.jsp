<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	section {
		height: 1000px;
		padding-top: 95px;
	}
	button {
	  background: none;     /* 배경색 투명하게 */
	  border: none;         /* 테두리 없애기 */
	  padding: 0;           /* 기본 여백 없애기 */
	  font: inherit;        /* 부모 글꼴 스타일 그대로 물려받기 */
	  cursor: pointer;      /* 마우스 올렸을 때 손가락 모양으로 바꾸기 (★중요) */
	  outline: none;        /* 클릭했을 때 생기는 파란 테두리 제거 */
	}
	div.container {
		display: flex;
		gap: 50px;
		height: 100%;
	}
	.bar {
		width: 250px;
		background-color: #EFEBE6;
	}
	.mainContent {
/* 		flex: 5; */
	}
	div.asideTitle {
		font-weight: bold;
		font-size: 20px;
		text-align: center;
		margin-top: 50px;
	}
	div.item {
		margin-top: 20px;
		display: flex;
		justify-content: center;
	}
	div.item:hover {
		cursor: pointer;
		transform: translateY(-2px);
	}
	div.item.selected {
		font-weight: bold;
		color: #FD2B75;
	}
	div.picture {
		width: 400px;
		height: 300px;
		background-position: center;
		background-size: 100%;
	}
	.mypageString {
		font-size: 14px;
		color: #6699CC;
		margin-bottom: 0px;
	}
	div.mypageBox {
		width: 400px;
		height: 50px;
		border: 1px solid #4E5154;
		display: flex;
		align-items: center;
	}
	div.boxMargin {
		margin-bottom: 15px;
	}
	input[type="radio"] {
		display: none;
	}
	label {
		display: flex;
		justify-content: center;
		align-items: center;
		cursor: pointer;
		border: 1px solid #ccc;
		width: 195px;
		height: 35px;
		margin-right: 8px;
	}
	div.flexBox {
		display: flex;
	}
	label:has(input[type="radio"]:checked) {
		background-color: #4A90E2;
		color: #FFFFFF;
	}
	.textBox {
		display: block;
		width: 400px;
		height: 50px;
		border: 1px solid #ccc;
		padding: 0;
		margin-bottom: 15px;
	}
	select {
		display: block;
		border: 1px solid #ccc;
		width: 127px;
		height: 40px;
		margin: 15px 10px 15px 0;
	}
	button {
		/* 1. 기본 배경 및 테두리 제거 */
		background: none;
		border: none;
		outline: none;
		box-shadow: none;
		
		/* 2. 여백 및 패딩 초기화 */
		padding: 0;
		margin: 0;
		
		/* 3. 폰트 속성 부모(상위 요소) 상속 */
		font-family: inherit;
		font-size: inherit;
		color: inherit;
		
		/* 4. 클릭 가능한 요소임을 명시 */
		cursor: pointer;
	}
	.btn-base {
		width: 400px;
		height: 50px;
		margin-bottom: 15px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#infoSubmit {
		background-color: #2563eb;
		color: #ffffff;
		border: 1px solid #1d4ed8;
	}
	#infoSubmit:hover {
		background-color: #1d4ed8;
		border-color: #1e40af;
	}
	#pwModify {
		background-color: #f3f4f6;
		color: #1f2937;
		border: 1px solid #d1d5db;
	}
	#pwModify:hover {
		background-color: #e5e7eb;
		border-color: #9ca3af;
	}
	#btn-delete-account {
		background-color: #fef2f2;
  		color: #dc2626;
  		border: 1px solid #fecaca;		
	}
	#btn-delete-account:hover {
		background-color: #fee2e2;
		border-color: #fca5a5;
	}
	div.sectionBox {
		width: 700px;
		margin-top: 100px;
		margin-left: 8%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	#changePwForm {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	#pw-submit-btn {
  		background-color: #2563EB; /* 메인 파랑 */
  		color: #FFFFFF;            /* 글자색 흰색 */
  		border: 1px solid #1D4ED8; /* 배경보다 살짝 어두운 테두리 */
  		transition: all 0.2s ease; /* Hover 효과 부드럽게 */
	}
	#pw-submit-btn:hover {
  		background-color: #1D4ED8; /* Hover 시 톤다운되어 묵직해짐 */
  		border-color: #1E40AF;
	}
	#pw-cancle-btn {
  		background-color: #F3F4F6; /* 은은한 연회색 */
  		color: #374151;            /* 짙은 진회색 글자 */
  		border: 1px solid #D1D5DB; /* 또렷한 연회색 테두리 */
  		transition: all 0.2s ease;
	}
	#pw-cancle-btn:hover {
  		background-color: #E5E7EB; /* Hover 시 살짝 어두워짐 */
  		border-color: #9CA3AF;
  		color: #111827;
	}
	.pw-message-error {
  		color: #DC2626; /* 선명하면서도 차분한 딥 레드 */
  		font-size: 13px; /* 보조 문구에 적합한 크기 */
  		font-weight: 500;
	}
	.pw-message-success {
  		color: #2563EB; /* 신뢰감을 주는 모던 블루 */
  		font-size: 13px;
  		font-weight: 500;
	}
	
</style>

<section>

<div class="container">
	<aside class="bar">
		<div class="asideTitle">마이페이지</div>	
		<div class="item" id="myProfile">내 프로필</div>	
		<div class="item" id="infoUpdate">내 정보 수정</div>	
		<div class="item">스펙 수정</div>	
	</aside>
	
	<div class="mainContent"></div>
</div>

</section>


<script>
	const joinDate = '${login.joinDate}';
	const lastLoginDate = '${login.lastLoginDate}';
	const birthYear = '${login.birthYear}';
	const birthMonth = '${login.birthMonth}';
	const birthDay = '${login.birthDay}';
	const phoneNumber = '${login.phoneNumber}'

	const myProfile = document.getElementById('myProfile');
	
	myProfile.addEventListener('click', async (event) => {
		
		const items = document.querySelectorAll('.item');
		items.forEach(e => e.classList.remove('selected'));
		event.target.classList.add('selected')
		
		const mainContent = document.querySelector('.mainContent');
		const url = cpath + '/testMemberAjax/myProfile/' + user;
		const info = await fetch(url).then(resp => resp.json());
		let tag = '';
		tag += '<h1 align="center">내 프로필</h1>';
		tag += '<h2>프로필 사진</h2>';
		tag += '<div class="picture" style="background-image: url(\'' + cpath + '/upload/' + info.profile + '\')"></div>';
		tag += '<p class="mypageString">이름</p>';
		tag += '<div class="mypageBox">' + info.username + '</div>';
		tag += '<p class="mypageString">등급</p>';
		tag += '<div class="mypageBox">' + info.grade + '</div>';
		tag += '<p class="mypageString">아이디</p>';
		tag += '<div class="mypageBox">' + info.userid + '</div>';
		tag += '<p>가입한 날짜 : ' + joinDate + '</p>';
		tag += '<p>최근 접속 한 날짜 : ' + lastLoginDate + '</p>';
// 		tag += '';
		mainContent.innerHTML = tag;
		
	})
	
	const infoUpdate = document.getElementById('infoUpdate');
	
	infoUpdate.addEventListener('click', async (event) => {
		
		const items = document.querySelectorAll('.item');
		items.forEach(e => e.classList.remove('selected'));
		event.target.classList.add('selected')
		
		const mainContent = document.querySelector('.mainContent');
		
		let tag = '';
		tag += '<h1>회원 정보 수정</h1>';
		tag += '<form id="infoForm">'
		tag += '	<input type="text" class="textBox" name="userid" value="'+ user +'" required readonly>';
		tag += '	<input type="text" class="textBox" name="username" value="'+ username +'" required>';
		tag += '	<div class="flexBox">'
		tag += '		<label><input type="radio" name="gender" ' + (gender == '남성' ? 'checked' : '') +
				' 			value="남성" required>남성</label>';
		tag += '		<label><input type="radio" name="gender" ' + (gender == '여성' ? 'checked' : '') +
				' 			value="여성" required>여성</label>';
		tag += '	</div>';
		
		tag += '	<div class="flexBox">';
		tag += '		<select name="birthYear">'
		tag += '			<option value="">출생년</option>'
		for(let year = 2007; year >= 1944; year--) {
			tag += '		<option value="'+ year +'"'+ (year == birthYear ? " selected" : "") +'>'+ year +'년</option>'
			}
		tag += '		</select>'
		
		tag += '		<select name="birthMonth">'
		tag += '			<option value="">월</option>'
		for(let month = 1; month <= 12; month++) {
			tag += '		<option value="'+ month +'"'+ (month == birthMonth ? " selected" : "") +'>'+ month +'월</option>'
			}
		tag += '		</select>'
		
		tag += '		<select name="birthDay">'
		tag += '			<option value="">일</option>'
		for(let day = 1; day <= 31; day++) {
			tag += '		<option value="'+ day +'"'+ (day == birthDay ? " selected" : "") +'>'+ day +'일</option>'
			}
		tag += '		</select>'
		tag += '	</div>';
		
		tag += '	<input type="text" class="textBox" name="phoneNumber" value="'+ phoneNumber +'" required>'
		tag += '	<button id="infoSubmit" type="submit" class="btn-base">정보 수정</button>'
		tag += '	<button id="pwModify" type="button" class="btn-base">비밀번호 변경</button>'
		tag += '	<button id="btn-delete-account" type="button" class="btn-base">회원 탈퇴</button>'
		tag += '</form>'
		
		mainContent.innerHTML = tag;
		
		// 정보수정 버튼
		const infoForm = document.getElementById('infoForm');
		infoForm.addEventListener('submit', async(e) => {
			e.preventDefault();
			const url = cpath + '/testMemberAjax/infoModify';
			const formData = new FormData(e.target);
			const ob = {}
			for(let key of formData.entries()) {
				ob[key[0]] = key[1];
			}
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type' : 'application/json;charset=utf-8'
					}
			}
			const message = await fetch(url, opt).then(resp => resp.text());
			alert(message);
			location.href = cpath + '/member/logout?mypage=1';
		})
		
		// 비밀번호 변경 버튼
		const pwModifyBtn = document.getElementById('pwModify');
		pwModifyBtn.addEventListener('click', async(e) => {
			mainContent.innerHTML = '';
			let tag = '';
			tag += '<div class="sectionBox">';
			tag += '	<h1>비밀번호 변경</h1>';
			tag += '	<form id="changePwForm">';
			tag += '		<input type="password" class="textBox" name="userpw" placeholder="새 비밀번호">';
			tag += '		<p id="pwLengthCheck" class="pw-message-success">비밀번호는 8글자 이상 15글자 이하의 영문자 + 숫자로만 조합할 수 있습니다.</p>';
			tag += '		<input id="pwInput2" type="password" class="textBox" placeholder="새 비밀번호 확인">';
			tag += '		<p id="pwCheckFalse" class="pw-message-error hidden">비밀번호와 비밀번호 확인이 일치하지 않습니다.</p>';
			tag += '		<p id="pwCheckTrue" class="pw-message-success hidden">비밀번호와 비밀번호 확인이 일치합니다.</p>';
			tag += '		<input type="hidden" value="'+ user +'" name="userid">'
			tag += '		<button type="submit" id="pw-submit-btn" class="btn-base" disabled>확인</button>';
			tag += '		<button type="button" id="pw-cancle-btn" class="btn-base">취소</button>';
			tag += '	</form>';
			tag += '</div>';
			mainContent.innerHTML = tag;
			
			const pwSubmitBtn = document.getElementById('changePwForm').querySelector('#pw-submit-btn');
			// 비밀번호 특정조건 만족
			function CheckPwHandler(event) {
				const password = event.target.value;
				const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,15}$/;
				const result = regex.test(password);
				
				const pwLengthCheck = document.getElementById('pwLengthCheck');
				if(result) {
					pwLengthCheck.classList.add('hidden');
				} else {
					pwLengthCheck.classList.remove('hidden');
				}
			}
			
			const pwInput1 = document.getElementById('changePwForm').querySelector('input[name="userpw"]');
			// key하나하나 손가락뗄때마다 함수 실행
			pwInput1.addEventListener('keyup', CheckPwHandler);
			
			
			// 비밀번호 일치
			function ConfirmPwHandler(event) {
				const confirmPw = event.target.value;		// 두번째 비밀번호 입력값
				const pwInput1Value = pwInput1.value;		// 첫번째 비밀번호 입력값
				const pwCheckFalse = document.getElementById('changePwForm').querySelector('#pwCheckFalse');
				const pwCheckTrue = document.getElementById('changePwForm').querySelector('#pwCheckTrue');
				const pwSubmitBtn = document.getElementById('changePwForm').querySelector('#pw-submit-btn');
				
				// 두번째 비밀번호 입력값도 비밀번호 특정조건 만족 했는지
				const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,15}$/;
				const result = regex.test(confirmPw);
				
				// 특정조건 만족 && 첫번째 두번째값 일치 && 빈값이 아닌지
				const isMatch = result && (confirmPw === pwInput1Value) && (confirmPw !== "");
				
				if(isMatch) {
					pwCheckTrue.classList.remove('hidden');
					pwCheckFalse.classList.add('hidden');
					pwSubmitBtn.disabled = false;
				} else {
					pwCheckFalse.classList.remove('hidden');
					pwCheckTrue.classList.add('hidden');
					pwSubmitBtn.disabled = true;
				}
			}
			
			const pwInput2 = document.getElementById('changePwForm').querySelector('#pwInput2');
			pwInput2.addEventListener('keyup', ConfirmPwHandler);
			
			
			// 비밀번호 변경 확인 버튼
			const pwSubmitForm = document.getElementById('changePwForm');
			pwSubmitForm.addEventListener('submit', async (e) => {
				e.preventDefault();
				
				const url = cpath + '/testMemberAjax/pwModify';
				const ob = {
						userpw: e.target.querySelector('input[name="userpw"]').value,
						userid: e.target.querySelector('input[name="userid"]').value
				}
				const opt = {
						method : 'POST',
						body : JSON.stringify(ob),
						headers : {
							'Content-Type' : 'application/json;charset=utf-8'
						}
				}
				const message = await fetch(url, opt).then(resp => resp.text());
				alert(message);
				location.href = cpath + '/member/logout?mypage=1';
			})
			
			// 취소버튼
			const pwCancleBtn = document.getElementById('changePwForm').querySelector('#pw-cancle-btn');
			pwCancleBtn.addEventListener('click', () => {
				history.back();
			})
			
			
		})
		
		
		
	})
	
	// 마이페이지 들어왔을때 마이프로필이 뜨도록
	myProfile.dispatchEvent(new Event('click'));
	
	
	
	
</script>