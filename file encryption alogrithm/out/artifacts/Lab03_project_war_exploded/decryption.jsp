<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Decryption</title>
    <%
        String encrypted = request.getParameter("encryptedString");
    %>
</head>
<body>
<div class="col-md-6 ml-auto mr-auto">
    <div class="p-4">

        <form action="" id="decryption_form" name="loginform" method="post">

            <h3 id="encrypted_string" >Encrypted String : <%=encrypted%></h3>
            <input class="form-control form-control-rounded"  name="encrypted_string" type="text" value="<%=encrypted%>" hidden>
            <div class="form-group">
                <label for="email">Input the Secret Key</label>
                <input class="form-control form-control-rounded" id="key" name="key" type="text">
            </div>
            <br><br>
            <button id="decrypt" type="button"  class="btn btn-rounded btn-primary btn-block mt-2">
                Decrypt
            </button>

        </form>
    </div>
    <h3 id="456"></h3>
    <h2 id="123"></h2>

</div>
</body>
</html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

    $('#decrypt').click(function () {
        console.log("jhid")

        $.ajax({
            url: 'controller/DecryptionController.jsp?action=decryption',
            type: 'GET',
            processData: false,
            contentType: 'application/json; charset=utf-8',
            cache: false,
            dataType: 'json',
            data: $('#decryption_form').serialize(), // added data type
            success: function (data) {

                console.log("p2");
                console.log(data);

                if(data == null){
                    document.getElementById("456").innerHTML = "Invalid Keys. Try Again"
                    document.getElementById("123").innerHTML = data
                }
                //  $("#123").val("newValue");
                else {
                    document.getElementById("456").innerHTML = "Original Message : "
                    document.getElementById("123").innerHTML = data
                }

            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log("error");
                console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                document.getElementById("456").innerHTML = "Invalid Keys. Try Again"
                document.getElementById("123").innerHTML = data

            }
        });
    })




</script>