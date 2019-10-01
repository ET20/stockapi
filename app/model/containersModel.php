<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response; //Importamos el archivo que arma la respuesta

class ContainersModel { //Nombre de la clase
    private $db;
    private $containers = 'envase';
    private $response;

    //Construimos la clase ContainersModelo
    public function __CONSTRUCT() {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    public function Get($id) {
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
    public function GetAll() {
        try 
        {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT 
                    *
                FROM
                    envase" );
            
            $stm->execute();

            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();
        
            
           
            return $this->response;
             
            
        }
        catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }


    }
    public function Insert($data)
    {
        try
        {
            $sql = "INSERT INTO $this->envase
                (idenvase, idmaterial, capacidad, datetime)
                VALUES (?,?,?,(select now()))";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['idenvase'],
                        $data['idmaterial'],
                        $data['capacidad'],
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
        try
        {
            $sql = "UPDATE $this->envase
            SET
                relationship = ?,
                datetime = (select now())
            WHERE (idenvase = ?) and (idmaterial = ?)";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['relationship'],
                        $data['idenvase'],
                        $data['idmaterial'],
                    )
                );

            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
    public function Delete($data)
    {
		try 
		{
			$stm = $this->db
			            ->prepare("DELETE FROM $this->familygrouptbl WHERE (idenvase = ?) and (idmaterial = ?)");			          

			$stm->execute(
                array(
                        $data['idenvase'],
                        $data['idmaterial'],
                    ));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }


}

//hice cambio..

