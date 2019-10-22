<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class RawMaterialModel
{

    private $db;
    private $table = 'materiaprima';
    private $response;

    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    /*Get all Raw Materials */
    public function GetAll()
    {
        try {

            $stm = $this->db->prepare("SELECT m.idmateriaprima,
            m.idunidadmedida unidad, 
            m.nombre, 
            m.descripcion,
            m.cantidad,
            m.buenestado,
            m.monto,
            m.fechaactualizado,
            um.nombre numd, 
            um.descripcion umd, 
            um.simbolo FROM materiaprima m
            
            join unidadmedida um

            on m.idunidadmedida = um.idunidadmedida");

            $stm->execute();

            $this->response->setResponse(true);

            $this->response->result = $stm->fetchAll();

            foreach($this->response->result as $key=>$value){
                $value->unidad=array(
                    "idunidadmedida" => $value->unidad,
                    "nombre"=>$value->numd,
                    "descripcion"=>$value->umd,
                    "simbolo"=>$value->simbolo
                );

                unset($value->numd);
                unset($value->umd);
                unset($value->simbolo);}

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    /*Get Raw Material by id*/
    public function Get($id)
    {
        try {
            $stm = $this->db->prepare("
            SELECT m.idmateriaprima,
            m.idunidadmedida unidad, 
            m.nombre, 
            m.descripcion,
            m.cantidad,
            m.buenestado,
            m.monto,
            m.fechaactualizado,
            um.nombre numd, 
            um.descripcion umd, 
            um.simbolo FROM materiaprima m
            
            join unidadmedida um

            on m.idunidadmedida = um.idunidadmedida
                WHERE idmateriaprima = ?");
            $stm->execute(array($id));

            $this->response->setResponse(true);

            $this->response->result = $stm->fetch();

            $this->response->result->unidad= array(
                "idunidadmedida" => $this->response->result->unidad,
                "nombre"=>$this->response->result->numd,
                "descripcion"=>$this->response->result->umd,
                "simbolo"=>$this->response->result->simbolo
            );

            unset($this->response->result->numd);
            unset($this->response->result->umd);
            unset($this->response->result->simbolo);

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    /*Create new Raw Material*/
    public function Insert($data)
    {
        try {
            $sql = "INSERT INTO materiaprima
            (idunidadmedida,
            nombre, 
            descripcion, 
            cantidad, 
            buenestado,
            monto,
            fechaactualizado)
            VALUES (?,?,?,?,?,?,(select now()));";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['idunidadmedida'],
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

    /*Update a Raw Material by its id*/
    public function Update($data)
    {
        try {
            if (isset($data['idmateriaprima'])) {
                $sql = "UPDATE $this->table SET
                            idunidadmedida = ?,
                            nombre      = ?,
                            descripcion = ?,
                            cantidad    = ?,
                            buenestado  = ?,
                            monto       = ?,
                            fechaactualizado = (select now()) 

                        WHERE idmateriaprima = ?";

                $idmateriaprima = intval($data['idmateriaprima']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['idunidadmedida'],
                            $data['nombre'],
                            $data['descripcion'],
                            $data['cantidad'],                        
                            $data['buenestado'],
                            $data['monto'],
                            $idmateriaprima,
                        )
                    );
            }

            $this->response->setResponse(true);

            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    /*Delete a Raw Material by its idcambio*/ 
    public function Delete($id)
    {
        try
        {
            $stm = $this->db
                ->prepare("DELETE FROM $this->table WHERE idmateriaprima = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
}
