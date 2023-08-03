package com.peco.service;

import java.io.IOException;

import org.springframework.stereotype.Service;


@Service
public interface PaymentService {
	 
	String getToken() throws IOException;

	public void payMentCancle(String access_token, String imp_uid, String amount) throws IOException;;
	
	int paymentInfo(String imp_uid, String access_token);
}