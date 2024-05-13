<%-- 
    Document   : devis-paiement
    Created on : May 13, 2024, 9:45:08 AM
    Author     : fenor
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="model.User"%>
<% 

    User user = (User) session.getAttribute("user");


%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/save.css">
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
                    <span class="link_name">Cr�ation Devis</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis-form">Cr�ation Devis</a></li>
                </ul>
            </li>
            
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name"><% if(user!=null) out.print(user.getNom()); %></div>
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
                <!------------------Code taloha------------------ -->
                <header>
                    <div class="logo">
                        <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" />
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}" class="">Home</a></li>
                                <li><a href="tableau" class="">Devis</a></li>
                                <li><a href="list" class="">Statistique</a></li>
                                <li><a href="formulaire" class="actif">Paiement</a></li>
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
                                    <img src="${pageContext.request.contextPath}/assets/img/me.jpeg" alt="">
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
                <h3 class="title ">Insertion Place</h3>

                <section class="save" style="overflow-y: scroll;">
                    <form action="insert-place" method="post" >
                        <h3>Montant � payer : </h3>
                        <p class="errors" id="errorMontant" style="color:red;font-size: 1rem"></p>
                        <input type="number" name="montant" id="montant">
                        
                        <h3>Date de Paiement</h3>
                        <p class="errors" id="errorDatePaiement" style="color:red;font-size: 1rem"></p>
                        <input type="date" name="datePaiement" id="datePaiement" required>

                        <input type="submit" value="Valider">
                    </form>
                </section>
                <!------------------Code taloha------------------ -->
            </div>
    </section>
    </div>
</body>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script>

    var rangeInput = document.getElementById('rangeInput');
    var displayValue = document.getElementById('displayValue');

    rangeInput.addEventListener('input', function () {
        var value = rangeInput.value;
        displayValue.textContent = ': ' + value;
    });
</script>

<script>
    //drag file
    const dropContainer = document.getElementById("dropcontainer");
    const fileInput = document.getElementById("images");
    document.getElementById("delete-button").onclick = ()=>{
        document.getElementById("popup-section").style.display = "block";
    }
    dropContainer.addEventListener("dragover", (e) => {
    e.preventDefault()
    }, false);

    dropContainer.addEventListener("dragenter", () => {
    dropContainer.classList.add("drag-active")
    });

    dropContainer.addEventListener("dragleave", () => {
    dropContainer.classList.remove("drag-active")
    });

    dropContainer.addEventListener("drop", (e) => {
    e.preventDefault()
    dropContainer.classList.remove("drag-active")
    fileInput.files = e.dataTransfer.files
    });
</script>


</html>

