<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response; //Importamos el archivo que arma la respuesta

class ProductionModel { //Nombre de la clase
    private $db;
    private $dbPr = 'produccion';
    private $dbPv = "precioventa";
    private $dbPrId = "idproduccion";
    private $response;

    //Construimos la clase ProduccionModelo
    public function __CONSTRUCT() {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    //Función que recupera todos los item de Produccion
    public function GetAllProduction() {
        try {
            //Consulta SQL que ejecutaremos
            //statement = consulta = consulta
            $stmp = $this->db->prepare(
                "SELECT * 
                from $this->dbPr 
                "   
            );
            $stmp->execute(); 
            $this->response->setResponse(true);
            $this->response->result_production = $stmp->fetchAll();
            return $this->response;} catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;}
    }
   
    public function Get($id) {
        try {   
            $stm = $this->db->prepare( "SELECT 
            dbPv.*,dbPr.* FROM $this->dbPr p
             
             JOIN $this->dbPv dbPv v.$this->dbPr = dbPr.$this->dbPv
             WHERE $this->dbPrId = ?
             ");


            $stm->execute(array($id));
            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();            
            return $this->response;} catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response; }
}



    public function Insert($data)
    {
        try {
            $sql = "INSERT INTO $this->dbPr
                    (nombre, descripcion, cantidad, unidad, buenestado)
                    VALUES (?,?,?,?,?);";

            $this->db->prepare($sql)
                ->execute(
                    array(
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
        try
        {
            $sql = "UPDATE $this->familygrouptbl
            SET
                relationship = ?,
                datetime = (select now())
            WHERE (childmember = ?) and (parentmember = ?)";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['relationship'],
                        $data['childmember'],
                        $data['parentmember'],
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
			            ->prepare("DELETE FROM $this->familygrouptbl WHERE (childmember = ?) and (parentmember = ?)");			          

			$stm->execute(
                array(
                        $data['childmember'],
                        $data['parentmember'],
                    ));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}
