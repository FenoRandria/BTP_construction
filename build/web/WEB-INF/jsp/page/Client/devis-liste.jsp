<%@page import="model.V_detailDevis"%>
<%@page import="model.Devis"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8" %>
<% 
    User user = (User) session.getAttribute("user");
    List<V_detailDevis> devis = (List<V_detailDevis>) request.getAttribute("devis");
    
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
                    <span class="link_name">CrÃ©ation Devis</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis-form">CrÃ©ation Devis</a></li>
                </ul>
            </li>
            
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name"><% if(user!=null) out.print(user.getNumero()); %></div>
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
                        <%-- <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" /> --%>
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                                <li><a href="#" class="">Home</a></li>
                                <li><a href="tableau" class="">tableau</a></li>
                                <li><a href="#" class="actif">List</a></li>
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
                                    <img src="${pageContext.request.contextPath}/assets/img/me.jpeg" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3><% if(user!=null) out.print(user.getNumero()); %></h3>
                                    <p>Actif</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="logout">Log Out</a>
                                </div>
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/assets/img/logOut.png" alt="">
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>
                <h3 class="title ">Liste de Votre Devis</h3>
                
                <section class="fichier">
                    <% 
                        DecimalFormat formatNumber = new DecimalFormat("#,##0.00"); 
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
                        java.sql.Date daty = Date.valueOf("2023-05-15");
                    %>
                    
                    
                    <% if(devis!=null) { %>
                        <% for(int i = 0; i< devis.size(); i++) { %>
                            <% V_detailDevis dev = (V_detailDevis) devis.get(i); %>
                            <!----------------/Produit anakiray--------------->
                            <div class="fichierTwo">
                                <div class="image_produit">
                                    <div class="imageGauche">
                                        <img src="${pageContext.request.contextPath}/assets/img/class1.jpeg" alt="">
                                    </div>
                                    <div class="imageDroite">
                                        <div class="img1Droite">
                                            <img src="${pageContext.request.contextPath}/assets/img/class2.jpeg" alt="">
                                        </div>
                                        <div class="img2Droite">
                                            <img src="${pageContext.request.contextPath}/assets/img/class3.jpeg" alt="">
                                        </div>
                                        <div class="img3Droite">
                                            <img src="${pageContext.request.contextPath}/assets/img/class4.jpeg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="prix">
                                    <div id="descriptions">
                                        <h4>Devis: <span><%= dev.getIdDevis()%></span></h4>
                                        <h4>Maison de Type: <span><%= dev.getMaisonNom()%></span></h4>
                                        <h4>Durée construction: <span><%= dev.getDuree()%> j</span></h4>
                                        <h4>Montant: <span><%= formatNumber.format(dev.getDevisMontant())%></span></h4>
                                        <h4>Reste Ã  payer : <span><%= formatNumber.format(dev.getRestePayer())%></span></h4>
                                        <p>Debut de Projet : <%= dateFormat.format(new java.util.Date(dev.getDateDebut().getTime()))%></p>
                                        <p>Fin de Projet : <%= dateFormat.format(new java.util.Date(dev.getDateFin().getTime()))%></p>
                                        <p>Paiement effectué: (<%= formatNumber.format(dev.getProgression())%>%)</p>
                                        
                                    </div>

                                    <a href="devis-details?devis=<%= dev.getIdDevis() %>" class="buttonProduit">Detailer</a>
                                    <% if(dev.getRestePayer()>0.0) { %> <a href="devis-paiement?devis=<%= dev.getIdDevis() %>" style="background-color:#005b85" class="buttonProduit">Payer</a><% } %>
                                    <% if(dev.getRestePayer()<=0.0) { %> <a href="" style="background-color:#4bd700" class="buttonProduit">Payement finis</a><% } %>

                                </div>
                            </div>
                        <% } %>
                    <% } %>
                        
                </section>
                <!-- ----------------------Code taloha------------------------- -->
            </div>
    </section>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    </div>
</body>
</html>
