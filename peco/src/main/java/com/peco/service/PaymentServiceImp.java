package com.peco.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.Getter;
import lombok.ToString;

	@Service
	public class PaymentServiceImp implements PaymentService {
		
		private String impKey = "6615746551637850";
		private String impSecret = "BEQuNfVBtZKdkZL9uGiNGIxvMNLQ6ADoK77fAD3zlk4neySuRGc6n7YuYGlb1z8q5gtLewOuTUDQgGzX";
 
		@ToString
		@Getter
		private class Response {
			private paymentInfo response;
		}
		@ToString
		@Getter
		private class paymentInfo {
			private int amount;
		}
		@Override
		public String getToken() throws IOException { //토큰 정보 얻어오기
 
			HttpsURLConnection conn = null;
 
			URL url = new URL("https://api.iamport.kr/users/getToken");
 
			conn = (HttpsURLConnection) url.openConnection();
 
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setRequestProperty("Accept", "application/json");
			conn.setDoOutput(true);
			JsonObject json = new JsonObject();
 
			json.addProperty("imp_key", impKey);
			json.addProperty("imp_secret", impSecret);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			
			bw.write(json.toString());
			bw.flush();
			bw.close();
 
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
			Gson gson = new Gson();
 
			String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
			
			System.out.println(response);
 
			String token = gson.fromJson(response, Map.class).get("access_token").toString();
 
			br.close();
			conn.disconnect();
 
			return token;
		}

	//결제 취소 로직
	@Override
	public void payMentCancle(String access_token, String imp_uid, String amount) throws IOException {
		System.out.println("결제 취소");
		
		System.out.println("impl access_token : "+access_token);
		
		System.out.println("impl imp_uid : "+imp_uid);
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
 
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("imp_uid", imp_uid);
		json.addProperty("amount", amount);
		json.addProperty("checksum", amount);
 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();
		
	}

		@Override
		public int paymentInfo(String imp_uid, String access_token) {
			HttpsURLConnection conn = null;
			 
		    URL url;
			try {
				url = new URL("https://api.iamport.kr/payments/" + imp_uid);
				conn = (HttpsURLConnection) url.openConnection();
				 
			    conn.setRequestMethod("GET");
			    conn.setRequestProperty("Authorization", access_token);
			    conn.setDoOutput(true);
			 
			    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			    
			    Gson gson = new Gson();
			    
			    Response response = gson.fromJson(br.readLine(), Response.class);
			    
			    br.close();
			    conn.disconnect();

			    
			    return response.getResponse().getAmount();
			    
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
			return 0;
		    
		}
	

		
		
 
}

