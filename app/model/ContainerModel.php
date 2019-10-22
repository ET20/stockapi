<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response; //Importamos el archivo que arma la respuesta

class ContainerModel { //Nombre de la clase
    private $db;
    private $container = 'envase';
    private $response;

    //Construimos la clase ContainerModelo
    public function __CONSTRUCT() {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    public function GetAll($id) {
        try 
        {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT 
                    *
                FROM
                    envase where idenvase = ?");
            
            $stm->execute(array($id));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();
        
            
           
            return $this->response;
             
            
        }
        catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }


    }


    public function Get() {
        try {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT 
                    *
                FROM
                    envase" );
            
            $stm->execute();

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();
        
            
           
            return $this->response;
             
            
        }
        catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }


    }

    public function Insert($data)
    {
        try {
            $sql = "INSERT INTO $this->envase
                    ((idenvase, idmaterial, capacidad, nombre, descripcion, cantidad, unidad, buenestado)
                    VALUES (?,?,?,?,?,?,?,?);";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['idenvase'],
                        $data['idmaterial'],
                        $data['capacidad'],
                        $data['nombre'],
                        $data['descripcion'],
                        $data['cantidad'],
                        $data['unidad'],
                        $data['buenestado'],
                    )
                );

            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
    public function Update($data)
    {
        try {
            if (isset($data['idenvase'])) {
                $sql = "UPDATE $this->envase SET
                            idenvase    = ?, 
                            idmaterial  = ?,
                            capacidad   = ?,
                            nombre      = ?,
                            descripcion = ?,
                            cantidad    = ?,
                            unidad      = ?,
                            buenestado  = ?

                        WHERE idenvase = ?";

                $idenvase = intval($data['idenvase']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['idenvase'],
                            $data['idmaterial'],
                            $data['capacidad'],
                            $data['nombre'],
                            $data['descripcion'],
                            $data['cantidad'],
                            $data['unidad'],
                            $data['buenestado'],
                            $idenvase,
                        )
                    );
            }

            $this->response->setResponse(true);

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    public function Delete($id)
    {
        try
        {
            $stm = $this->db
                ->prepare("DELETE FROM $this->envase WHERE idenvase = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }


}



//aa