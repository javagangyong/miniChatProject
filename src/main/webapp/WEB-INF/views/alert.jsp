<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<script>
	const msg = '${msg}'
	const url = '${url}'
	if(url != '') {
		alert(msg)
		location.href = cpath + url
	}
	if(msg == '가입완료') {
		const flag = confirm('가입되었습니다. 내 정보 입력 페이지로 이동할까요?')
		if(flag) {
			location.href = '${cpath}/member/survey'
		}
		else {
			location.href = '${cpath}/member/login'
		}
	}
	if(msg == '') {
		alert('가입되지 않은 회원이시거나 ID/PW가 틀리셨습니다.')
		history.back()
	} 
</script>

</body>
</html>