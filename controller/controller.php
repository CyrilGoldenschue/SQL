<?php

require_once "model/modele.php";

function index()
{
    $data = getCustomer();
    require_once "view/home.php";
}