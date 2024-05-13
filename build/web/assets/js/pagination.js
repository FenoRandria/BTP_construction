/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//    const tbody = document.querySelector('tbody');
//    let rowsPerPage = 5;
//    let currentPage = 1;
//    
//    
//
//function displayRows() {
//    let nbLigne = document.getElementById('rowsPerPageSelect').value;
//    if(nbLigne>0){
//        rowsPerPage = nbLigne;
//    }
//    
//    // Sélection des lignes de tableau
//    const rows = tbody.querySelectorAll('tr');
//    
//    // Indice de début et de fin des lignes à afficher pour la page actuelle
//    const startIndex = (currentPage - 1) * rowsPerPage;
//    const endIndex = startIndex + rowsPerPage;
//
//    // Parcours des lignes et affichage en fonction de la page actuelle
//    rows.forEach((row, index) => {
//        if (index >= startIndex && index < endIndex) {
//            row.style.display = 'table-row';
//        } else {
//            row.style.display = 'none';
//        }
//    });
//    var length = rows.length;
//    var rowLenght = (currentPage*rowsPerPage<length)? currentPage*rowsPerPage:length; 
//    document.querySelector('.item-number').innerHTML = `&nbsp;(${rowLenght}/${length} items)`;
//    document.querySelector('.prev').style.opacity = (currentPage==1)?"0":"1";
//    document.querySelector('.next').style.opacity = (currentPage*rowsPerPage>=length)?"0":"1";
//        
//    // Mise à jour des informations de pagination
//    updatePageInfo();
//}
//
//// Fonction pour mettre à jour les informations de pagination (nombre total de pages)
//function updatePageInfo() {
//    const totalRows = tbody.querySelectorAll('tr').length;
//    const totalPages = Math.ceil(totalRows / rowsPerPage);
//    document.querySelector('.page-info').textContent = ` ${currentPage} on ${totalPages}`;
//    
//    // Désactiver le bouton "Précédent" si nous sommes sur la première page
//    document.querySelector('.prev').disabled = (currentPage === 1);
//    
//    // Désactiver le bouton "Suivant" si nous sommes sur la dernière page
//    document.querySelector('.next').disabled = (currentPage === totalPages);
//}
//
//// Fonction pour passer à la page précédente
//function goToPreviousPage() {
//    if (currentPage > 1) {
//        currentPage--;
//        displayRows();
//    }
//}
//
//// Fonction pour passer à la page suivante
//function goToNextPage() {
//    const totalRows = tbody.querySelectorAll('tr').length;
//    const totalPages = Math.ceil(totalRows / rowsPerPage);
//    if (currentPage < totalPages) {
//        currentPage++;
//        displayRows();
//    }
//}
//
//// Ajout des écouteurs d'événements pour les boutons "Précédent" et "Suivant"
//document.querySelector('.prev').addEventListener('click', goToPreviousPage);
//document.querySelector('.next').addEventListener('click', goToNextPage);
//
//// Affichage des lignes pour la première page lors du chargement initial
//displayRows();

const tbody = document.querySelector('tbody');
let rowsPerPage = parseInt(document.getElementById('rowsPerPageSelect').value);
let currentPage = 1;

function displayRows() {
    const startIndex = (currentPage - 1) * rowsPerPage;

    let nbLigne = parseInt(document.getElementById('rowsPerPageSelect').value);
    if (nbLigne > 0) {
        rowsPerPage = nbLigne;
        currentPage = Math.ceil((startIndex + 1) / rowsPerPage);
    }

    const rows = tbody.querySelectorAll('tr');
    const endIndex = startIndex + rowsPerPage;

    rows.forEach((row, index) => {
        if (index >= startIndex && index < endIndex) {
            row.style.display = 'table-row';
        } else {
            row.style.display = 'none';
        }
    });

    const length = rows.length;
    const rowLength = (currentPage * rowsPerPage < length) ? currentPage * rowsPerPage : length;
    document.querySelector('.item-number').innerHTML = `&nbsp;(${rowLength}/${length} items)`;
    document.querySelector('.prev').style.opacity = (currentPage == 1) ? "0" : "1";
    document.querySelector('.next').style.opacity = (currentPage * rowsPerPage >= length) ? "0" : "1";

    updatePageInfo();
}

function updatePageInfo() {
    const totalRows = tbody.querySelectorAll('tr').length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    document.querySelector('.page-info').textContent = ` ${currentPage} on ${totalPages}`;

    document.querySelector('.prev').disabled = (currentPage === 1);
    document.querySelector('.next').disabled = (currentPage === totalPages);
}

function goToPreviousPage() {
    if (currentPage > 1) {
        currentPage--;
        displayRows();
    }
}

function goToNextPage() {
    const totalRows = tbody.querySelectorAll('tr').length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    if (currentPage < totalPages) {
        currentPage++;
        displayRows();
    }
}

document.querySelector('.prev').addEventListener('click', goToPreviousPage);
document.querySelector('.next').addEventListener('click', goToNextPage);

displayRows();

