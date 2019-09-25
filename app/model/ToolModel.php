<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use App\Model\ToolModel;

class ToolModel
{ 
    private $db;
    private $tooltbl = 'herramienta';
    private $materialtbl = 'material';
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
                    "SELECT                        
                   * FROM herramienta"
                    
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
        try
        {
           
            $stm = $this->db->prepare("SELECT * FROM $this->tooltbl 
            JOIN $this->materialtbl
            ON herramienta.idmaterial = material.idmaterial
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

    public function GetByDNI($dni)
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("SELECT * FROM $this->membertbl WHERE dni = ?");
            $stm->execute(array($dni));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();

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

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    public function GetFeesOwed($idmember) {
        try {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT idmember, membernumber, dni, firstname, lastname, isparent FROM $this->membertbl WHERE idmember = ?"
            );
            $stm->execute(array($idmember));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();
            if($this->response->result != null){

                $stmFeesOwed = $this->db->prepare(
                "SELECT 
                    f.*, DATEDIFF(NOW(), expire) AS dayslate
                FROM
                    $this->familytbl fg
                        JOIN
                    $this->feetbl f ON f.idmember = fg.childmember
                WHERE
                    (childmember = ?
                    or (childmember = (select parentmember from familygroup where childmember = ?) and type = 1))
                    AND (expire <= (SELECT NOW()))
                    AND (pay IS NULL)
                ORDER BY dayslate DESC;");
                $stmFeesOwed->execute(array($idmember, $idmember));
                
                $this->response->result->feesowed = $stmFeesOwed->fetchAll();

                foreach ($this->response->result->feesowed as $key => $value) {
                    $stmfeetype = $this->db->prepare(
                        "SELECT 
                            idfeetype, name, description
                        FROM feetype
                        WHERE idfeetype = ?;
                    ");
                    $stmfeetype->execute(
                        array(
                            $value->type,
                        )
                    );
                    $value->type = $stmfeetype->fetch();
                }
            }
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    public function InsertOrUpdate($data)
    {
        try
        {
            if (isset($data['idmember'])) {
                $sql = "UPDATE $this->membertbl SET
                            membernumber    = ?,
                            lastname        = ?,
                            firstname       = ?,
                            dni             = ?,
                            birthdate       = ?,
                            birthplace      = ?,
                            gender          = ?,
                            maritalstatus   = ?,
                            employment      = ?,
                            status          = ?,
                            isparent        = ?,
                        WHERE idmember = ?";

                $idmember = intval($data['idmember']);
                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['membernumber'],
                            $data['lastname'],
                            $data['firstname'],
                            $data['dni'],
                            $data['birthdate'],
                            $data['birthplace'],
                            $data['gender'],
                            $data['maritalstatus'],
                            $data['employment'],
                            $data['status'],
                            $data['isparent'],
                            $idmember,
                        )
                    );
            } else {
                $sql = "INSERT INTO $this->membertbl
                            (
                                membernumber, 
                                lastname, 
                                firstname, 
                                dni, 
                                birthdate, 
                                birthplace, 
                                gender, 
                                isparent
                            )
                            VALUES (?,?,?,?,?,?,?,?)";

                $this->db->prepare($sql)
                    ->execute(
                        array(
                            $data['membernumber'],
                            $data['lastname'],
                            $data['firstname'],
                            $data['dni'],
                            $data['birthdate'],
                            $data['birthplace'],
                            $data['gender'],
                            $data['isparent'],
                        )
                    );
            }
            if($data['isparent'] == "1"){
                $family = new FamilyModel();
                $family->Insert(
                    array(
                        "parentmember" => $this->db->lastInsertId(),
                        "childmember" => $this->db->lastInsertId(),
                        "relationship" => "0",
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
                ->prepare("DELETE FROM $this->membertbl WHERE idmember = ?");

            $stm->execute(array($id));

            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

}
