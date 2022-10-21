<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Encryption</title>
    <%
      String encrypted = "";
    %>
  </head>
  <body>
  <div class="col-md-6 ml-auto mr-auto">
    <div class="p-4">
      <form action="" id="login_form" name="loginform" method="post">
        <div class="form-group">
          <label for="email">Secret Key</label>
          <input class="form-control form-control-rounded" id="key" name="key" type="text">
        </div>
        <br>
        <div class="form-group">
          <label for="password">Enter the String</label>
          <input class="form-control form-control-rounded" name="input_string" id="inputString" type="text">
        </div>
        <br><br>
        <button id="subBtn" type="button"  class="btn btn-rounded btn-primary btn-block mt-2">
          Encryption
        </button>

      </form>
    </div>
    <h3 id="456"></h3>
    <h2 id="123"></h2>

    <button id="send" type="button"  class="btn btn-rounded btn-primary btn-block mt-2" hidden>
      Send For Decryption
    </button>
  </div>
  </body>
</html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
    var encryptedString = "";
    $('#subBtn').click(function () {
        console.log("Jeew")


        $.ajax({
            url: 'controller/EncryptionController.jsp?action=encryption',
            type: 'GET',
            processData: false,
            contentType: 'application/json; charset=utf-8',
            cache: false,
            dataType: 'json',
            data: $('#login_form').serialize(), // added data type
            success: function (data) {

                console.log("p1");
                console.log(data);
                encryptedString = data
              //  $("#123").val("newValue");
                document.getElementById("456").innerHTML = "Encrypted String : "
                document.getElementById("123").innerHTML = data
                document.getElementById("send").hidden = false
            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log("error");
                console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            }
        });
    })

    $('#send').click(function () {
        console.log("j1")

        window.location.href = 'decryption.jsp?encryptedString='+encryptedString;
    })




</script>