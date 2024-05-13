<%@page import="model.User"%>
<%@page import="java.sql.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% 

    User user = (User) session.getAttribute("user");    
//    List<V_stationement> stationements = null;
//    if(request.getAttribute("stationements")!=null){
//        stationements = (ArrayList<V_stationement>) request.getAttribute("stationements");
//    } else {
//        out.println("<h1>"+"tsy misy azo"+"</h1>");
//    }

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
            <img width="50px" height="50px"
                src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" srcset="">
            <span class="logo_name">Evaluation</span>
        </div>
        <ul class="nav-links">
            <li>
                <a href="places">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Placement</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="places">Placement</a></li>
                </ul>
            </li>

            <li>
                <a href="enlevement">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Enlevement</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="enlevement">Enlevement</a></li>
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
                                <li><a href="#" class="">Home</a></li>
                                <li><a href="/facture" class="">Facture</a></li>

                            </ul>
                        </div>
                        <div class="recherche">
                            <form action="../page/resultatRecherche.html" method="get">
                                <input type="text" name="" id="search" placeholder="Votre Recherche" />
                                <button>
                                    <img src="${pageContext.request.contextPath}/assets/img/btnSearchnoneFOnd.png"
                                        alt="">
                                </button>
                            </form>
                        </div>
                        <div class="profilOUt">
                            <div class="profil">
                                <div class="imageProfile">
                                    <img src="${pageContext.request.contextPath}/assets/img/me.jpeg"
                                        alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3>hariaja</h3>
                                    <p>4.674.00 Point</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="#">Log Out</a>
                                </div>
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/assets/img/logOut.png"
                                        alt="">
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>
                <h3 class="title ">Facture</h3>

                <section class="fichier">
                    <!-- ----------------------Facture------------------------- -->
                    <div class="facture_pariking_ticket">
                        <div class="header">
                            <p class="tiretire">
                                -------------------------------------------------------------</p>
                            <h1 class="titre_Facture">AMENDE</h1>
                            <p><span>Facture numero:</span>00012001</p>
                            <p class="tiretire">
                                -------------------------------------------------------------</p>
                            <div class="dateTimeParking">
                                <p><span>Date Arriver:</span> 09/05/2024</p>
                                <p><span>Time Arriver:</span> 12:02</p>
                            </div>
                            <div class="dateTimeParking">
                                <p><span>Date Sortie:</span> 09/05/2024</p>
                                <p><span>Time Sortie:</span> 12:02</p>
                            </div>
                        </div>
                        <div class="details">
                            <p><span>Durée depasser:</span> 2 heures</p>
                            <p><span>Montant A payer:</span> 500 Ar</p>
                            <p class="tiretire">
                                -------------------------------------------------------------</p>
                            <h2>Merci de payer votre AMENDE !<h2>
                                    <p class="tiretire">
                                        -------------------------------------------------------------
                                    </p>
                        </div>
                    <a href="#" class="delete" id="popupButton">Payer</a>
                    </div>
                    <!-- ----------------------/Facture------------------------- -->
                    <!-------------------------Pop Up ---Enlever Place------------>
                    <div class="popup" id="myPopup">
                        <div class="popup-content">
                            <!-- -----------------Tsy azo Esorina------------------------->
                            <span class="close" id="closePopUp">&times;</span>
                            <!-- -----------------/Tsy azo Esorina ------------------------->
                            <h1>Enlever  <span> Place </span></h1>
                            <form method="get" action="amende">
                                <input type="number" name="compteNum" value="" id="name" placeholder="Numero De compte" required>
                                <input type="password" name="password" value="" id="name" placeholder="Password" required>
                                <input type="submit" value="Valider">
                            </form>
                        </div>
                    </div>
                    <!-------------------------Pop Up ---Enlever Place------------>


                </section>
                <!-- ----------------------Code taloha------------------------- -->
            </div>
    </section>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    </div>
</body>
</html>
<script>

//Pop Up Formulaire
    document.getElementById("popupButton").addEventListener("click", function () {
        document.getElementById("myPopup").style.display = "block";
    });


    document.getElementById("closePopUp").addEventListener("click", function () {
        console.log("Tu as clicker");
        document.getElementById("myPopup").style.display = "none";
    });
</script>   