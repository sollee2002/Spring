package com.peco.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
   
   @RequestMapping(value="payAction", method=RequestMethod.POST)
   @ResponseBody
   public void payAction(
         @RequestParam("imp_uid") String imp_uid,
         @RequestParam("merchant_uid") String pr_id,
         @RequestParam("apply_num") String pr_pay,
         @RequestParam("p_id") String p_id,
         @RequestParam("pname") String pname,
         @RequestParam("period") String period,
         @RequestParam("priceCnt") String pricecnt,
         @RequestParam("name") String pr_name) {

         //값이 제대로 넘어오면 예약번호 생성 후 db인서트
         //결제정보 확인 후 환불로직까지(imp_uid/거래고유번호와 merchant_uid/주문고유번호 이용)
   }
   
   @PostMapping("insert")
	public String insertAction(P_RESVO p_resVO, HttpServletRequest request) {
		
	   try {
           System.out.println("/peco/insert 요청: Post");
           
           String pr_id = request.getParameter("pr_id"); //
           String startdate = request.getParameter("startdate");
           String enddate = request.getParameter("enddate");
           String pr_pay = request.getParameter("apply_num"); //
           String period = request.getParameter("period");
           String pname = request.getParameter("pname");
           String p_id = request.getParameter("p_id");
           String pricecnt = request.getParameter("pricecnt"); //
           String pr_name = request.getParameter("pr_name"); //
           String imp_uid = request.getParameter("imp_uid");
      
//           System.out.println(pr_id);
//           System.out.println(startdate);
//           System.out.println(enddate);
//           System.out.println(pr_pay);
//           System.out.println(period);
//           System.out.println(pname);
//           System.out.println(p_id);
//           System.out.println(pricecnt);
//           System.out.println(pr_name);
//           System.out.println(imp_uid);
           
           
           service.insertResvation(p_resVO);
           System.out.println("성공");

           
       } catch (Exception e) {
           System.out.println(e.getMessage());
       }
	   
	   return "redirect:/success";

	}
   
}