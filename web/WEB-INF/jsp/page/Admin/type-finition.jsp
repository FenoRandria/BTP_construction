<%-- 
    Document   : type-finition
    Created on : May 15, 2024, 2:39:57 AM
    Author     : fenor
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="model.*"%>
<%@page import="java.sql.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator(' '); // Définir l'espace comme séparateur de groupe

    DecimalFormat formatNumber = new DecimalFormat("#,###.##"); 
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
    double nombre = 0.0;
    if ((nombre % 1) == 0) { // Si les deux nombres sont entiers
        formatNumber = new DecimalFormat("#,###.##", symbols); // Format sans décimales
    } else {
        formatNumber = new DecimalFormat("#,##0.00", symbols); // Format avec deux chiffres après la virgule
    }
        DecimalFormat decimalFormat = new DecimalFormat("#0.00");

   TypeFinition[] typeFinitions =  (TypeFinition[])request.getAttribute("typeFinitions");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tableau.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <!-- Boxiocns CDN Link -->
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
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
                <div class="iocn-link">
                    <a href="listDevisAdmin">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Devis En Cours</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="listDevisAdmin">Devis En Cours</a></li>
                    <li><a href="listTypemaison">LIST types de travaux</a></li>
                    <li><a href="listFinition">LIST des types de finition</a></li>
                    <li><a href="#">Card Design</a></li>
                    <li><a href="insertDonnee">Insert Donnee</a></li>
                    <li><a href="insertPayment">Insert Payment</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Analytics</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Analytics</a></li>
                </ul>
            </li>
            <li>
                <a href="adminChart">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Chart</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="admin">Chart</a></li>
                </ul>
            </li>
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name">Hariaja </div>
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
                        <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" /> 
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                    
                            </ul>
                        </div>
                       
                        <div class="profilOUt">
                            <div class="profil">
                                <div class="imageProfile">
                                    <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3>Hariaja</h3>
                                    <p>4.674.00 Point</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="logOut">Log Out</a>
                                </div>
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/assets/img/logOut.png" alt="">
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>
                <div class="generateProd">
                    <h1 class="textTitre">LIST <span>FINITION</span></h1>
                    <div class="insertionProduit">
                        <div class="gestionProduit">
                            <!------------------Tablau Produit---------------------->
                            <div class="listProduit">
                                <h1>List <span>  TYPE FINITION </span></h1>
                                <table border=1>
                                    <tr>
                                        <th>typefinition 🥇 </th>
                                        <th>pourcentage(%)</th>
                                        <th>--</th>
                                        <%-- <th>--</th> --%>
                                    </tr>
                                    <% for(int i=0; i<typeFinitions.length ;i++){ %>
                                    <tr id="<%= i %>">
                                        <td><%= typeFinitions[i].getTypeFinition() %></td>
                                        <td><%= decimalFormat.format((typeFinitions[i].getPourcentage() * 100)-100) %></td>
                                        <td><a class="modifier" onclick="modif(<%= typeFinitions[i].getId() %>,<%= i %>)">Modifier</a></td>
                                        <%-- <td><a href="#" class="delete" id="popupButton">Delete</a></td> --%>
                                    </tr>
                                    <% } %>
                                    <%-- <tr id="3">
                                        <td>Premium</td>
                                        <td>40%</td>
                                        <td><a class="modifier" onclick="modif(3)">Modifier</a></td>
                                        <td><a href="" class="delete" id="popupButton">Delete</a></td>
                                    </tr> --%>
                                </table>
                            </div>
                        </div>
                        <!------------------List Produit---------------------->
                        <div class="production">
                            <!---------------------Modification---------------------->
                            <div class="modificationProduit">
                                <h1>Modification <span> Produit </span><span class="close" id="closeButton"><button
                                            onclick="closer()"> &times;</button></span></h1>
                                <form action="updatePourcentage" method="get">
                                    <input type="text" name="nameTypeFinition" value="" id="name" placeholder="Name Produit"
                                        required>
                                    <input type="text" name="pourcentage" value="" id="pourcentage" placeholder="Prix Produit"
                                        required min=0>
                                        <p id="pourcentage-error" class="error" ></p>
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
                        <a href="" class="show">Oui</a>
                        <a href="" class="delete">Non</a>
                    </div>
                </div>
                <!-- ----------------------Code taloha------------------------- -->
            </div>
    </section>
    </div>
   <style>
    .error{
        color: #ff5656;
        font-size: 0.8rem;
    }
    </style>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
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

    function modif(id,idtr) {
        production.style.display = "flex";
        var trElement = document.getElementById(idtr);
        // Extraire les éléments à l'intérieur de la balise <tr>
        var tdElements = trElement.getElementsByTagName("td");

        // Parcourir tous les éléments <td> et afficher leur contenu
        document.getElementById('name').value = tdElements[0].textContent;
        document.getElementById('pourcentage').value = tdElements[1].textContent;
        var id = document.getElementById('id').value = id;
    }

 // Déclarer une variable pour suivre l'état de validation
var isValidForm = true;

// Ajouter un écouteur d'événement "change" à chaque champ de saisie
document.getElementById('descriptions').addEventListener('change', validateDescriptions);
document.getElementById('prixunitaire').addEventListener('change', validatePrixUnitaire);
document.getElementById('Quantite').addEventListener('change', validateQuantite);

// Fonction de validation de la description
function validateDescriptions() {
    var descriptionsInput = document.getElementById('descriptions');
    var errorMessage = document.getElementById('descriptions-error');
    
    if (descriptionsInput.value.trim() === '') {
        errorMessage.textContent = "La description ne peut pas être vide.";
        isValidForm = false; // Marquer le formulaire comme invalide
    } else {
        errorMessage.textContent = "";
        isValidForm = true; // Marquer le formulaire comme valide
    }
}

// Fonction de validation du prix unitaire
function validatePrixUnitaire() {
    var prixUnitaireInput = document.getElementById('prixunitaire');
    var errorMessage = document.getElementById('prixunitaire-error');
    var prixUnitaire = parseFloat(prixUnitaireInput.value.trim());

    if (isNaN(prixUnitaire) || prixUnitaire <= 0 || prixUnitaire > 100000000) {
        errorMessage.textContent = "Le prix unitaire doit être un nombre positif compris entre 0 et 100000000.";
        isValidForm = false; // Marquer le formulaire comme invalide
    } else {
        errorMessage.textContent = "";
        isValidForm = true; // Marquer le formulaire comme valide
    }
}

// Fonction de validation de la quantité
function validateQuantite() {
    var quantiteInput = document.getElementById('Quantite');
    var errorMessage = document.getElementById('quantite-error');
    var quantite = parseFloat(quantiteInput.value.trim());

    if (isNaN(quantite) || quantite < 1) {
        errorMessage.textContent = "La quantité doit être un nombre positif supérieur ou égal à 1.";
        isValidForm = false; // Marquer le formulaire comme invalide
    } else {
        errorMessage.textContent = "";
        isValidForm = true; // Marquer le formulaire comme valide
    }
}

// Ajouter un écouteur d'événement "submit" au formulaire
document.querySelector('form').addEventListener('submit', function(event) {
    // Empêcher la soumission du formulaire si isValidForm est faux
    if (!isValidForm) {
        event.preventDefault();
    }
});


</script>
