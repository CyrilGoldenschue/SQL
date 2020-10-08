<?php

/**
 * @Description Connection to the database
 * @return PDO
 */
function getBD()
{
    // connexion au serveur MySQL et à la BD
    $connection = new PDO('mysql:host=localhost; dbname=assurancemaladie','ConnectDB', 'Adm1n123');
    // permet d'avoir plus de détails sur les erreurs retournées
    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $connection;
}

function getClientAndPrime(){
    $connection = getBD();

    $req = "SELECT customers.name, firstname, rest, franchise, reduction, assurances.name, price, (price - reduction) as Prime FROM customers INNER JOIN customers_has_insurancemodels ON customers_has_insurancemodels.Customers_id = customers.id INNER JOIN primes ON primes.id = customers_has_insurancemodels.Franchises_id INNER JOIN assurances ON assurances.id = customers_has_insurancemodels.Assurances_id";

    $result = $connection->query($req);

    return $result;

}


