<%-- 
    Document   : formulaire
    Created on : May 2, 2024, 2:16:57 PM
    Author     : fenor
--%>
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
                <a href="dashboard">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Place</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-collection'></i>
                        <span class="link_name">Place</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="gestion-places">List-Place</a></li>
                    <li><a href="ajout-place">Ajout Place</a></li>
                    <li><a href="gestion-places">Modifier Place</a></li>
                    <li><a href="gestion-places">Supprimer Place</a></li>
                </ul>
            </li>

            <li>
                <a href="#">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Chart</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Chart</a></li>
                </ul>
            </li>
           
           
           
            <li>
                <a href="#">
                    <i class='bx bx-cog'></i>
                    <span class="link_name">Setting</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Setting</a></li>
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
                <!------------------Code taloha------------------ -->
                <header>
                    <div class="logo">
                        <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" />
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                                <li><a href="#" class="">Home</a></li>
                                <li><a href="tableau" class="">tableau</a></li>
                                <li><a href="list" class="">List</a></li>
                                <li><a href="chart" class="">Chart</a></li>
                                <li><a href="formulaire" class="actif">Formulaire</a></li>
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
                        <select name="idParking">
                            <option value="1">Parking 1</option>
                        </select>
                        <input type="text" name="numero" id="" placeholder="Numero Place" required>
                        <input type="submit" value="Inserer">
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
