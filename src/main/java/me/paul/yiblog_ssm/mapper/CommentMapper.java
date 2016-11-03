package me.paul.yiblog_ssm.mapper;

import java.util.List;

import me.paul.yiblog_ssm.entity.Comment;

public interface CommentMapper {
	
	void insert(Comment comment);
	
	Comment select(long id);
	
	List<Comment> getAll();
	
	List<Comment> getNew();
	
	
	List<Comment> getByPassage(long id);

}
