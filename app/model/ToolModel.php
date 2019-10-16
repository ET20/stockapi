<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use App\Model\ToolModel;

class ToolModel
{ 
    private $db;
    private $tooltbl = 'herramienta';
    private $response;

    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    /*Get all members */
    public function GetAll()
    {
        try {
           
                $stm = $this->db->prepare(
                    "SELECT * FROM herramienta"
                    
                    );

                $stm->execute();  

                $this->response->setResponse(true);

            $this->response->result = $stm->fetchAll();
            
            return $this->response;  
            
            

            
            
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
            }
    }
    /**/
    public function Get($id)
    {
        try {
            $stm = $this->db->prepare("
                SELECT * FROM $this->tooltbl
                WHERE idherramienta = ?");
            $stm->execute(array($id));

            $this->response->setResponse(true);

            $this->response->result = $stm->fetch();

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    /*funciona*/
    public function Insert($data)
    {
        try {
            $sql = "INSERT INTO $this->tooltbl
            ( idunidadmedida, 
            marca, 
            modelo, 
            nombre, 
            descripcion, 
            cantidad, 
            buenestado, 
            monto, 
            fechaactualizado)

                    VALUES (?,?,?,?,?,?,?,?,(select now()));";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['idunidadmedida'],
                        $data['marca'],
                        $data['modelo'],
                        $data['nombre'],
                        $data['descripcion'],
                        $data['cantidad'],
                        $data['buenestado'],
                        $data['monto']           

                       
                    )
                );

            $this->response->setResponse(true);

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    /*Update a  by its id*/
    public function Update($data)
    {
        try {
            if (isset($data['idherramienta'])) {
                $sql = "UPDATE $this->tooltbl SET
                            idunidadmedida=? 
                            marca=? 
                            modelo=? 
                            nombre, 
                            descripcion=? 
                            cantidad=? 
                            buenestado=? 
                            monto=? 
                            fechaactualizado=(select now())

                        WHERE idherramienta = ?";

                $idherramienta = intval($data['idherramienta']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['idunidadmedida'],
                            $data['marca'],
                            $data['modelo'],
                            $data['nombre'],
                            $data['descripcion'],
                            $data['cantidad'],
                            $data['buenestado'],
                            $data['monto'],
                            $data['fechaactualizado'],
                            $idherramienta,
                        )
                    );
            }

            $this->response->setResponse(true);

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    /*Delete a tools by id*/
    public function Delete($id)
    {
        try
        {
            $stm = $this->db
                ->prepare("DELETE FROM $this->tooltbl WHERE idherramienta = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
}
