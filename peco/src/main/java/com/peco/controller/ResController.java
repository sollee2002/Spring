package com.peco.controller;

import java.io.IOException;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
      
      model.addAttribute("mList", service.getMemberList());
      model.addAttribute("pList", service.getPentionList());
      model.addAttribute("disabledate", service.getDisableDate());
      
      return "peco/resvation";
   }
   
   @GetMapping("boot")
   public String getList() {   
      
      return "peco/boot";
   }
   
   @RequestMapping(value="/peco/insert", method=RequestMethod.POST)
	public void insertAction(P_RESVO p_resVO, HttpServletRequest request) {
           
           String pr_id = request.getParameter("pr_id");
           String startdate = request.getParameter("startdate");
           String enddate = request.getParameter("enddate");
           String pr_pay = request.getParameter("pr_pay");
           String period = request.getParameter("period");
           String p_id = request.getParameter("p_id");
           String pricecnt = request.getParameter("pricecnt");
           String pr_name = request.getParameter("pr_name");
           String pr_email = request.getParameter("pr_email");
           String pr_tel = request.getParameter("pr_tel");
           String imp_uid = request.getParameter("imp_uid");
           String m_id = request.getParameter("m_id");
           String pname = request.getParameter("pname");
           String roomname = request.getParameter("roomname");

           service.insertResvation(p_resVO);
           System.out.println("성공");
	}
   
   @GetMapping("/peco/redirect")
   public String redirect(Model model){
	   
	   service.getResvationList();
	   model.addAttribute("getRList",service.getResvationList());
	   
	   return "peco/success";
   }
   
   @ResponseBody
   @RequestMapping(value="/peco/delete", method=RequestMethod.POST)
   public void deleteRes(HttpServletRequest request) {
	   
	   String imp_uid = request.getParameter("imp_uid");
	   
	   System.out.println("del : "+imp_uid);
	   int res = service.deleteRes(imp_uid);
	   
	   if(res>0) {
		   System.out.println("정상삭제");
	   } else {
		   System.out.println("삭제중 오류");
	   }
	   
   }
   
}