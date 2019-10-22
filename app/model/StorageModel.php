<?php
namespace App\Model; 
use App\Lib\Database; 
use App\Lib\Response;
// unidad medida del 1-4
class StorageModel{
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


    public function Insert($data)
    {
        try {
            $stm = "INSERT INTO $this->stro
                    (ubicacion,capacidad,tipo,nombre)
                    VALUES (?,?,?,?);";

            $this->db->prepare($stm)
                ->execute(
                    array(
                        $data['ubicacion'],
                        $data['capacidad'],
                        $data['tipo'],
                        $data['nombre']
                    )
                );

            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    public function Update($data){
        try{
        if (isset($data['idalmacen'])) {
            $sql = "UPDATE $this->stro SET
                        ubicacion     = ?,
                        capacidad     = ?,
                        tipo          = ?,
                        nombre        = ?
                    WHERE idAlmacen = ?";

            $id = intval($data['idalmacen']);
            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['ubicacion'],
                        $data['capacidad'],
                        $data['tipo'],
                        $data['nombre'],
                        $id,
                    )
                );
            }
            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }



    public function delete($id) {
        try
        {
            $stm = $this->db
                ->prepare("DELETE FROM $this->stro WHERE idalmacen = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
    
}