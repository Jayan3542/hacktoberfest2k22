<%@page import="controller.AES_ENCRYPTION"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="javax.crypto.Cipher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String action = request.getParameter("action");
    String key = request.getParameter("key");
    String encryptedString = request.getParameter("encrypted_string");


    if (action.equals("decryption")) {

        System.out.println("Data");
        System.out.println(key);
        System.out.println(encryptedString);
        System.out.println("Data");

        AES_ENCRYPTION aes_encryption = new AES_ENCRYPTION();
        aes_encryption.setKey(key);



        String originalMsg = null;
        try {
            originalMsg = aes_encryption.decrypt(encryptedString);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("originalMsg"+originalMsg);


        //out.print(new Gson().toJson(encrpted));

        Gson gson = new Gson();

        String gsonString = gson.toJson(originalMsg);
        System.out.println("gsonString"+gsonString);
        response.setContentType("application/json");
        response.getWriter().print(gsonString);
    }




%>