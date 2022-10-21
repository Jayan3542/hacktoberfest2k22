<%@page import="controller.AES_ENCRYPTION"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="javax.crypto.Cipher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String action = request.getParameter("action");
    String key = request.getParameter("key");
    String inputString = request.getParameter("input_string");
    AES_ENCRYPTION aes_encryption = new AES_ENCRYPTION();
    aes_encryption.setKey(key);

    System.out.println("Data-enc");

    if (action.equals("encryption")) {

        System.out.println("Data");
        System.out.println(key);
        System.out.println(inputString);
        System.out.println("Data");


        Cipher encryptionCipher = aes_encryption.createCipher();
        String encrpted = aes_encryption.encrypt(inputString);
        System.out.println("JeewHiddala"+encrpted);


        //out.print(new Gson().toJson(encrpted));

        Gson gson = new Gson();

        String gsonString = gson.toJson(encrpted);
        System.out.println("gsonString"+gsonString);
        response.setContentType("application/json");
        response.getWriter().print(gsonString);
    }


//    if (action.equals("decryption")) {
//
//       // String key = request.getParameter("key");
//        String encryptedString = request.getParameter("encrypted_string");
//
//        System.out.println("Data");
//        System.out.println(key);
//        System.out.println(encryptedString);
//        System.out.println("Data");
//
//      //  AES_ENCRYPTION aes_encryption = new AES_ENCRYPTION();
//       // aes_encryption.setKey(key);
//        String originalMsg = null;
//        try {
//            originalMsg = aes_encryption.decrypt(encryptedString);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        System.out.println("originalMsg"+originalMsg);
//
//
//        //out.print(new Gson().toJson(encrpted));
//
//        Gson gson = new Gson();
//
//        String gsonString = gson.toJson(originalMsg);
//        System.out.println("gsonString"+gsonString);
//        response.setContentType("application/json");
//        response.getWriter().print(gsonString);
//    }



%>