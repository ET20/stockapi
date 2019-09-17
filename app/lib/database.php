<?php
namespace App\Lib;

//holaaaa!
use PDO;

class Database
{
    public static function StartUp()
    {
        $pdo = new PDO('mysql:host=66.97.35.95;port=3306;dbname=antoniob_stock', 'titoet20', 'Tito2019');
        //$pdo = new PDO('mysql:localhost;dbname=base', 'usuario', 'pass');

        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);

        return $pdo;
    }
}
