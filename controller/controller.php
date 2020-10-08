<?php

require_once "model/model.php";

function index()
{
    $data = getCustomer();
    require "view/home.php";
}