<?php
// Application middleware

// e.g: $app->add(new \Slim\Csrf\Guard);

//this works, but i can't get the correct path string to protect all api
//ignore works well

$app->add(new Tuupola\Middleware\JwtAuthentication([
  //"path" => "/public/", /* or ["/api", "/admin"] */
  "ignore" => "/",
  "secure" => false,
  //"relaxed" => ["localhost", "dev.example.com"],
  "secret" => "supersecretkeyyoushouldnotcommittogithub"
]));