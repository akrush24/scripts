#!/usr/bin/php
<?php
/**
* @param $to номер получателя, например: 79221111111
* @param $msg сообщение в кодировке windows-1251
* @param string $login  логин на веб-сервисе websms.ru
* @param string $password пароль на веб-сервисе websms.ru
* @return mixed
*/

function send_sms ($to, $msg, $login = "intranet", $password = "intro2013$")
{
    $u = 'http://www.websms.ru/http_in5.asp';
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS,
        'Http_username=' . urlencode($login) . '&Http_password=' . urlencode($password) . '&Phone_list=' . $to . '&Message=' . urlencode($msg));
    curl_setopt($ch, CURLOPT_URL, $u);
    $u = trim(curl_exec($ch));
    curl_close($ch);
    preg_match("/message_id\s*=\s*[0-9]+/i", $u, $arr_id);
    $id = preg_replace("/message_id\s*=\s*/i", "", @strval($arr_id[0]));
    return $id;
}

send_sms($argv[1],$argv[2]);
?>
