package com.itbank.repository;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.model.MemberDTO;

public interface TestMemberDAO {


	@Update("update member set "
			+ "username = #{username}, gender = #{gender}, birthYear = #{birthYear}, "
			+ "birthMonth = #{birthMonth}, birthDay = #{birthDay}, phoneNumber = #{phoneNumber} "
			+ "where userid = #{userid}")
	int updateInfo(MemberDTO dto);

	@Update("update member set userpw = #{userpw} where userid = #{userid}")
	int updatePw(MemberDTO dto);

}
