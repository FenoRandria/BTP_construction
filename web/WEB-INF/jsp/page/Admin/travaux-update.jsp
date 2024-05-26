<%-- 
    Document   : travaux-update
    Created on : May 15, 2024, 8:24:11 AM
    Author     : fenor
--%>

<%@page import="model.DetailDevisMaison"%>
<%-- 
    Document   : stationnement
    Created on : May 9, 2024, 11:10:36 PM
    Author     : fenor
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<% 

    User user = (User) session.getAttribute("user");
    DetailDevisMaison devis = null;
    if(request.getAttribute("devis")!=null){
        devis = (DetailDevisMaison) request.getAttribute("devis");
    } else {
        out.println("<h1>"+"tsy misy azo"+"</h1>");
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Product</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/boxicons.min.css'>
    
</head>
<body>
    <div class="sidebar close">
        <div class="logo-details" style="padding-top:20px;">
            <img width="50px" height="50px" src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" srcset="">
            <span class="logo_name">Evaluation</span>
        </div>
        <ul class="nav-links">

            <li>
                <a href="dashboard">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="dashboard">Dashboard</a></li>
                </ul>
            </li>
            
            <li>
                <a href="devis-encours">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Devis En Cours</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis-encours">Devis En Cours</a></li>
                </ul>
            </li>
            
          
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Import Data</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Import Data</a></li>
                    <li><a href="import-data-file">Maison-Travaux</a></li>
                    <li><a href="import-paiement">Paiement</a></li>
                </ul>
            </li>
           
            <li>
                <a href="travaux">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Gestion Travaux</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="travaux">Gestion Travaux</a></li>
                </ul>
            </li>
            
            <li>
                <a href="finition">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Gestion Finition</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="finition">Gestion Finition</a></li>
                </ul>
            </li>
            
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name">Admin </div>
                        <div class="job">Developper</div>
                    </div>
                    <i class='bx bx-log-out'></i>
                </div>
            </li>
        </ul>
    </div>
    <section class="home-section">
        <div class="home-content">
            <i class='bx bx-menu'></i>
            <div id="page">
                <!-- ----------------------Code taloha------------------------- -->
                 <header>
                    <div class="logo">
                        <!-- <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" /> -->
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                                <li><a href="" class="">Home</a></li>
                                <li><a href="#" class="actif">tableau</a></li>
                                <li><a href="list" class="">List</a></li>
                                <li><a href="chart" class="">Chart</a></li>
                                <li><a href="formulaire" class="">Formulaire</a></li>
                            </ul>
                        </div>
                        <div class="recherche">
                            <form action="../page/resultatRecherche.html" method="get">
                                <input type="text" name="" id="search" placeholder="Votre Recherche" />
                                <button>
                                    <img src="${pageContext.request.contextPath}/assets/img/btnSearchnoneFOnd.png" alt="">
                                </button>
                            </form>
                        </div>
                        <div class="profilOUt">
                            <div class="profil">
                                <div class="imageProfile">
                                    <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3><% if(user!=null) out.print(user.getNom()); %></h3>
                                    <p>4.674.00 Point</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="#">Log Out</a>
                                </div>
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/assets/img/logOut.png" alt="">
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>
                <h3 class="title ">Modification Travaux</h3>
                
                <section class="fichier">
                    <form action="update-travaux-detail" method="POST" id="travauxForm">
                        <p class="errors" id="error" style="color:red;font-size: 1rem" ></p>
                        <% if(devis!=null) { %>
                            
                            <h3>Code Travaux: </h3>
                            
                            <p class="errors" id="errorCode" style="color:red;font-size: 1rem"></p>
                            <input type="text" name="code" id="code" value="<%= devis.getCode()%>">
                            
                            <h3>Descriptions: </h3>
                            <p class="errors" id="errorDescriptions:" style="color:red;font-size: 1rem"></p>
                            <input type="text" name="descriptions" id="descriptions" value="<%= devis.getDescriptions() %>">
                            
                            <h3>Prix Unitaire</h3>
                            <p class="errors" id="errorPrixUnitaire" style="color:red;font-size: 1rem"></p>
                            <input type="text" name="prixUnitaire" value="<%= devis.getPrixUnitaire() %>" id="prixUnitaire">
                            
                            <h3>Quantite</h3>
                            <p class="errors" id="errorQuantite" style="color:red;font-size: 1rem"></p>
                            <input type="text" name="quantite" value="<%= devis.getQuantite() %>" id="quantite" > 
                            
                            
                            <input type="hidden"  name="id" id="id" value="<%= devis.getId() %>" >
                            <input type="submit" value="Valider">
                          <% } %>
                    </form>
                    
                    
                    <style>
                        /* Style général du formulaire */
                        form {
                            font-family: Arial, sans-serif;
                            width: 600px;
                            margin: 0 auto;
                            padding: 20px;
                            height: 580px;
                            background-color: #f9f9f9;
                            border-radius: 8px;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                        }

                        /* Style des titres des questions */
                        th {
                            text-align: left;
                        }

                        /* Style des options de réponse */
                        td {
                            padding: 5px;
                        }

                        /* Style des boutons et des champs de sélection */
                        input,
                        select {
                            width: 100%;
                            padding: 10px;
                            margin-bottom: 10px;
                            border: 1px solid #ccc;
                            border-radius: 4px;
                            box-sizing: border-box;
                        }

                        /* Style du bouton Soumettre */
                        input[type="submit"] {
                            width: 100%;
                            padding: 10px;
                            background-color: #4CAF50;
                            color: white;
                            border: none;
                            border-radius: 4px;
                            cursor: pointer;
                        }

                        /* Changement de couleur au survol du bouton Soumettre */
                        input[type="submit"]:hover {
                            background-color: #45a049;
                        }

                    </style>
                </section>
                <!-- ----------------------Code taloha------------------------- -->
            </div>
    </section>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/assets/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function removeError()
        {
           var errors = document.getElementsByClassName("errors");
           for(let i = 0; i< errors.length; i++){
               errors[i].innerText ="";
           }
        }

//        $(document).ready(function() {
//            $('#travauxForm').submit(function(event) {
//                event.preventDefault();
//                removeError();
//                let params = $('form').serialize().toString();
//                var xmlhttp = new XMLHttpRequest();
//                xmlhttp.onreadystatechange = function () 
//                {
//                    console.log(1,this.responseText);
//                    if (this.readyState === 4 && this.status === 200) 
//                    {
                        console.log(2,this.responseText);
//                        var messages = this.responseText.split("+");
                        
//                        console.table(messages);
//                        messages.forEach(function(message) {
//                            var parts = message.split(":");
//                            var type = parts[0];
//                            var content = parts[1];
//                            if (type === 'success') {
//                                console.log('Succès: ' + content);
//                                window.location.href = 'http://localhost:8084/BTP_construction'+content;
//                            } else {
//                                $("#" + type).text(content);
//                                console.error('Erreur: ' + content, type);
//                            }
//                        });
//                    }
//                };
//                console.log(params);
//                
//                xmlhttp.open("POST", "update-travaux-detail", true);
//                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//                xmlhttp.send(params);
//            });
//        });
       

    </script>
    </div>
</body>
</html>