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
/*
    public function InsertOrUpdate($data) {
        try {
            if(isset($data['idalmacen'])) {
                $sql = "UPDATE $this->stro SET 
                            idalmacen   =?,
                            ubicacion   =?,
                            capacidad   =?,
                            tipo        =?,
                            nombre      =?,
                        WHERE idalmacen =?";
                $idal = intval($data['idalmacen']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['idalmacen'], 
                            $data['ubicacion'],
                            $data['capacidad'],
                            $data['tipo'],
                            $data['nombre'],
                            $idal
                        )
                    );
            } else {
                $sql = "INSERT INTO $this->stro 
                            (
                                idalmacen,
                                ubicacion,
                                capacidad,
                                tipo,
                                nombre,
                            ) 
                            VALUES (
                                ?, 
                                ?, 
                                ?, 
                                ?, 
                                ?, 
                            );";
                
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['idalmacen'], 
                            $data['ubicacion'],
                            $data['capacidad'],
                            $data['tipo'],
                            $data['nombre']
                        )
                    ); 
            }
            
            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
    */
}