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

    /*Get all tools */
    public function GetAll()
    {
        try {
           
                $stm = $this->db->prepare(
                    "SELECT h.idherramienta,
                    h.idunidadmedida unidad, 
                    h.marca, 
                    h.modelo,
                    h.descripcion,
                    h.cantidad,
                    h.buenestado,
                    h.monto,
                    h.fechaactualizado,
                    um.nombre, 
                    um.descripcion umd, 
                    um.simbolo  FROM herramienta h

                    join unidadmedida um

                    on h.idunidadmedida = um.idunidadmedida"
                    );

                $stm->execute();  

                $this->response->setResponse(true);

            $this->response->result = $stm->fetchAll();

            foreach($this->response->result as $key=>$value){
                $value->unidad=array(
                    "idunidadmedida" => $value->unidad,
                    "nombre"=>$value->nombre,
                    "descripcion"=>$value->umd,
                    "simbolo"=>$value->simbolo
                );

                unset($value->nombre);
                unset($value->umd);
                unset($value->simbolo);
            }

            return $this->response;       
        
  
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
            }
    }
    /*Get a tool depending on its id*/
    public function Get($id)
    {
        try {
            $stm = $this->db->prepare("
            SELECT h.idherramienta,
            h.idunidadmedida unidad, 
            h.marca, 
            h.modelo,
            h.descripcion,
            h.cantidad,
            h.buenestado,
            h.monto,
            h.fechaactualizado,
            um.nombre, 
            um.descripcion umd, 
            um.simbolo 
            FROM herramienta h
            
            join unidadmedida um

            on h.idunidadmedida = um.idunidadmedida
            where idherramienta = ?");
            $stm->execute(array($id));

            $this->response->setResponse(true);

            $this->response->result = $stm->fetch();
            
            
            $this->response->result->unidad= array(
                    "idunidadmedida" => $this->response->result->unidad,
                    "nombre"=>$this->response->result->nombre,
                    "descripcion"=>$this->response->result->umd,
                    "simbolo"=>$this->response->result->simbolo
                );

                unset($this->response->result->nombre);
                unset($this->response->result->umd);
                unset($this->response->result->simbolo);
            


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
                            idunidadmedida=?, 
                            marca=? ,
                            modelo=?, 
                            nombre=? ,
                            descripcion=? ,
                            cantidad=? ,
                            buenestado=? ,
                            monto=? ,
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
/*
SELECT h.idherramienta,
            h.idunidadmedida unidad, 
            h.marca, 
            h.modelo,
            h.descripcion,
            h.cantidad,
            h.buenestado,
            h.monto,
            h.fechaactualizado,
            um.nombre, 
            um.descripcion umd, 
            um.simbolo,
            hm.idherramienta,
            hm.idalmacen,            
            hm.idusuario,            
            hm.idmovimiento,
            hm.fecha,
            al.idtipoalmacen,
            al.ubicacion,
            al.capacidad,
            al.nombre,
            mo.nombre,
            mo.descripcion,
            us.idpersona,
            us.usuario,
            p.nombre,
            p.apellido
            FROM herramienta h
            
            join unidadmedida um

            on h.idunidadmedida = um.idunidadmedida
            
            join herramientaalmacen hm
            
            on h.idherramienta = hm.idherramienta
            
            join almacen al
            
            on al.idalmacen = hm.idalmacen            
            
            join movimiento mo
            
            on hm.idmovimiento = mo.idmovimiento  join usuario us
            
            on hm.idusuario = us.idusuario  
			
            join persona p
			
            on us.idusuario = p.idpersona
            
            where h.idherramienta = 1
*/
