<%-- 
    Document   : login
    Created on : May 2, 2024, 1:32:04 PM
    Author     : fenor
--%>
<%@page pageEncoding="UTF-8" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <form id="inscrireForm" >
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
                    <h3 class="title">Inscription</h3>
                    <p id="error"> </p>
                    <!-- Nom -->
                    <label for="name">Nom : <p id="errorNom" style="color:red"></p></label>
                    <input type="text" id="nom" name="nom">

                    <!-- Email -->
                    <label for="email">Email : <p id="errorMail" style="color:red"></p></label>
                    <input type="email" id="email" name="mail">

                    <!-- Mot de passe -->
                    <label for="motdepasse">Mot de passe :  <p id="errorMdp" style="color: red"></p></label>
                    <input type="password" id="motdepasse" name="mdp">

                     <!-- reppass Mot de passe -->
                    <label for="motdepasse">Retape Mot de passe :  <p id="errorRemdp" style="color: red"></p></label>
                    <input type="password" id="remotdepasse" name="remdp">

                    <br>
                    <!-- Bouton de soumission -->
                    <input type="submit" value="Inscrire">
                    <br>
                    <a href="user" style="color:lightskyblue; text-decoration: none;"><-- Déjà inscrire sur GGPARK</a>
                </form>
            </section>
                
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/assets/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <script>
            $(document).ready(function() {
            $('#inscrireForm').submit(function(event) {
                event.preventDefault();
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
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
                let  nom = $('#nom').val();
                let mail = $('#email').val();                
                let mdp = $('#motdepasse').val();                
                let remdp = $('#remotdepasse').val();



                var params = "mail=" + encodeURIComponent(mail) + "&mdp=" + encodeURIComponent(mdp) + "&nom=" + encodeURIComponent(nom)+ "&remdp=" + encodeURIComponent(remdp);
                xmlhttp.open("POST", "user-inscrire", true);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp.send(params);
            });
        });
    </script>
    
</html>
