<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	section {
		margin: 0 auto 10px auto;
		padding-top: 95px;
		width: 970px;
		height: max-content;
/* 		justify-content: center;
 */	}
	table {
		width: 970px;
		margin: 50px auto 0 auto;
		border-collapse: collapse;
	}
	th {
		border-bottom: 1px solid black;
	}
	td {
		border-bottom: 1px solid lightgray;
	}
	#writer {
		width: 50%;
		border-right: 1px solid lightgray;
	}
	#writeDate {
		padding-left: 10px;
	}
	table tr:nth-child(4) td {
		border-bottom: none;
		height: 500px;
		vertical-align: middle;
		padding: 15px 0 15px 0;
	}
	.flex {
		display: flex;
		justify-content: space-between;
		width: 170px;
		margin: 5px;
	}
	textarea {
		width: 950px;
		height: 150px;
		resize: none;
	}
	#reply {
		display: flex;
		justify-content: space-between;
		padding: 5px;
		border-bottom: 1px solid #cdcdcd;
	}
	#replyLeft {
		
	}
	#boardImg {
		background-image: url('${cpath}/upload/${dto.img}');
		width: 900px;
		height: 550px;
		background-size: auto 100%;
		display: block;
		margin-bottom: 20px;
		border-bottom: none;
		background-repeat: no-repeat;
	}

</style>

<section>
	<table>
		<tr><th colspan="2"><h2>자유게시판</h2></th></tr>
		<tr><td colspan="2"><h3>${dto.title }</h3></td></tr>
		<tr>
			<td id="writer">${dto.writer }</td>
			<td id="writeDate">${dto.writeDate }</td>
		</tr>
		<tr><td>${dto.content }</td></tr>
		<c:if test="${not empty dto.img }">
			<tr><td id="boardImg" colspan="2"></td></tr>
		</c:if>
	</table>

	<form id="replyForm">
		<div class="flex">
			<div>${login.userid }</div>
			<div><button type="submit">댓글작성</button></div>
		</div>
		<textarea name="content" required></textarea>
		<input type="hidden" name="writer" value="${login.userid }">
		<input type="hidden" name="board_idx" value="${dto.idx }">
	</form>
	
	<div id="replyList"></div>
	
	

</section>





<script>


// 댓글리스트 불러오기-----------------------------------------------------------------------------------
	const replyList = document.getElementById('replyList')	
	
	const ReplyLoadHandler = async function() {
		
		replyList.innerHTML = ''
		const url = '${cpath}/freeBoardAjax/replyView/${dto.idx}'
		const arr = await fetch(url).then(resp => resp.json())
		let rep = ''
		
		for(let i = 0; i < arr.length; i++) {
			
			const dto = arr[i]
			
			const longToDateString = function(num) {
				const d = new Date(num)
				let yyyy = d.getFullYear()
				let mm = d.getMonth() + 1
				let dd = d.getDate()
				let h = d.getHours()
				let m = d.getMinutes()
				
				if(mm < 10) 	mm = '0' + mm
				if(dd < 10) 	dd = '0' + dd
				if(h < 10) 		h = '0' + h
				if(m < 10)		m = '0' + m
				
				return yyyy + '.' + mm + '.' + dd + ' ' + h + ':' + m
			}
			
			let tag = '<div id="reply">'
			tag += '		<div id="replyLeft">'
			tag += '			<div>' + dto.writer + '</div>'
			tag += '			<div>' + dto.content + '</div>'
			tag += '		</div>'
			tag += '		<div>' + longToDateString(dto.writeDate) + '</div>'
			tag += '	</div>'
			rep += tag
		}
		replyList.innerHTML = rep
		
	}


// ajax 댓글 데이터 백엔드로 보내기--------------------------------------------------------------------------
	const form = document.getElementById('replyForm')
	form.onsubmit = async function(event) {
		event.preventDefault();
		
		const url = '${cpath}/freeBoardAjax/replyWrite'
		
		const formData = new FormData(event.target) //onsubmit 시에 담기는 데이터
		const dataObject = Object.fromEntries(formData.entries())
		// formData.entries() formData를 entries(항목화)하는것 즉 배열들을 만든다
		// ['name', 'user1'], ['content', 'ㅋㅋ']와 같은 배열 덩어리 반환
		// Object.fromEntries() 항목들로부터 객체화하는것. 배열 덩어리들을 객체화한다.
		
		const opt = {
			method: 'POST',	// 데이터 생성 위해 POST방식 사용
			body: JSON.stringify(dataObject),	// 자바스크립트 객체를 JSON 문자열로 변환
			headers: {
				'Content-Type': 'application/json; char=utf-8'	// 나 지금 JSON데이터 보낸다! 라고 서버에 알림
			}
			
		}
		
		const result = await fetch(url, opt).then(resp => resp.text())
		if(result == 1) {
			console.log(result)
			event.target.reset();	// 이벤트를 일으켰던 그 폼 내부의 입력란들을 전부 리셋해라!
		}
		
		ReplyLoadHandler()
	}
	
	
	document.addEventListener('DOMContentLoaded', ReplyLoadHandler)


</script>





