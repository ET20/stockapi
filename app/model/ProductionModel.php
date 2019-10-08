<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response; //Importamos el archivo que arma la respuesta

class ProductionModel { //Nombre de la clase
    private $db;
    private $dbPr = 'produccion';
    private $dbPv = "precioventa";
    private $dbPrId = "idproduccion";
    private $dbPvId = "idprecioventa";
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
            $this->response->result = $stmp->fetchAll();
            return $this->response;} catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;}
    }
   
/*
    "SELECT 
    dbPr.*,dbPv.* FROM $this->dbPr dbPr , $this->dbPv dbPv
       WHERE $this->dbPrId = ?
       join $this->dbPv dbPv  on dbPv.$this->dbPvId = dbPr.$this->dbPrId

       "
*/
    public function Get($id) {
        try {   
            $stm = $this->db->prepare( "SELECT dbpr.* FROM $this->dbPr dbpr
                        WHERE dbpr.$this->dbPrId = ?
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
                    (nombre,cantidad,descripcion,unidad,buentestado,lote)
                    VALUES (?,?,?,?,?,?);";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['nombre'],
                        $data['cantidad'],
                        $data['descripcion'],
                        $data['unidad'],
                        $data['buentestado'],
                        $data['lote'],
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
        if (isset($data['idproduccion'])) {
            $sql = "UPDATE $this->dbPr SET
                        nombre = ?
                        cantidad  = ?
                        descripcion = ?
                        unidad = ?
                        buentestado = ?
                        lote = ?
                    WHERE idproduccion = ?";

            $id = intval($data['idproduccion']);
            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['nombre'],
                        $data['cantidad'],
                        $data['descripcion'],
                        $data['unidad'],
                        $data['buentestado'],
                        $data['lote'],
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

public function Delete($id) {
    try
    {
        $stm = $this->db
            ->prepare(" DELETE FROM $this->dbPr 
            WHERE $this->dbPrId = ?");

        $stm->execute(array($id));

        $this->response->setResponse(true);
        return $this->response;

    } catch (Exception $e) {
        $this->response->setResponse(false, $e->getMessage());
    }
}

}