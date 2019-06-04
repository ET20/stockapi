<?php
use App\Model\FeeModel;

$app->group('/fee', function () {
    
    //$this->get('test', function ($req, $res, $args) {
    //    return $res->getBody()
    //               ->write('Hello Users');
    //});
    
    $this->get('/all', function ($req, $res, $args) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->GetAll()
            )
        );

        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });
    
    $this->get('/{id}', function ($req, $res, $args) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->Get($args['id'])
            )
        );

        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

     $this->get('/bymember/{id}', function ($req, $res, $args) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->GetByMemberId($args['id'])
            )
        );

        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

    $this->post('/save', function ($req, $res) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->InsertOrUpdate(
                    $req->getParsedBody()
                )
            )
        );
        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

    $this->post('/CreateByMembers', function ($req, $res) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->CreateByMembers(
                    $req->getParsedBody()
                )
            )
        );
        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

    $this->post('/RegisterPay', function ($req, $res) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->RegisterPay(
                    $req->getParsedBody()
                )
            )
        );
        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });
    
    $this->delete('/delete/{id}', function ($req, $res, $args) {
        $um = new FeeModel();
        
        $res
           ->getBody()
           ->write(
            json_encode(
                $um->Delete($args['id'])
            )
        );
        
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

});