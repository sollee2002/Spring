package com.peco.mapper;

import java.util.List;

import com.peco.vo.MemberVO;
import com.peco.vo.P_RESVO;
import com.peco.vo.PentionVO;

public interface ResMapper {
	
	public List<MemberVO> getMemberList();
	
	public List<PentionVO> getPentionList();
	
	public List<P_RESVO> getDisableDate();
	
	public int insertResvation(P_RESVO p_resVO);
}
