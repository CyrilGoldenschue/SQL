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

function getCustomer()
{
    $connection = getBD();

    $request = "select 'name', 'firstname' from Customers where avs =";
}


