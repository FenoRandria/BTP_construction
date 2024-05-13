<%-- 
    Document   : formulaire
    Created on : May 2, 2024, 2:16:57 PM
    Author     : fenor
--%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/save.css">
</head>

<body>
    <div id="page">
        <section class="save"">
            <form id="loginForm" >
                <style>  
                     @keyframes error {
                            0% {
                                transform: translateX(0px);
                            }
                            50% {
                                transform: translateX(50px);
                            }
                            100% {
                                transform: translateX(0px);
                            }
                        }

                        #errorMsg {
                            color: red;
                            animation: error .8s ease-in infinite;
                        }
                </style>
                <h3 class="title ">Admin</h3>
                <p id="error"> </p>
                <!-- Email -->
                <label for="email">Email : <p id="errorMail" style="color:red"></p></label>
                <input type="email" id="email" name="mail" value="admin@gmail.com">

                <!-- Mot de passe -->
                <label for="motdepasse">Mot de passe :  <p id="errorMdp" style="color: red"></p></label>
                <input type="password" id="motdepasse" name="mdp" value="admin">
                <br>
                <!-- Bouton de soumission -->
                <input type="submit" value="Soumettre">
            </form>
        </section>
    </div>
</body>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>



<script src="${pageContext.request.contextPath}/assets/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

        $(document).ready(function() {
        $('#loginForm').submit(function(event) {
            event.preventDefault();
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    var messages = this.responseText.split("+");
                    messages.forEach(function(message) {
                        console.log(message);
                        var parts = message.split(":");
                        var type = parts[0];
                        var content = parts[1];
                        if (type === 'success') {
                            console.log('success: ' + content);
                            window.location.href = 'http://localhost:8084/BTP_construction'+content;
                        } else {
                            $("#" + type).text(content);
                            console.error('Erreur: ' + content);
                        }
                    });
                }
            };
            
             let params = $('form').serialize().toString();
            xmlhttp.open("POST", "admin-login", true);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send(params);
        });
    });
                    
</script>



</html>
