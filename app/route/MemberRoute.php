<?php
use App\Model\MemberModel;

$app->group('/member', function () {
    
    //$this->get('test', function ($req, $res, $args) {
    //    return $res->getBody()
    //               ->write('Hello Users');
    //});
    
    $this->get('/all', function ($req, $res, $args) {
        $um = new MemberModel();
        
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
        $um = new MemberModel();
        
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
    
    $this->post('/save', function ($req, $res) {
        $um = new MemberModel();
        
        return $res
           ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
           ->withHeader('Content-type', 'application/json')
           ->getBody()
           ->write(
            json_encode(
                $um->InsertOrUpdate(
                    $req->getParsedBody()
                )
            )
        );
    });
    
    $this->delete('/delete/{id}', function ($req, $res, $args) {
        $um = new MemberModel();
        
		return $res
           ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
           ->withHeader('Content-type', 'application/json')
           ->getBody()
           ->write(
            json_encode(
                $um->Delete($args['id'])
            )
        );
		
		
        //$res
        //   ->getBody()
        //   ->write(
        //    json_encode(
        //        $um->Delete($args['id'])
        //    )
        //);
        
        //return $res->withHeader(
        //    'Content-type',
        //    'application/json; charset=utf-8'
        //);
    });
});