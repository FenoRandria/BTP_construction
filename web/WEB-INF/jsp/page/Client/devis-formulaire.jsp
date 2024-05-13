<%-- 
    Document   : devis-formulaire
    Created on : May 13, 2024, 9:44:22 AM
    Author     : fenor
--%>

<%-- 
    Document   : stationnement
    Created on : May 9, 2024, 11:10:36 PM
    Author     : fenor
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<% 


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
                <a href="devis">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Liste Devis</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis">Liste Devis</a></li>
                </ul>
            </li>

            <li>
                <a href="devis-form">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Création Devis</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis-form">Création Devis</a></li>
                </ul>
            </li>
            
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name"><% if(null!=null) out.print("Feno"); %></div>
                        <div class="job">Developper</div>
                    </div>
                        <i class='bx bx-log-out' onclick="Deconnect()" ></i>
                        <script>   
                            function Deconnect() {
                                var xmlhttp = new XMLHttpRequest();
                                xmlhttp.onreadystatechange = function () 
                                {
                                    if (this.readyState === 4 && this.status === 200) 
                                    {
                                        window.location.href = 'http://localhost:8084/promo13_parking';
                                    }
                                };
                                xmlhttp.open("POST", "logout", true);
                                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                xmlhttp.send(null);
                            }
                        </script>

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
                                    <h3><% if(null!=null) out.print("Feno"); %></h3>
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
                <h3 class="title ">Stationnement 🅿</h3>
                
                <section class="fichier">
                    <form id="stationForm">
                        <h3>Choisir Place Voiture</h3>
                        <p class="errors" id="error" style="color:red;font-size: 1rem"></p>
                        <table>
                                <p class="errors" id="errorIdPlace" style="color:red;font-size: 1rem"></p>
                                <tr>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 1</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 2</h3>
                                        <input width="50px" type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 3</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                </tr>

                                 <tr>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 1</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 2</h3>
                                        <input width="50px" type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 3</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 1</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 2</h3>
                                        <input width="50px" type="radio" name="idPlace" value=""> 
                                    </td>
                                    <td>
                                        <img width="100px" src="${pageContext.request.contextPath}/assets/img/sport1.jpeg" alt="">
                                        <h3>Maison 3</h3>
                                        <input type="radio" name="idPlace" value=""> 
                                    </td>
                                </tr>
                                
                        </table>

                        <h3>Type Finition</h3>
                        <p class="errors" id="errorFinition" style="color:red;font-size: 1rem"></p>
                        <select name="finition">
                            <option></option>                            
                            <option value="1">Standard</option>
                            <option value="2">Prémium</option>
                            <option value="3">V.I.P</option>
                            <option value="4">Gold</option>
                        </select>

                        <h3>Date début projet : </h3>
                        <p class="errors" id="errorDateDebut" style="color:red;font-size: 1rem"></p>
                        <input type="date" name="dateDebut" id="dateDebut">
 
                        <input type="submit" value="Valider Place">
                    </form>
                    <style>
                        /* Style général du formulaire */
                        form {
                            font-family: 'Urbanist';
                            width: 100%;
                            margin: 0 auto;
                            padding: 20px;
                            height: 800px;
                            background-color: #f9f9f9;
                            border-radius: 8px;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                            overflow-y: scroll;
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

        $(document).ready(function() {
            $('#stationForm').submit(function(event) {
                event.preventDefault();
                removeError();
                let params = $('form').serialize().toString();
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function () 
                {
                    if (this.readyState === 4 && this.status === 200) 
                    {
                        console.log(this.responseText);
                        var messages = this.responseText.split("+");
                        
//                        console.table(messages);
                        messages.forEach(function(message) {
                            console.log(message);
                            var parts = message.split(":");
                            var type = parts[0];
                            var content = parts[1];
                            if (type === 'success') {
                                console.log('Succès: ' + content);
                                window.location.href = 'http://localhost:8084/promo13_parking'+content;
                            } else {
                                $("#" + type).text(content);
                                console.error('Erreur: ' + content);
                            }
                        });
                    }
                };
                console.log(params);
                
                xmlhttp.open("POST", "prendre-place", true);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp.send(params);
            });
        });
       

    </script>
    </div>
</body>
</html>