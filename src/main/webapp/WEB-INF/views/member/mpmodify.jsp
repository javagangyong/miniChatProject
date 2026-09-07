<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
	header {
		color: black;
	}
	
	section {
		padding-top: 95px;
		width: 100%;
		height: 920px;
		display: flex;
		justify-content: center;
	}
	
	.mpmodify_inner {
		width: 700px;
		margin-top: 150px;
	}
	
	#mpmodifyForm {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
	}
	
	.inputframe {
		width: 500px;
		height: 60px;
		border: 1px solid lightgrey;
		box-sizing: border-box;
		padding: 5px 10px;
		font-size: 16px;
	}
	
	label {
		width: 248px;
		height: 50px;
		border: 1px solid lightgrey;
		position: relative;
		color: lightgray;
	}
	
	label:first-child {
		margin-right: 5px;
	}
	
	input[type="radio"] {
		all: unset;
		display: inline-block;
		position: absolute;
		width: 250px;
		height: 50px;
	}
	
	input[type="radio"]:checked + span {
		background-color: blue;
	}
	
	.radiotext {
		position: absolute;
		display: flex;
		width: 250px;
		height: 50px;
		justify-content: center;
		align-items: center;
	}
	
	#mpmodifyBtn {
		margin-top: 20px;
		width: 400px;
		height: 50px;
		border: 1px solid lightgrey;
		background-color: blue;
		font-size: 20px;
		color: white;
		text-align: center;
		font-weight: bold;
	}
	
	button:hover {
		cursor: pointer;
	}
	
	#mpmodifyBtn:disabled {
		background-color: lightgrey;
		cursor: not-allowed;
	}
	
	#mpmodifyForm > * {
		margin-top: 15px;
	}

	p {
		margin: 0;
		margin-top: 5px;
	}
	
	
</style>

<section>
	<div class="mpmodify_inner">
		<h1 align="center">회원 정보 수정</h1>
		<div>
			<form method="POST" id="mpmodifyForm">
				<input class="inputframe" type="text" value="${login.userid }" name="userid" readonly required>
				<input class="inputframe" type="password" name="userpw" placeholder="패스워드" required> 
				<input class="inputframe" type="text" value="${login.username }" name="username" placeholder="이름" required>
				<div style="display: flex;">				
					<label>
						<input type="radio" name="gender" value="남성" 
							${login.gender == '남성' ? 'checked' : '' } required> 
						<span class="radiotext">남성</span>			
					</label> 
					<label>
						<input type="radio" name="gender" value="여성" 
						${login.gender == '여성' ? 'checked' : '' }  required> 
						<span class="radiotext">여성</span>		
					</label>
				</div>
				<input class="inputframe" type="date" value="${login.birthDay }" name="birthDay" placeholder="생년월일" required>
				<input class="inputframe" type="text" value="${login.phoneNumber }" name="phoneNumber" placeholder="전화번호" required>
				<button id="mpmodifyBtn" disabled>정보수정</button>
			</form>
		</div>
	</div>
</section>


</body>
</html>