package com.peco.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.peco.vo.MemberVO;
import com.peco.vo.P_RESVO;
import com.peco.vo.PentionVO;

@Service
public interface ResService {
	public List<MemberVO> getMemberList();
	
	public List<PentionVO> getPentionList();
	
	public List<P_RESVO> getDisableDate();
	
	public int insertResvation(P_RESVO p_resVO);

}
