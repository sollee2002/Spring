package com.peco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.peco.mapper.ResMapper;
import com.peco.vo.ResVO;

@Service
public class ResServiceimpl implements ResService{
	
	@Autowired
	private ResMapper mapper;

	@Override
	public List<ResVO> getList(Model model) {
		
		return mapper.getList();
	}

}
