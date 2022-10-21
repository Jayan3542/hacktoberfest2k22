package controller;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Scanner;

public class AES_ENCRYPTION {

    //private SecretKey key;
    private final int KEY_SIZE = 128;

    private static Cipher encryptionCipher;
    private static SecretKeySpec secretKey;
    private static byte[] key;
    private final int DATA_LENGTH = 128;

    public static void setKey(final String myKey) {
        MessageDigest sha = null;
        try {
            key = myKey.getBytes("UTF-8");
            sha = MessageDigest.getInstance("SHA-1");
            key = sha.digest(key);
            key = Arrays.copyOf(key, 16);
            secretKey = new SecretKeySpec(key, "AES");
            System.out.println("secretKey inside setkey: "+secretKey);
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    public static Cipher createCipher () throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException {
        encryptionCipher = Cipher.getInstance("AES/GCM/NoPadding");
        encryptionCipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return encryptionCipher;
    }

    public String encrypt(String data) throws Exception {
        byte[] dataInBytes = data.getBytes();
//        encryptionCipher = Cipher.getInstance("AES/GCM/NoPadding");
//        encryptionCipher.init(Cipher.ENCRYPT_MODE, secretKey);

        byte[] encryptedBytes = encryptionCipher.doFinal(dataInBytes);
        return encode(encryptedBytes);
    }

    public String decrypt(String encryptedData) throws Exception {

        byte[] dataInBytes = decode(encryptedData);
        Cipher decryptionCipher = Cipher.getInstance("AES/GCM/NoPadding");
        System.out.println("DATA_LENGTH : "+DATA_LENGTH);
        System.out.println("secretKey : "+secretKey);
        System.out.println("encryptionCipher.getIV() : "+encryptionCipher);
        GCMParameterSpec spec = new GCMParameterSpec(DATA_LENGTH, encryptionCipher.getIV());
        System.out.println("spec : "+spec);
        decryptionCipher.init(Cipher.DECRYPT_MODE, secretKey, spec);
        byte[] decryptedBytes = decryptionCipher.doFinal(dataInBytes);
        return new String(decryptedBytes);
    }

    private String encode(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }

    private byte[] decode(String data) {
        System.out.println("Inside Decode : " + data);
        return Base64.getDecoder().decode(data);
    }

    public static void main(String[] args) {
        try {
            AES_ENCRYPTION aes_encryption = new AES_ENCRYPTION();
           // aes_encryption.init();
//            String encryptedData = aes_encryption.encrypt("Hello, welcome to the encryption world");
//            String decryptedData = aes_encryption.decrypt(encryptedData);

            Scanner sc= new Scanner(System.in);
            System.out.println("Enter the Data to Encrypt");
            String inputData = sc.nextLine();
            System.out.println("Enter the Key");
            String inputKey = sc.next();

            aes_encryption.setKey(inputKey);
            String encrpted = aes_encryption.encrypt(inputData);
            String decrpted = aes_encryption.decrypt(encrpted);

            System.out.println("Encrypted Data : " + encrpted);
            System.out.println("Decrypted Data : " + decrpted);
        } catch (Exception ignored) {
        }
    }
}

