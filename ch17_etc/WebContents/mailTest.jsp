<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="ch17_etc.MyAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 Properties p=System.getProperties();
 p.put("mail.smtp.starttls.enable","true");//
 p.put("mail.smtp.host","smtp.naver.com");//stmp서버 주소
 p.put("mail.smtp.auth","true");
 p.put("mail.smtp.port","587");//네이버 포트
 p.put("mail.smtp.port","587");//네이버 포트
 p.put("mail.smtp.ssl.protocols", "TLSv1.2");//시큐어 프로토콜 추가
 /* Caused by: javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
 */
 p.put("mail.smtp.ssl.trust","*"); //인증서 전부 신뢰
 
 Authenticator auth = new MyAuthentication();
 //session 생성 및 MimeMessage 생성
 //session 생성 및 MimeMessage 생성
 Session session2 =Session.getDefaultInstance(p,new javax.mail.Authenticator() {
		String un="j_a_ck@naver.com";
		String pw="1@byeonghunNAVER";
		protected  PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(un, pw);
		}
	});
	
 //Session session2 =Session.getDefaultInstance(p,auth);
 MimeMessage msg = new MimeMessage(session2);
 try{
	 msg.setSentDate(new Date());//전송시간
	 InternetAddress from = new InternetAddress();
	 from = new InternetAddress("j_a_ck@naver.com");//발신자 아이디
	 msg.setFrom(from);//이메일 발신자
	 InternetAddress to = new InternetAddress("j_a_ck@naver.com");//수신자
	 msg.setRecipient(Message.RecipientType.TO, to);//수신자
	 msg.setSubject("메일전송 테스트","UTF-8");//이메일 제목
	 msg.setText("메일전송 테스트 내용","UTF-8");//이메일 내용
     msg.setHeader("content-Type", "text/html");//이메일 헤더
     //전송 처리
     Transport.send(msg,msg.getAllRecipients());
	 
     out.print("메일전송 성공");
 }catch(Exception e){
	 e.printStackTrace();
 }
 
%>