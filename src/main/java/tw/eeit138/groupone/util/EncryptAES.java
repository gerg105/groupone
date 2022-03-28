package tw.eeit138.groupone.util;

import java.security.Security;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptAES {
/*
	KeyGenerator 提供對稱金鑰生成器的功能，支援各種演算法
	SecretKey 負責儲存對稱金鑰
	Cipher 負責完成加密或解密工作
	byte[] cipherbyte 負責儲存加密的結果
*/
//	密鑰，256位元32個字
	private static final String KEY = "A3GpKJSEC6yVqj2xTnWzLeHYcMNu7m9v";
//	初始向量IV，長度規定為128位元16個字
	private static final byte[] IV = "wfq6ms9hakz3UQF5" .getBytes();
//	加密解密算法/加密模式/填充方式
	private static final String ALGORITHM = "AES/CBC/PKCS5Padding";
	
	static {
		Security.setProperty("crypto.policy", "unlimited");
	}

//	加密
	public static String encode(String input) throws Exception {
		SecretKey key = new SecretKeySpec(KEY.getBytes(), "AES");
		IvParameterSpec iv = new IvParameterSpec(IV);
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, key, iv);
		byte[] byteEncode = cipher.doFinal(input.getBytes());
		String encText = Base64.getEncoder().encodeToString(byteEncode);
		return encText;
	}
	
//	解密
	public static String decode(String code) throws Exception {
		SecretKey key = new SecretKeySpec(KEY.getBytes(), "AES");
		IvParameterSpec iv = new IvParameterSpec(IV);
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.DECRYPT_MODE, key, iv);
		byte[] byteDecode = cipher.doFinal(Base64.getDecoder().decode(code));
		String decText = new String(byteDecode);
		return decText;
	}

}
