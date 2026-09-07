package com.itbank.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.itbank.model.FreeBoardDTO;
import com.itbank.model.FreeBoardReplyDTO;

@Repository
public interface FreeBoardDAO {

	@Insert("insert into free_board (title, writer, content, img) values (#{title}, #{writer}, #{content}, #{img})")
	int insertFreeBoard(FreeBoardDTO dto);

	@Select("select * from free_board "
			+ "where ( "
			+ "	title 		like '%' || #{search} || '%' or "
			+ "	content		like '%' || #{search} || '%' or "
			+ " writer		like '%' || #{search} || '%' "
			+ ") order by idx desc "
			+ "offset #{boardPaging.offset} rows "
			+ "fetch next #{boardPaging.fetch} rows only")
	List<FreeBoardDTO> selectList(Map<String, Object> map);

	@Select("select * from free_board where idx = #{idx}")
	FreeBoardDTO selectOne(int idx);

	@Insert("insert into free_boardReply (board_idx, writer, content) values (#{board_idx}, #{writer}, #{content})")
	int insertReply(FreeBoardReplyDTO dto);

	@Select("select * from free_boardReply where board_idx = #{board_idx} order by idx desc")
	List<FreeBoardReplyDTO> selectReplyList(int board_idx);

	@Select("select count(*) "
			+ "from free_board "
			+ "where ( "
			+ "   title      like '%' || #{search} || '%' or "
			+ "   content    like '%' || #{search} || '%' or "
			+ "   writer     like '%' || #{search} || '%' "
			+ ")")
	int countFreeBoard(String search);

}
