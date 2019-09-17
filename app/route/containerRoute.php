 <?php
/*use App\Model\containerModel;

$app->group('/envase', function () {

    $this->get('/todo', function ($req, $res, $args) {
        $modelo = new containerModel();

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
        $um = new containerModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->GetByMember($args['id'])
                )
            );
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });

}    /*
