package tw.eeit138.groupone.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.springframework.stereotype.Component;

import tw.eeit138.groupone.model.EmployeeBean;

@Component
public class SHA256Utils {

	// 生成驗證帳戶的SHA256驗證碼
	// 要激活的emp帳戶
	// return將用戶名和密碼組合後,通過SHA256加密後會產生長度為64的十六進制字串
	public static String generateCheckcode(EmployeeBean emp) {
		String username = emp.getUsername();
		String boardDate = emp.getBoardDate();
		StringBuilder str = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			str.append(random.nextInt(10));
		}
		String ran = str.toString();
		return getSHA256StrJava(username + ":" + boardDate + ":" + ran);
	}

	
	/**
	* 利用java原生的摘要實現SHA256加密
	* @param str 加密後的報文
	* @return
	*/
	public static String getSHA256StrJava(String str) {
		MessageDigest messageDigest;
		String encodeStr = "";
		try {
			messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(str.getBytes("UTF-8"));
			encodeStr = byte2Hex(messageDigest.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return encodeStr;
	}
	
	/**
	* 將byte轉為16進位制
	* @param bytes
	* @return
	*/
	private static String byte2Hex(byte[] bytes) {
		StringBuffer stringBuffer = new StringBuffer();
		String temp = null;
		for (int i = 0; i < bytes.length; i++) {
			temp = Integer.toHexString(bytes[i] & 0xFF);
			if (temp.length() == 1) {
				// 1得到一位的進行補0操作
				stringBuffer.append("0");
			}
			stringBuffer.append(temp);
		}
		return stringBuffer.toString();
	}
	
	// 隨機產生6位數
	public static String randomCode() {
		StringBuilder str = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			str.append(random.nextInt(10));
			}
		return str.toString();
	}
}
