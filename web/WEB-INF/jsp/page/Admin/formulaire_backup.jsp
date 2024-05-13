<%-- 
    Document   : formulaire
    Created on : May 2, 2024, 2:16:57 PM
    Author     : fenor
--%>

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
                <a href="#">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Category</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-collection'></i>
                        <span class="link_name">Category</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Category</a></li>
                    <li><a href="#">HTML & CSS</a></li>
                    <li><a href="#">JavaScript</a></li>
                    <li><a href="#">PHP & MySQL</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Auth</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Auth</a></li>
                    <li><a href="auth/admin">Login Admin</a></li>
                    <li><a href="auth/user">Login User</a></li>
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
                <a href="#">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Chart</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Chart</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-plug'></i>
                        <span class="link_name">Plugins</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Plugins</a></li>
                    <li><a href="#">UI Face</a></li>
                    <li><a href="#">Pigments</a></li>
                    <li><a href="#">Box Icons</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-compass'></i>
                    <span class="link_name">Explore</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Explore</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-history'></i>
                    <span class="link_name">History</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">History</a></li>
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
                        <div class="profile_name">Feno Randria</div>
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
                                    <h3>hariaja</h3>
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
                <h3 class="title ">Insertion Product</h3>

                <section class="save" style="overflow-y: scroll;">
                    <form action="" method="post" >
                        <!-- Texte simple -->
                        <label for="texte">Texte :</label>
                        <input type="text" id="texte" name="texte">

                        <!-- Mot de passe -->
                        <label for="motdepasse">Mot de passe :</label>
                        <input type="password" id="motdepasse" name="motdepasse">

                        <!-- Champ de recherche -->
                        <label for="recherche">Recherche :</label>
                        <input type="search" id="recherche" name="recherche">

                        <!-- Numérique -->
                        <label for="numerique">Numérique :</label>
                        <input type="number" id="numerique" name="numerique">

                        <!-- Email -->
                        <label for="email">Email :</label>
                        <input type="email" id="email" name="email">

                        <!-- Date -->
                        <label for="date">Date :</label>
                        <input type="date" id="date" name="date">

                        <!-- Heure -->
                        <label for="heure">Heure :</label>
                        <input type="time" id="heure" name="heure">


                        <!-- Range (glissière) -->
                        <label for="range">Range :</label>
                        <h3>Etat <span id="displayValue"></span></h3>
                        <input type="range" name="etat" id="rangeInput" min="0" max="100">
                        <!-- Case à cocher -->
                        <label for="case">Case à cocher :</label>
                        <input type="checkbox" id="case" name="case">

                        <!-- Bouton radio -->
                        <label for="radio1">Radio 1 :</label>
                        <input type="radio" id="radio1" name="radio" value="radio1">
                        <label for="radio2">Radio 2 :</label>
                        <input type="radio" id="radio2" name="radio" value="radio2">

                        <!-- Bouton de sélection de fichier -->
                        <label for="fichier">Sélectionnez un fichier :</label>
                        <input type="file" id="fichier" name="fichier">
                        
                        
                        <div class="drop-zone-section">
                            <label for="images" class="drop-container" id="dropcontainer">
                            <span class="drop-title">Drag file here</span>
                            or
                            <input type="file" multiple id="images" accept="image/*" required>
                            </label>
                        </div>

                        <!-- Bouton de soumission -->
                        <input type="submit" value="Soumettre">
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
