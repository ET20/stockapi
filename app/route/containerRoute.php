 <?php
/*use App\Model\ContainerModel;

$app->group('/envase', function () {

    $this->get('/todo', function ($req, $res, $args) {
        $modelo = new ContainerModel();

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
        $um = new ContainerModel();

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
