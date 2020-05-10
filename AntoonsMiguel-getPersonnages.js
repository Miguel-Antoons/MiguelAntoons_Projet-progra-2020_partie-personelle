/**
 * Fonction qui va appeler le webService qui va amener les personnages en fonction du genre qu'on donne en paramètre.
 *
 * @param genres [ce sont les genres de personnage qu'on a besoin]
 */
function getPersonnages(genres){
    let xhr = new XMLHttpRequest();
    xhr.open('get', 'http://localhost:80/serv_getPersonnages?genre=' + genres, true);
    xhr.onload = recupPersonnages;
    xhr.send();
}

/**
 * Fonction qui va charger les données reçues du service dans un array local.
 * Les données entrées sont reçues dans un ordre aléatoire, on place donc dans un array supplémentaire les id et les
 * noms d'images des personnages et on va trier cet array en fonction des id des personnages.
 */
function recupPersonnages(){
    personnages = JSON.parse(this.responseText);
    for(let e of personnages){
        pictures.push([e.ID, e.image]);
    }
    pictures.sort((a, b) => a[0].localeCompare(b[0]));
}