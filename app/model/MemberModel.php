<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class MemberModel
{
    private $db;
    private $table = 'member';
    private $response;
    
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    
    public function GetAll()
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("SELECT * FROM $this->table");
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
                            $value->idmember
                        )
                    );
                $value->gender = $stmgenero->fetch();
            }
			
            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }

    public function GetAllWeight()
    {
		try
		{
			$result = array();

            $stm = $this->db->prepare("
                SELECT distinct palabra,
                    (
                        SELECT COUNT(*)
                        FROM $this->table
                        WHERE palabra= c1.palabra
                    ) AS count
                FROM $this->table AS c1
                order by count desc;
            ");
			$stm->execute();
            
			$this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();
            
            foreach ($this->response->result as $key => $value) {
                $stmasignatura = $this->db->prepare(
                    "select a.idAsignatura, a.nombre from Member c 
                        join asignatura a on c.idasignatura = a.idasignatura
                    where c.palabra like ?;
                ");
                $stmasignatura->execute(
                        array(
                            $value->palabra
                        )
                    );
                $value->asignatura = $stmasignatura->fetchAll();
                
            }



            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($id)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("SELECT * FROM $this->table WHERE idmember = ?");
			$stm->execute(array($id));

			$this->response->setResponse(true);
            $this->response->result = $stm->fetch();

            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}  
    }
    
    public function InsertOrUpdate($data)
    {
		try 
		{
            if(isset($data['idmember']))
            {
                $sql = "UPDATE $this->table SET 
                            membernumber          = ?, 
                            lastname              = ?, 
                            firstname             = ?, 
                            birthdate             = ?, 
                            gender                = ? 
                        WHERE idmember = ?";
                
				$idmember = intval($data['idmember']);
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['membernumber'], 
                            $data['lastname'], 
                            $data['firstname'], 
                            $data['birthdate'], 
                            $data['gender'], 
                            $idmember
                        )
                    );
            }
            else
            {
                $sql = "INSERT INTO $this->table
                            (membernumber, lastname, firstname, birthdate, gender)
                            VALUES (?,?,?,?,?)";
                
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['membernumber'], 
                            $data['lastname'],
                            $data['firstname'],
                            $data['birthdate'],
                            $data['gender'],
                        )
                    ); 
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }

    public function Delete($id)
    {
		try 
		{
            $stm = $this->db
                        ->prepare("DELETE FROM $this->table WHERE idmember = ?");

			$stm->execute(array($id));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
    
    
}