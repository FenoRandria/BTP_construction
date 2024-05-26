<%-- 
    Document   : detailDevisMaison
    Created on : May 15, 2024, 2:21:04 AM
    Author     : fenor
--%>


<%@page import="model.DetailDevisMaison"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8" %>

<% 

    User user = (User) session.getAttribute("user");    
    List<DetailDevisMaison> stationements = null;
    if(request.getAttribute("listTravail")!=null){
        stationements = (ArrayList<DetailDevisMaison>) request.getAttribute("listTravail");
    } else {
        out.println("<h1>"+"tsy misy azo"+"</h1>");
    }

%>

<% 
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator(' '); 
    DecimalFormat formatNumber = new DecimalFormat("#,###.##", symbols); 
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
    double nombre = 0.0;
    if ((nombre % 1) == 0) { 
        formatNumber = new DecimalFormat("#,###.##", symbols);
    } else {
        formatNumber = new DecimalFormat("#,##0.00", symbols);
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tableau.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link rel='stylesheet' href='${pageContext.request.contextPath}/assets/css/boxicons.min.css'>
    <title>Tableau</title>
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
                    
                </header>
                <div class="generateProd">
                    <h1 class="textTitre">Enlevement de <span>Voiture</span></h1>
                    <div class="insertionProduit">
                        <div class="gestionProduit">
                            <!------------------Tablau Place ---------------------->
                        <div class="listProduit">

                            <h1><b>Votre <span> Place sur Parking </span></b><span class="item-number"></span></h1>
                            <table border=1>
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Travaux</th>
                                        <th>Prix Unitaire</th>
                                        <th>Quantité</th>
                                        <th>Unité</th>
                                        <th>--</th
                                    </tr>
                                </thead>
                                <tbody>
                                <% if(stationements!=null) {
                                    for(int i = 0; i< stationements.size(); i++) { %>
                                        <% DetailDevisMaison detail = (DetailDevisMaison) stationements.get(i); %>
                                        <tr id="<%= i %>">
                                            <td class="texteFormat"><%= detail.getCode()%></td>  
                                            <td class="texteFormat"><%= detail.getDescriptions() %></td> 
                                            <td class="texteFormat"><%= detail.getPrixUnitaire() %></td>
                                            <td class="texteFormat"><%= detail.getQuantite() %></td>
                                            
                                            <td>
                                                <a class="modifier" href="update-travaux?id=<%= detail.getId() %>" >Modifier</a>
                                            </td>
                                        </tr>
                                    <% } %>                                            
                                <% } %>
                                </tbody>
                            </table>
                            <div class="pagination-wrapper">
                                
                                <select id="rowsPerPageSelect">
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                </select>
                                
                               <button class="prev"><<<</i></button>
                               <span class="page-info"> </span>
                               <button class="next">>>></button>
                            </div>
                            <script src="${pageContext.request.contextPath}/assets/js/pagination.js"></script>
                        </div>
                    </div>
                </div>
                <!-- -----------------PopUp ------------------------->
                <div class="popup" id="myPopup">
                    <div class="popup-content">
                        <!-- -----------------Tsy azo Esorina------------------------->
                        <span class="close" id="closePopUp">&times;</span>
                        <!-- -----------------/Tsy azo Esorina ------------------------->
                        <div class="production">
                                <!---------------------Modification---------------------->
                            <div class="modificationProduit">
                                <h1>Modification <span> Travaux </span><span class="close" id="closeButton"><button
                                            onclick="closer()"> &times;</button></span></h1>
                                <form id="formTravaux">
                                    <p>descriptions</p>
                                    <input type="text" name="descriptions" value="" id="descriptions" placeholder="descriptions" required >
                                    <p id="errorDescriptions" class="error"></p>
                                    <p>prixunitaire</p>
                                    <input type="text" name="prixunitaire" value="" id="prixunitaire" placeholder="prixunitaire" required >
                                    <p id="errorPrixunitaire"  class="error" ></p>
                                    <p>Quantite</p>
                                    <input type="text" name="Quantite" value="" id="Quantite" placeholder="Quantite" required >
                                    <p id="errorQuantite"  class="error" ></p>
                                    <p>unite</p>
                                    <input type="text" name="unite" value="" id="unite" placeholder="unite" required >
                                    <p id="errorUnite"  class="error" ></p>
                                    <br>
                                    <input type="hidden" name="id" id="id" value="">
                                    <input type="submit" value="Valider">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="popup" id="myPopupValidation">
                    <div class="popup-content">
                        <!-- -----------------Tsy azo Esorina------------------------->
                        <span class="close" id="closePopUpValidation">&times;</span>
                        <!-- -----------------/Tsy azo Esorina ------------------------->
                        <h1>Tena hosolina ve? </h1>
                        <p id="errorHeureSortie" id="error" style="color:red; font-size:.8rem;"><p>
                        <a class="show" onclick="validForm()">Oui</a>
                        <a href="" class="delete">Non</a>
                    </div>
                </div>
                <!-- ----------------------Code taloha------------------------- -->
        </div>
    </section>

    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/assets/libs/jquery/3.5.1/jquery.min.js"></script>
</body>

</html>
<style>
    @keyframes anamimationproductionup {
        from {
            transform: translateY(0px);
            opacity: 1;
        }

        to {
            opacity: 0;
            transform: translateY(-100px);
        }
    }
</style>
<script>
//    var production = document.querySelector(".production");
//
//    function modif(id,idtr) {
//        console.log(id,idtr,production);
//        production.style.display = "flex";
//        var trElement = document.getElementById(idtr);
//        // Extraire les éléments à l'intérieur de la balise <tr>
//        var tdElements = trElement.getElementsByTagName("td");
//
//        // Parcourir tous les éléments <td> et afficher leur contenu
//        document.getElementById('descriptions').value = tdElements[1].textContent;
//        document.getElementById('prixunitaire').value = tdElements[2].textContent;
//        document.getElementById('Quantite').value = tdElements[3].textContent;
//        document.getElementById('unite').value = tdElements[4].textContent;
//        var id = document.getElementById('id').value = id;
//    }
    
    
//    var production = document.querySelector(".production");
    
//    function closer(params) {
//        production.classList.add("");
//    }

//=============================== end pop sortir parking formulaire ==================================================

//    document.getElementById("closePopUp").addEventListener("click", function () {
//        document.getElementById("myPopup").style.display = "none";
//    });


// ====================================== Pop Up Validation =============================================================
//    document.getElementById("validationPopUp").addEventListener("click", function () {
//        document.getElementById("myPopupValidation").style.display = "block";
//        console.log(document.getElementById("myPopupValidation"));
//        event.preventDefault();
//    });
//    
//    =================================== ajax data ====================================================================
//    function validForm() {
//        let params = $('formTravaux').serialize().toString();
//        console.log(params);
//        var xmlhttp = new XMLHttpRequest();
//        xmlhttp.onreadystatechange = function () 
//        {
//            if (this.readyState === 4 && this.status === 200) 
//            {
//                console.log(this.responseText);
//                var messages = this.responseText.split("+");
//
//                messages.forEach(function(message) {
//                    console.log(message);
//                    var parts = message.split(":");
//                    var type = parts[0];
//                    var content = parts[1];
//                    if (type === 'success') {
//                        console.log('Succès: ' + content);
//                        window.location.href = 'http://localhost:8084/BTP_construction'+content;
//                    } else {
//                        $("#" + type).text(content);
//                        console.error('Erreur: ' + content);
//                    }
//                });
//            }
//        };
//        console.log(params);
//
//        xmlhttp.open("POST", "update-detail-devis-maison", true);
//        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//        xmlhttp.send(params);
//    }
//
//
//    document.getElementById("closePopUpValidation").addEventListener("click", function () {
//        document.getElementById("myPopupValidation").style.display = "none";
//    });
</script>