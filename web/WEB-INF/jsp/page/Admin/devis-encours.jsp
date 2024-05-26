<%-- 
    Document   : devis-encours
    Created on : May 14, 2024, 9:12:01 PM
    Author     : fenor
--%>

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
    
//    if(user == null) response.sendRedirect("admin");
    
    List<V_detailDevis> devis = (List<V_detailDevis>) request.getAttribute("devisEncours");
    
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
<body style="overflow-y: scroll">
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
                <h3 class="title ">Liste Devis Encours</h3>
                
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
                                        <% if(dev.getProgression()<50.0) { %>
                                            <p style="color:red">Paiement effectué: (<%= formatNumber.format(dev.getProgression())%>%)</p>
                                        <% } else if (dev.getProgression() > 50) { %>
                                            <p style="color:green">Paiement effectué: (<%= formatNumber.format(dev.getProgression())%>%)</p>
                                        <% } else { %>
                                            <p>Paiement effectué: (<%= formatNumber.format(dev.getProgression())%>%)</p>
                                        <% } %>
                                    </div>
                                    <a href="devis-details-admin?devis=<%= dev.getIdDevis() %>" class="buttonProduit">Detailer</a>
                                    <% if(dev.getRestePayer()<=0.0) { %> <a href="" style="background-color:#4bd700" class="buttonProduit">Paiement Effectuée</a><% } %>
                                    
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