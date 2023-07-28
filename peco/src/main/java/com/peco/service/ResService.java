package com.peco.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.peco.vo.ResVO;

@Service
public interface ResService {
	public List<ResVO> getList(Model model);

}
