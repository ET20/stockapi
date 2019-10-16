<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response;
//Importamos el archivo que arma la respuesta
//jejje
class ProductionModel
{ //Nombre de la clase
    private $db;
    private $dbPr = 'produccion';
    private $dbPrId = "idproduccion";
    private $response;

    //Construimos la clase ProduccionModelo
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    //Función que recupera todos los item de Produccion
    public function GetAll()
    {
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

    public function Get($id)
    {
        try {
            $stm = $this->db->prepare("SELECT dbpr.* FROM $this->dbPr dbpr
                        WHERE dbpr.$this->dbPrId = ?
                 ");

            $stm->execute(array($id));
            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();
            return $this->response;} catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;}
    }

//funciona! :)
// unidad medida del 1 - 4

    public function Insert($data)
    {

        try {
            $sql = "INSERT INTO $this->dbPr
                    (
                        idunidadmedida,
                        lote,
                        nombre,
                        fechaactualizado,
                        descripcion,
                        cantidad,
                        buenestado,
                        monto,
                        fechayhoradeproduccion
                    )
                    VALUES (?,?,?,(select now()),?,?,?,?,(select now()));";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['idunidadmedida'],
                        $data['lote'],
                        $data['nombre'],
                        $data['descripcion'],
                        $data['cantidad'],
                        $data['buenestado'],
                        $data['monto'],
                    )
                );

            $this->response->setResponse(true);

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
//funciona
    public function Update($data)
    {
        try {

            if (isset($data['idproduccion'])) {
                $sql = "UPDATE $this->dbPr SET
                        nombre = ?,
                        descripcion = ?,
                        cantidad  = ?,
                        buenestado = ?,
                        monto = ?,
                        fechaactualizado = (select now())
                    WHERE idproduccion = ?";

                $id = intval($data['idproduccion']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['nombre'],
                            $data['descripcion'],
                            $data['cantidad'],
                            $data['buenestado'],
                            $data['monto'],
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

    public function Delete($id)
    {
        try
        {
            $stm = $this->db
                ->prepare(" DELETE FROM $this->dbPr
            WHERE $this->dbPr.$this->dbPrId = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

}
