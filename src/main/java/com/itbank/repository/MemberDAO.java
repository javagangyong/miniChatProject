package com.itbank.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.itbank.model.MemberDTO;

public interface MemberDAO {

	@Insert("insert into member(userid, userpw, nickname, email) "
			+ "values(#{userid}, #{userpw}, #{nickname}, #{email})")
	int join(MemberDTO dto);


	@Select("select count(*) from member " + "where userid = #{userid}")
	int check(String userid);

	@Select("select * from member where userid = #{userid} and userpw = #{userpw}")
	MemberDTO selectOne(MemberDTO dto);

	@Select("select * from member where userid = #{userid} and username = #{username} and email = #{email}")
	MemberDTO selectCheck(MemberDTO dto);

	@Update("update member " + "      set" + "         userpw = #{userpw} " + "      where"
			+ "         userid = #{userid} and email = #{email}")
	int updatePassword(MemberDTO dto);


	@Select("select * from member where userid = #{userid}")
	MemberDTO selectOneById(String userid);

	@Select("select * from member order by idx desc")
	List<MemberDTO> selectList();

	@Update("update member " + " set" + "      username = #{username}," + "      gender = #{gender},"
			+ "      birthYear = #{birthYear}," + "      birthMonth = #{birthMonth}," + "      birthDay = #{birthDay},"
			+ "      phoneNumber = #{phoneNumber}" + " where" + "      userid = #{userid}")
	int update(MemberDTO dto);


	@Update("update member set userpw = #{userpw} where userid = #{userid}")
	int pwUpdate(MemberDTO dto);

	@Select("select * from member where idx = #{idx}")
	MemberDTO memberOne(int idx);

	@Delete("delete from member where userid = #{userid} and userpw = #{userpw}")
	int memberDelete(MemberDTO dto);

	@Update("update member set lastLoginDate = sysdate where userid = #{userid}")
	int updateLastLogin(String userid);


//	@Select("select userid from member where username = #{username} and email=#{email})")
//	String findUserId(String username, String email);

//	SELECT user_id FROM members WHERE email = #{email,
//		select userid from member where username = #{username} and email = #{email}
	@Select("select userid from member where username = #{username} and email = #{email}")
	String findUserId(MemberDTO dto);

	@Update("update member set userpw = #{userpw} where userid = #{userid}")
	int newPw(MemberDTO user);

	@Select("select profile from member_con" + "    where gender = #{gender} and userid like '%user%'"
			+ "    order by DBMS_RANDOM.RANDOM" + "    fetch next 10 rows only")
	List<String> getProfiles(String gender);

	@Select("select count(*) from member")
	int getMemberCount();

}
