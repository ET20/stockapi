<?php
use App\Model\ProductionModel;
//llamar como productions
$app->group('/productions', function () {

    $this->get('/', function ($req, $res, $args) {
        $modelo = new ProductionModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $modelo->GetAll() // Qué función usaré de mi modelo
                )
            );

        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });

    $this->get('/{id}', function ($req, $res, $args) {
        $um = new ProductionModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->get($args['id'])
                )
            );
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });
/*
    $this->get('/tree/{id}', function ($req, $res, $args) {
        $um = new Familyproduccion();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->GetTree($args['id'])
                )
            );
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });
    */


    //funciona
    $this->post('/', function ($req, $res) {
        $um = new ProductionModel();

        return $res
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
            ->withHeader('Content-type', 'application/json')
            ->getBody()
            ->write(
                json_encode(
                    $um->Insert(
                        $req->getParsedBody()
                    )
                )
            );
    });


    $this->put('/', function ($req, $res) {
        $um = new ProductionModel();

        return $res
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
            ->withHeader('Content-type', 'application/json')
            ->getBody()
            ->write(
                json_encode(
                    $um->Update(
                        $req->getParsedBody()
                        //$um->Get($args['id'])
                    )
                )
            );
    });

    $this->delete('/{id}', function ($req, $res, $args) {
        $um = new ProductionModel();

        return $res
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
            ->withHeader('Content-type', 'application/json')
            ->getBody()
            ->write(
                json_encode(
                    $um->Delete(
                        $args['id']
                    )
                )
            );

    });
});
