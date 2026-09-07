<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
	body, html {
		height: 100%;
		margin: 0;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	aside {
		position: fixed;
		top: 100px;
		left: 0;
		width: 15%;
		height: 100%;
		/*    background-color: lightgray; */
		box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
		/*    z-index: 3; */
		transition-duration: 0.5s;
	}
	
	aside>* {
		margin: 20px;
	}
	
	#root {
		display: flex;
		width: 156px;
		padding: 0;
	}
	
	aside>div.item {
		text-align: center;
		height: 30px;
		border-bottom-color: white;
	}
	
	aside>div.item.selected {
		font-weight: bold;
		color: #FD2B75;
	}
	
	aside>div.item:hover {
		cursor: pointer;
		background-color: #FB4357;
		color: white;
	}
	
	div.content {
		position: relative;
		top: 150px;
		left: -100%;
		justify-content: center;
		align-items: center;
	}
	
	mpmodify {
		padding-top: 95px;
		width: 100%;
		height: 920px;
		display: flex;
		justify-content: center;
	}
	
	.mpmodify_inner {
		width: 700px;
		margin-top: 80px;
		margin-bottom: 150px;
	}
	
	#mpmodifyForm {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
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
	
	input[type="radio"]:checked+span {
		background-color: #105dae;
	}
	
	.radiotext {
		position: absolute;
		display: flex;
		width: 250px;
		height: 50px;
		justify-content: center;
		align-items: center;
	}
	
	button:hover {
		cursor: pointer;
	}
	
	#mpmodifyBtn:disabled {
		background-color: lightgrey;
		cursor: not-allowed;
	}
	
	#mpmodifyForm>* {
		margin-top: 15px;
		width: 501px;
	}
	
	p {
		margin: 0;
		margin-top: 5px;
	}
	
	.birthday>select {
		width: 165px;
		height: 50px;
		border: 1px solid lightgrey;
		position: relative;
	}
	
	.modifyBtn {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
	}
	
	#mpmodifyBtn, #pwmodifyBtn, #specmodifyBtn, #withdrawBtn {
		margin-top: 20px;
		width: 400px;
		height: 50px;
		border: 1px solid lightgrey;
		background-color: #105dae;
		font-size: 20px;
		color: white;
		text-align: center;
		font-weight: bold;
	}
	
	header {
		color: black;
		border-bottom: 1px solid lightgrey;
	}
	
	.survey {
		padding: 95px;
		width: 700px;
		margin: 0 auto;
		margin-top: 150px;
	}
	
	.resOption {
		display: flex;
		position: relative;
		width: 250px;
		height: 40px;
		border: 1px solid lightgrey;
		background-color: white;
		box-sizing: border-box;
		margin-right: 10px;
		margin-top: 10px;
	}
	
	.resText {
		position: absolute;
		width: 100%;
		height: 40px;
		color: grey;
		font-size: 16px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	input[type="radio"] {
		all: unset;
		position: absolute;
		width: 100%;
		height: 40px;
	}
	
	input[type="radio"]:checked+.resText {
		color: white;
		background-color: #105dae;
	}
	
	.wrap {
		width: 900px;
		display: flex;
		flex-wrap: wrap;
	}
	
	.survey>form>div {
		margin-top: 40px;
	}
	
	.numberInput {
		width: 300px;
		height: 40px;
		text-align: center;
		font-size: 20px;
	}
	
	.survey input[type="file"] {
		border: 1px solid black;
		border-radius: 8px;
		width: 300px;
		height: 30px;
		box-sizing: border-box;
		padding: 3px 46px;
	}
	
	div.profile {
		height: 300px;
		position: relative;
		display: flex;
		flex-flow: column;
	}
	
	div.preview {
		position: absolute;
		margin-bottom: 10px;
		background-size: cover;
		background-repeat: no-repeat;
		background-position: center;
		top: 0;
		left: 0;
		display: flex;
		/*    justify-content: center; */
		/*    align-items: center; */
		width: 300px;
		height: 300px;
		/*    border: 1px solid #ccc; */
		border-radius: 50%;
	}
	
	#profileReg {
		all: unset;
		position: absolute;
		top: 0;
		left: 0;
		width: 300px;
		height: 300px;
		border-radius: 50%;
		opacity: 0;
	}
	
	textarea.introduce {
		width: 100%;
		height: 200px;
		border: 1px solid grey;
		font-size: 15px;
		color: black;
		box-sizing: border-box;
		padding: 5px 5px;
	}
	
	#pwForm {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
	}
	
	#pwBtn, #cancleBtn {
		margin-top: 20px;
		margin-bottom: 10px;
		width: 400px;
		height: 50px;
		border: 1px solid lightgrey;
		background-color: #105dae;
		font-size: 20px;
		color: white;
		text-align: center;
		font-weight: bold;
	}
	
	#cancleBtn {
		background-color: #EEEEEE;
		margin-top: 0;
		color: #ABABAB;
	}
	
	.box {
		width: 300px;
		height: 250px;
		background-color: white;
		background-position: center;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	
	.overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.5);
	}
	
	form {
		width: 500px;
		font-size: 13px;
		color: #105dae;
	}
	
	.container {
		/*       border: 1px solid #ccc; */
		padding: 20px;
		border-radius: 5px;
	}
	/*     #myprofile { */
	/*        	position: relative; */
	/*        	display: flex; */
	/*        	flex-flow: column; */
	/*        	justify-content: center; */
	/*        	align-items: center; */
	/*          	} */
	.inputframe {
		width: 500px;
		height: 60px;
		border: 1px solid lightgrey;
		box-sizing: border-box;
		padding: 5px 10px;
		color: black;
		font-size: 16px;
	}
	
	#specForm {
		transform: translateY(600px);
	}
	
	footer {
 		position: absolute !important; 
		bottom: -600px !important;
	}
	
	footer.whenSpec {
		bottom: -1850px !important;
	}
	
	#specmodifyBtn {
		margin-bottom: 50px;
	}
</style>
<script>
	var joinDate = '${login.joinDate}'
	var lastLoginDate = '${login.lastLoginDate}'
	var loginBirthYear = "${login.birthYear}";
    var loginBirthMonth = "${login.birthMonth}";   
    var loginBirthDay = "${login.birthDay}";
    var phoneNumber = '${login.phoneNumber}'
    var idx = '${login.idx}'
</script>
<script src="${cpath }/resources/js/mypage.js"></script>
<section id="root">
	<aside class="menu">
		<h3>마이페이지</h3>
		<div class="item" onclick="myProfileLoadHandler(event)">내 프로필</div>
		<div class="item" onclick="myInfo(event)">내 정보 수정</div>
		<div class="item" onclick="specModify(event)">스펙 수정</div>
		<!--       <div class="item">신고 목록</div> -->
		<!--       <div class="item">내가 쓴 글</div> -->
	</aside>
	<div class="content"></div>
</section>

<div class="modal hidden">
	<div class="box">
		<p align="center">
			수정이 완료되었습니다. <br> 등급 재측정은 최대 2일간 소요됩니다.
		</p>
		<p align="center">
			<button id="close">닫기</button>
		</p>
	</div>
</div>


<script>
   const myInfo = function() {
      myInfoLoadHandler(event)
      selectHandler()
   }
  

   const myProfile = document.querySelector('.item')
   myProfile.dispatchEvent(new Event('click'))

   

</script>


