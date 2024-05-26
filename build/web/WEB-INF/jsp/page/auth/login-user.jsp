<%-- 
    Document   : login
    Created on : May 2, 2024, 1:32:04 PM
    Author     : fenor
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/save.css">
        <title>Login-page</title>
    </head>
    <body>
        <div class="page" id="page">
                  
            <section class="save">
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
                    <h3 class="title">Log In</h3>
                    <p id="error" style="color: red"> </p>
                    <!-- Mot de passe -->
                    <label for="telephone">Numero Telephone* :  <p id="errorNumero" style="color: red"></p></label>
                    <input type="tel" id="telephone" name="telephone" value="">
                    <br>
                    <!-- Bouton de soumission -->
                    <input type="submit" value="Log In">
                    
                </form>
            </section>
        </div>
    </body>
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
                                console.log('Succès: ' + content);
                                window.location.href = 'http://localhost:8084/BTP_construction'+content;
                            } else {
                                $("#" + type).text(content);
                                console.error('Erreur: ' + content);
                            }
                        });
                    }
                };

                var params = $('form').serialize().toString();
                console.log(params);
                xmlhttp.open("POST", "user-login", true);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp.send(params);
            });
        });

    </script>
    
</html>
