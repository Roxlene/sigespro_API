<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
use ClickSend\Configuration;
use ClickSend\Api\SMSApi;
use Illuminate\Support\Str;

use Exception;
use GrahamCampbell\ResultType\Success;

class SMSController extends Controller
{

    protected $client;
    protected $baseUrl = 'https://rest.clicksend.com/v3/';

    public function __construct()
    {
        $this->client = new Client([
            'base_uri' => $this->baseUrl,
            'headers' => [
                'Authorization' => 'Basic ' . base64_encode(config('services.clicksend.username') . ':' . config('services.clicksend.password')),
                'Content-Type' => 'application/json',
            ],
            'verify' => false, // Ruta al archivo cacert.pem
        ]);
    }

    public function sendSms(Request $request)
    {
        mt_srand(time());
        $numero_aleatorio_message = mt_rand(1, 10000);

        $response = $this->client->post('sms/send', [
            'json' => [
                'messages' => [
                    [
                        'to' => $request->to,
                        'source' => "Mensaje de autenticación",
                        'body' => $numero_aleatorio_message . ' es su código de verificación para ' . config('app.name'),
                    ],
                ],
            ],
        ]);

        if ($response->getBody()->getContents()['http_code'] == 200) {
            return $this->success($numero_aleatorio_message, 200, 'Mensaje enviado exitosamente');
        } else {
        }
        return $response->getBody()->getContents();
    }


    public function sendSms_respaldo(Request $request)
    {
        mt_srand(time());
        //generamos un número aleatorio
        $numero_aleatorio = mt_rand(1, 10000);

        // $token = '490D0F9E-4B59-E1DC-D318-AC30F46F279A';
        // $username = 'roxlenevera362c@gmail.com';
        // $url = 'https://rest.clicksend.com/v3/sms/send';

        // Conexion con clicksend
        $username = config('services.clicksend.username');
        $token = config('services.clicksend.password');
        $url = config('services.clicksend.url');

        $mesaje = '{
                        "messages": [
                                        {
                                        "to": "' . $request->to . '",
                                        "source": "sdk",
                                        "body": "' . $numero_aleatorio . ' es su código de verificación para ' . config('app.name') . '"
                                        }
                                    ]
                    }';

        $config = Configuration::getDefaultConfiguration()
            ->$username
            ->$token;

        $apiInstance = new SMSApi(new Client(), $config);
        $q = "sms/inbound"; // string | Your keyword or query.
        $page = 1; // int | Page number
        $limit = 10; // int | Number of records per page

        try {
            $result = $apiInstance->smsInboundGet($q, $page, $limit);
            dd($result);
        } catch (Exception $e) {
            echo 'Exception when calling SMSApi->smsInboundGet: ', $e->getMessage(),    PHP_EOL;
        }

        // $header = array("Authorization: Basic " . base64_encode($username . ':' . $token), "Content-Type: application/json");

        // $curl = curl_init();
        // curl_setopt($curl, CURLOPT_URL, $url);
        // curl_setopt($curl, CURLOPT_POSTFIELDS, $mesaje);
        // curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        // curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

        // $response = json_decode(curl_exec($curl), true);
        // //dump($response);
        // $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        // curl_close($curl);
        // return response()->json([$response, 'codigo' => $numero_aleatorio]);


        //Conexion con twillio
        /* $sid = config('services.twilio.username');
        $token = config('services.twilio.password');
        $from = config('services.twilio.from');

        //dd($sid);

        $client = new Client($sid, $token);
        $message = $client->messages->create(
            $request->input('to'),
            array(
                'from' => $from,
                'body' => $request->input('message')
            )
        );

        return response()->json(['message' => 'SMS sent successfully.', 'data' => $message]); */
    }
}
