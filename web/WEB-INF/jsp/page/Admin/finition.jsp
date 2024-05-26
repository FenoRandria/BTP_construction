<%-- 
    Document   : detailDevisMaison
    Created on : May 15, 2024, 2:21:04 AM
    Author     : fenor
--%>


<%@page import="model.TypeFinition"%>
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
    List<TypeFinition> stationements = null;
    if(request.getAttribute("listTypeFinition")!=null){
        stationements = (ArrayList<TypeFinition>) request.getAttribute("listTypeFinition");
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
                    <h1 class="textTitre">Type de <span>Finition</span></h1>
                    <div class="insertionProduit">
                        <div class="gestionProduit">
                            <!------------------Tablau Place ---------------------->
                        <div class="listProduit">

                            <h1><b><span> Type finition </span></b><span class="item-number"></span></h1>
                            <table border=1>
                                <thead>
                                    <tr>
                                        <th>Type Finition</th>
                                        <th>Pourcentage (%)</th>
                                        <th>--</th
                                    </tr>
                                </thead>
                                <tbody>
                                <% if(stationements!=null) {
                                    for(int i = 0; i< stationements.size(); i++) { %>
                                        <% TypeFinition detail = (TypeFinition) stationements.get(i); %>
                                        <tr id="<%= detail.getId()%>">
                                            <td class="texteFormat"><%= detail.getTypeFinition() %></td>  
                                            <td class="texteFormat"><%= detail.getNiveau() %></td> 
                                            <td><a href="update-finition?id=<%= detail.getId()%>" class="show" >Modifier</a></td>
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
                            <div class="modificationProduit">
                                <div style="display:flex; flex-direction: column; gap:0px;">
                                    <h1>Sortir <span> Parcking </span> <br> Place: <span id="numeroPlace"></span> </h1>
                                    <p id="affErrors" style="color:red; font-size:.8rem;"><p>
                                </div>
                                
                                <form id="formSortie">
                                    <input type="datetime-local" onchange="verificationDate(sortie.value, dateAjoutVoiture.value)" name="sortie" value="" id="sortie" placeholder="Sortie Parking"  required>
                                    <input type="hidden" name="id" id="id" value="">          
                                    <input type="hidden" name="dateAjoutVoiture" id="dateAjoutVoiture" value="">
                                    <input type="button" value="Valider" id="validationPopUp">
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
    var production = document.querySelector(".production");
    function closer(params) {
        production.classList.add("");
    }
//===============================  debut pop sortir parking formulaire ==================================================
//    function sortirParking(id,numero,dateAjout) {
//        console.log(id,numero,dateAjout);
//        production.style.display = "flex";
//        document.getElementById('id').value = id;        
//        document.getElementById('numeroPlace').innerHTML = numero;        
//        document.getElementById('dateAjoutVoiture').value = dateAjout;
//        document.getElementById("myPopup").style.display = "block";
//    }
    
    function verificationDate(sortie,dateAjout){
        var errors = document.getElementById("affErrors"); 
        console.log(errors);
        errors.innerText = "";
        console.log(sortie ,"----", dateAjout);
        var dateString1 = sortie;
        var date1 = new Date(dateString1);
        
        var dateString2 = dateAjout;
        // Convertir la deuxième date en objet Date
        var dateArray = dateString2.split(/[- :]/);
        // mois est 0-indexé dans JavaScript, donc soustrayez 1 du mois
        var date2 = new Date(Date.UTC(dateArray[0], dateArray[1] - 1, dateArray[2], dateArray[3], dateArray[4]));

        // Comparaison des dates
        if (date1 > date2) {
            errors.innerText = ""
            console.log("La première date est postérieure à la deuxième date.");
        } else if (date1 < date2) {
            errors.innerHTML = "Date anterieur à la date d'ajout";
            console.log("La première date est antérieure à la deuxième date.");
        } else {
//            errors.innerText="date invalid, anterieur à la Date Ajout";
            console.log("Les deux dates sont égales.");
        }
    }
//=============================== end pop sortir parking formulaire ==================================================

    document.getElementById("closePopUp").addEventListener("click", function () {
        document.getElementById("myPopup").style.display = "none";
    });


// ====================================== Pop Up Validation =============================================================
    document.getElementById("validationPopUp").addEventListener("click", function () {
        document.getElementById("myPopupValidation").style.display = "block";
        console.log(document.getElementById("myPopupValidation"));
        event.preventDefault();
    });
//    
//    =================================== ajax data ====================================================================
    function validForm() {
        let params = $('form').serialize().toString();
        console.log(params);
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () 
        {
            if (this.readyState === 4 && this.status === 200) 
            {
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
        console.log(params);

        xmlhttp.open("POST", "sortie-place", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(params);
    }


    document.getElementById("closePopUpValidation").addEventListener("click", function () {
        document.getElementById("myPopupValidation").style.display = "none";
    });
</script>