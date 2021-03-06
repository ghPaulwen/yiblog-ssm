package me.paul.yiblog_ssm.service;

import java.io.UnsupportedEncodingException;

import me.paul.yiblog_ssm.dto.ModelContent;
import me.paul.yiblog_ssm.entity.Passage;
import me.paul.yiblog_ssm.entity.User;

public interface PassageService {
	Passage onlyPassage(long id);
	ModelContent get(long id);
	ModelContent edit(Passage passage,long before);
	ModelContent save(Passage passage,User author);
	ModelContent page(int page,int passagePerPage);
	ModelContent categoryPage(long category,int page,int passagePerPage);
	ModelContent search(String content) throws UnsupportedEncodingException;
	boolean checkIdAuthor(long id,long author);
	ModelContent devailable(long id);
	ModelContent available(long id);
}
