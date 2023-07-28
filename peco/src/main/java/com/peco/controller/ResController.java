package com.peco.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.peco.service.ResService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/peco/*")
@Log4j
public class ResController {
	@Autowired
	ResService service;
	
	@GetMapping("list")
	public String getList(Model model) {	
		service.getList(model);
		  
		return "resvation";
	}

}
