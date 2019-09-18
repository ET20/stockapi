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
                "select s.*,t.idtipoalmacen,t.descripcion from 
                $this->stro s
            join $this->ta t on s.tipo = t.idtipoalmacen" );
            $stm->execute();
            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll(); 
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }
}