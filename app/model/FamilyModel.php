<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class FamilyModel {
    private $db;
    private $membertbl = 'member';
    private $familygrouptbl = 'familygroup';
    private $relationshiptbl = 'memberrelationship';
    private $response;

    public function __CONSTRUCT() {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }

    public function GetAll() {
        try {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT DISTINCT
                    m.*
                FROM $this->membertbl m
                    JOIN familygroup fg ON m.idmember = fg.parentmember");

            $stm->execute();

            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();

            foreach ($this->response->result as $key => $value) {
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
                        $value->idmember,
                    )
                );
                $value->gender = $stmgenero->fetch();

                $stmfamily = $this->db->prepare(
                    "SELECT member.*, familygroup.relationship, memberrelationship.relation
                    FROM member
                        JOIN familygroup ON member.idmember = familygroup.childmember
                        LEFT JOIN memberrelationship ON familygroup.relationship = memberrelationship.idmemberrelationship
                    WHERE familygroup.parentmember = ? AND familygroup.deleted is not true;
                ");
                $stmfamily->execute(
                    array(
                        $value->idmember,
                    )
                );
                $value->family = $stmfamily->fetchAll();

            }

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

    /* Get family by parent id */
    public function GetByMember($id) {
        try
        {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT 
                    *
                FROM
                    familygroup
                WHERE
                    parentmember = (SELECT 
                            parentmember
                        FROM
                            familygroup
                        WHERE
                            childmember = ?)
                ORDER BY relationship asc");
            $stm->execute(array($id));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();

            foreach ($this->response->result as $key => $value) {
                $stmrelation = $this->db->prepare(
                    "SELECT 
                        *
                    FROM
                        $this->relationshiptbl
                    WHERE
                        idmemberrelationship = ?");
                $stmrelation->execute(array($value->relationship));
                $value->relationship = $stmrelation->fetch();

                $stmchilds = $this->db->prepare(
                    "SELECT 
                        *
                    FROM
                        member
                    WHERE
                        idmember = ?");
                $stmchilds->execute(array($value->childmember));
                $value->childmember = $stmchilds->fetch();
            
            }

            return $this->response;
        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }
    }

     public function GetTree($id) {
        try
        {
            $result = array();

            $stm = $this->db->prepare(
                "SELECT 
                    *
                FROM
                    member
                WHERE
                    idmember = (SELECT 
                            parentmember
                        FROM
                            familygroup
                        WHERE
                            childmember = ?)");
            $stm->execute(array($id));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();

            $stm2 = $this->db->prepare(
                "SELECT 
                    childmember, relationship, datetime, deleted
                FROM
                    familygroup
                WHERE
                    parentmember = ?
                    and childmember != ?");
            $stm2->execute(array($this->response->result->idmember,$this->response->result->idmember));

            $this->response->setResponse(true);
            $this->response->result->childs = $stm2->fetchAll();

            foreach ($this->response->result->childs as $key => $value) {
                $stmrelation = $this->db->prepare(
                    "SELECT 
                        *
                    FROM
                        $this->relationshiptbl
                    WHERE
                        idmemberrelationship = ?");
                $stmrelation->execute(array($value->relationship));
                $value->relationship = $stmrelation->fetch();

                $stmchilds = $this->db->prepare(
                    "SELECT 
                        *
                    FROM
                        member
                    WHERE
                        idmember = ?");
                $stmchilds->execute(array($value->childmember));
                $value->childmember = $stmchilds->fetch();
            
            }

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

    public function FlagDelete($data)
    {
        try
        {
            $sql = "UPDATE $this->familygrouptbl
            SET
                deleted = true,
                datetime = (select now())
            WHERE (childmember = ?) and (parentmember = ?)";

            $this->db->prepare($sql)
                ->execute(
                    array(
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
