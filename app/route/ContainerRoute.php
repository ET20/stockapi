 <?php
use App\Model\ContainerModel;

//Corregir esto!
$app->group('/container', function () {

    $this->get('/{id}', function ($req, $res, $args) {
        $um = new ContainerModel();

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
    $this->get('', function ($req, $res, $args) {
        $um = new ContainerModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->Get()
                )
            );
        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );

    });
    $this->post('/', function ($req, $res) {
        $um = new ContainerModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->Insert(
                        $req->getParsedBody()
                    )
                )
            );

        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });
 
    $this->put('/', function ($req, $res) {
        $um = new ContainerModel();

        $res
            ->getBody()
            ->write(
                json_encode(
                    $um->Update(
                        $req->getParsedBody()
                    )
                )
            );

        return $res->withHeader(
            'Content-type',
            'application/json; charset=utf-8'
        );
    });

    $this->delete('/{id}', function ($req, $res, $args) {
        $um = new ContainerModel();

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
//aa