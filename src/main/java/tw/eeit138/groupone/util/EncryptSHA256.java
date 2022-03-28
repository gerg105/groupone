package tw.eeit138.groupone.util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class EncryptSHA256 {
	
//	SHA256驗證碼
	public static String encryptor(String str) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] messageDigest = md.digest(str.getBytes());
		BigInteger num = new BigInteger(1, messageDigest);
		StringBuilder hashText = new StringBuilder(num.toString(16));
		while(hashText.length() < 32) {
			hashText.insert(0, "0");
		}
		String encrypt = hashText.toString();
		return encrypt;
	}

}
