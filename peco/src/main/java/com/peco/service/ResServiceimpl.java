package com.peco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.peco.mapper.ResMapper;
import com.peco.vo.MemberVO;
import com.peco.vo.PentionVO;

@Service
public class ResServiceimpl implements ResService{
	
	@Autowired
	private ResMapper mapper;

	@Override
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}

	@Override
	public List<PentionVO> getPentionList() {
		return mapper.getPentionList();
	}

}
