package com.peco.controller;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.peco.service.ResService;
import com.peco.vo.P_RESVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/peco/*")
@Log4j
@MultipartConfig
public class ResController {
   @Autowired
   ResService service;
   
   @GetMapping("list")
   public String getList(Model model) {   
      
      
      service.getMemberList();
      service.getPentionList();
      
      
      
      model.addAttribute("mList", service.getMemberList());
      model.addAttribute("pList", service.getPentionList());
      model.addAttribute("disabledate", service.getDisableDate());
      
      return "peco/resvation";
   }
   
   @RequestMapping(value="/peco/insert", method=RequestMethod.POST)
	public void insertAction(P_RESVO p_resVO, HttpServletRequest request) {
           
           String pr_id = request.getParameter("pr_id"); //
           String startdate = request.getParameter("startdate");
           String enddate = request.getParameter("enddate");
           String pr_pay = request.getParameter("pr_pay"); //
           String period = request.getParameter("period");
           String pname = request.getParameter("pname");
           String p_id = request.getParameter("p_id");
           String pricecnt = request.getParameter("pricecnt"); //
           String pr_name = request.getParameter("pr_name"); //
           String imp_uid = request.getParameter("imp_uid");
           
           System.out.println(pr_pay);
   
           service.insertResvation(p_resVO);
           System.out.println("성공");
	}
   
   @GetMapping("/peco/success")
   public String redirect() {
	   
	   return "peco/success";
	   //1.리디렉트 되는지 확인 --마이페이지나 리스트로 돌아가게 나중에 처리
	   //2.pr_id이랑 imp_uid값 이용해서 예약취소처리
	   //3.js 간단히 정리
   }
   
}