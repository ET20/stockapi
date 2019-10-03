<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class TypeStoreModel
{

    private $db;
    private $table = 'tipoalmacen';
    private $response;

    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    public function GetAll()
    {
        try {

            $stm = $this->db->prepare("SELECT * FROM $this->table");

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
        try {
            $stm = $this->db->prepare("
                SELECT * FROM $this->table
                WHERE idtipoalmacen = ?");
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
            $sql = "INSERT INTO $this->table
                    (descripcion)
                    VALUES (?);";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['descripcion'],
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
            if (isset($data['idtipoalmacen'])) {
                $sql = "UPDATE $this->table SET
                            descripcion = ?,

                        WHERE idtipoalmacen = ?";

                $idtipoalmacen = intval($data['idtipoalmacen']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['descripcion'],
                            $idtipoalmacen,
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
                ->prepare("DELETE FROM $this->table WHERE idtipoalmacen = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
}
//creado recientemente