<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class FeeModel
{
    private $db;
    private $table = 'fee';
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
                $stmmember = $this->db->prepare(
                    "SELECT 
						idmember,
                        membernumber,
                        lastname,
						firstname
					FROM member
					WHERE idmember = ?;
                ");
                $stmmember->execute(
                        array(
                            $value->idmember
                        )
                    );
                $value->member = $stmmember->fetch();
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

			$stm = $this->db->prepare("SELECT * FROM $this->table WHERE idfee = ?");
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
    
    
	public function GetByMemberId($idmember)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("SELECT * FROM $this->table WHERE idmember = ?");
			$stm->execute(array($idmember));
            
			$this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();
        
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
            if(isset($data['idfee']))
            {
                $sql = "UPDATE $this->table SET 
                            modified           = (select now()), 
                            idmember             = ?,
                            amount     = ?,
                            year           = ?,
                            month            = ?,
                            expirationdate            = ?,
                            paydate            = ?
                        WHERE idfee = ?";
                $idfee = intval($data['idfee']);
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['idmember'], 
                            $data['amount'],
                            $data['year'],
                            $data['month'],
                            $data['expirationdate'],
                            $data['paydate'],
                            $idfee
                        )
                    );
            }
            else
            {
                $sql = "INSERT INTO $this->table
                            (datetime, modified, idmember, amount, year, month, expirationdate, paydate)
                            VALUES ((select now()), (select now()),?,?,?,?,?,?)";
                
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['idmember'], 
                            $data['amount'],
                            $data['year'],
                            $data['month'],
                            $data['expirationdate'],
                            $data['paydate']
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

    public function CreateByMembers($data)
    {
        try {

            $expirationdate = $data['date']."-10";
            $date = explode("-", $data['date']);

            foreach($data['selectedMembers'] as $member) {

                $sql = "INSERT INTO $this->table
                    (datetime,amount,expirationdate,idmember,year,month)
                    VALUES ((select now()),?,?,?,?,?)";
                
                $this->db->prepare($sql)
                    ->execute(
                    array(
                        $data['amount'],
                        $expirationdate,
                        $member, 
                        $date[0],
                        $date[1]
                    )
                );
            }
            
            $this->response->setResponse(true);
            return $this->response;

        } catch (Exception $e) {
            $this->response->setResponse(false, $e->getMessage());
		}
    }

    public function RegisterPay($data)
    {
		try {
            $sql = "UPDATE $this->table SET 
                modified           = (select now()),
                paydate            = ?
                WHERE idfee = ?";
            
            $idfee = intval($data['idfee']);
            $this->db->prepare($sql)
                ->execute(
                    array(
                        $data['paydate'], 
                        $idfee
                    )
                );
            
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
			            ->prepare("DELETE FROM $this->table WHERE idfee = ?");			          

			$stm->execute(array($id));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
	
}