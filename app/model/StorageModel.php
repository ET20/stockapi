<?php
namespace App\Model; 

use App\Lib\Database; 
use App\Lib\Response;
class StorageModel {
    //Rafael Perez! pero perez de pereza!
    private $db;
    private $stro = 'almacen';
    private $ta = "tipoalmacen";
    private $response;  
    public function __CONSTRUCT() {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    public function GetAll() {
        try {
            $stm = $this->db->prepare(
                "select * from 
                $this->stro" );
            $stm->execute();
            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll(); 
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    public function Get($id)
    {
        try
        {
           
            $stm = $this->db->prepare(
                "SELECT * FROM $this->stro
            WHERE idalmacen = ?");
            $stm->execute(array($id));

            $this->response->setResponse(true);

            $this->response->result = $stm->fetch();            

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }
}