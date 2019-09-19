<?php
namespace App\Model; //Donde estamos

use App\Lib\Database; //Importamos el archivo que conecta a la base de datos
use App\Lib\Response; //Importamos el archivo que arma la respuesta

class ProductionModel { //Nombre de la clase
    private $db;
    private $production = 'produccion';
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
                "select
                p.idproduccion ,p.idmaterial,p.lote,p.fechayhoradelaproduccion, m.nombre,m.cantidad,m.cantidad,m.buenestado,m.unidad,um.nombre Nombre_UN
                from
                produccion p
                join material m on p.idmaterial = m.idmaterial
                join unidadmedida um on m.unidad = um.idunidadmedida
                "   
            );
            $stmp->execute(); 
            $this->response->setResponse(true);
            $this->response->result_production = $stmp->fetchAll();
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
            $result = array();

            $stm = $this->db->prepare(
                "SELECT DISTINCT
                    m.*
                FROM $this->membertbl m
                    JOIN familygroup fg ON m.idmember = fg.parentmember
                WHERE m.idmember = ?");
            $stm->execute(array($id));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();

            //foreach ($this->response->result as $key => $value) {
            $stmgenero = $this->db->prepare(
                "SELECT
                        gender.idgender,
                        gender.gendername,
                        gender.genderdesc,
                        gender.gendericon
                    FROM member
                        JOIN gender on member.gender = gender.idgender
                    WHERE member.idmember = ?;
                ");
            $stmgenero->execute(
                array(
                    $this->response->result->idmember,
                )
            );
            $this->response->result->gender = $stmgenero->fetch();

            $stmfamily = $this->db->prepare(
                "SELECT member.*, familygroup.relationship, memberrelationship.relation
                    FROM member
                        JOIN familygroup ON member.idmember = familygroup.childmember
                        LEFT JOIN memberrelationship ON familygroup.relationship = memberrelationship.idmemberrelationship
                    WHERE familygroup.parentmember = ? AND familygroup.deleted is not true;
                ");
            $stmfamily->execute(
                array(
                    $this->response->result->idmember,
                )
            );
            $this->response->result->family = $stmfamily->fetchAll();

            foreach ($this->response->result->family as $key => $value) {
                $stmgenerochild = $this->db->prepare(
                    "SELECT
                            gender.idgender,
                            gender.gendername,
                            gender.genderdesc,
                            gender.gendericon
                        FROM member
                            JOIN gender on member.gender = gender.idgender
                        WHERE member.idmember = ?;
                    ");
                $stmgenerochild->execute(
                    array(
                        $value->idmember,
                    )
                );
                $value->gender = $stmgenerochild->fetch();

            }

            //}

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    public function Insert($data)
    {
        try
        {
            $sql = "INSERT INTO $this->familygrouptbl
                (parentmember, childmember, relationship, datetime)
                VALUES (?,?,?,(select now()))";

            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['parentmember'],
                        $data['childmember'],
                        $data['relationship'],
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
