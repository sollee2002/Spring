package com.peco.controller;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.peco.service.PaymentService;
import com.peco.vo.P_RESVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
@RequestMapping("peco/payment/*")
public class PaymentController{

    private final IamportClient iamportClient;

    public PaymentController() {
        this.iamportClient = new IamportClient("6615746551637850",
                "BEQuNfVBtZKdkZL9uGiNGIxvMNLQ6ADoK77fAD3zlk4neySuRGc6n7YuYGlb1z8q5gtLewOuTUDQgGzX");
    }

    @ResponseBody
    @RequestMapping("verifyIamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);

    }
    
    @Autowired
    private PaymentService paymentService;
    
    @PostMapping("complete")
    public ResponseEntity<String> paymentComplete(HttpSession session, P_RESVO p_resvo) throws IOException {
     
    	String token = paymentService.getToken();
    	System.out.println("토큰 : " + token);

      return new ResponseEntity<>(HttpStatus.OK);
    }
    
    @PostMapping("cancel")
    public ResponseEntity<String> delete(HttpSession session, @RequestParam("imp_uid") String imp_uid
    					,@RequestParam("amount") String amount) {
    	    	
		try {
			String access_token = paymentService.getToken();	
			
			System.out.println("토큰 : " + access_token);
			System.out.println("imp_uid : " + imp_uid);
			System.out.println("amount : " + amount);

			
			paymentService.payMentCancle(access_token, imp_uid, amount);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		 return new ResponseEntity<String>("취소가 완료되었습니다", HttpStatus.OK);
    }

}