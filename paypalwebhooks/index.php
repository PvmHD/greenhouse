<?php

// CONFIG: Enable debug mode. This means we'll log requests into 'ipn.log' in the same directory.
// Especially useful if you encounter network errors or other intermittent problems with IPN (validation).
// Set this to 0 once you go live or don't require logging.
define("DEBUG", 1);

// Set to 0 once you're ready to go live
define("USE_SANDBOX", 1);


define("LOG_FILE", "./ipn.log");

define('RECEIVER_EMAIL', '');


// Read POST data
// reading posted data directly from $_POST causes serialization
// issues with array data in POST. Reading raw POST data from input stream instead.
$raw_post_data = file_get_contents('php://input');
$raw_post_array = explode('&', $raw_post_data);
$myPost = array();
foreach ($raw_post_array as $keyval) {
    $keyval = explode('=', $keyval);
    if (count($keyval) == 2)
        $myPost[$keyval[0]] = urldecode($keyval[1]);
}
// read the post from PayPal system and add 'cmd'
$req = 'cmd=_notify-validate';
if (function_exists('get_magic_quotes_gpc')) {
    $get_magic_quotes_exists = true;
}
foreach ($myPost as $key => $value) {
    if ($get_magic_quotes_exists == true && get_magic_quotes_gpc() == 1) {
        $value = urlencode(stripslashes($value));
    } else {
        $value = urlencode($value);
    }
    $req .= "&$key=$value";
}

// Post IPN data back to PayPal to validate the IPN data is genuine
// Without this step anyone can fake IPN data

if (USE_SANDBOX == true) {
    $paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr";
} else {
    $paypal_url = "https://www.paypal.com/cgi-bin/webscr";
}

$ch = curl_init($paypal_url);
if ($ch == FALSE) {
    return FALSE;
}

curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $req);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
curl_setopt($ch, CURLOPT_FORBID_REUSE, 1);

if (DEBUG == true) {
    curl_setopt($ch, CURLOPT_HEADER, 1);
    curl_setopt($ch, CURLINFO_HEADER_OUT, 1);
}

// CONFIG: Optional proxy configuration
//curl_setopt($ch, CURLOPT_PROXY, $proxy);
//curl_setopt($ch, CURLOPT_HTTPPROXYTUNNEL, 1);
// Set TCP timeout to 30 seconds
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Connection: Close'));

// CONFIG: Please download 'cacert.pem' from "http://curl.haxx.se/docs/caextract.html" and set the directory path
// of the certificate as shown below. Ensure the file is readable by the webserver.
// This is mandatory for some environments.

$cert = __DIR__ . "/cacert.pem";
curl_setopt($ch, CURLOPT_CAINFO, $cert);

$res = curl_exec($ch);
if (curl_errno($ch) != 0) { // cURL error
    if (DEBUG == true) {
        error_log(date('[Y-m-d H:i e] ') . "Can't connect to PayPal to validate IPN message: " . curl_error($ch) . PHP_EOL, 3, LOG_FILE);
    }
    curl_close($ch);
    exit;
} else {
    // Log the entire HTTP response if debug is switched on.
    if (DEBUG == true) {
        error_log(date('[Y-m-d H:i e] ') . "HTTP request of validation request:" . curl_getinfo($ch, CURLINFO_HEADER_OUT) . " for IPN payload: $req" . PHP_EOL, 3, LOG_FILE);
        error_log(date('[Y-m-d H:i e] ') . "HTTP response of validation request: $res" . PHP_EOL, 3, LOG_FILE);
    }
    curl_close($ch);
}

// Inspect IPN validation result and act accordingly
// Split response headers and payload, a better way for strcmp
$tokens = explode("\r\n\r\n", trim($res));
$res = trim(end($tokens));



if (strcmp($res, "VERIFIED") == 0) {
    //   mail('paul.wolbers@gmail.com', 'test', '<pre>' . var_export($_POST, true) . getCwd().'</pre>');
    // check whether the payment_status is Completed
    // check that txn_id has not been previously processed
    // check that receiver_email is your PayPal email
    // check that payment_amount/payment_currency are correct
    // process payment and mark item as paid.
    // assign posted variables to local variables
    //$item_name = $_POST['item_name'];
    //$item_number = $_POST['item_number'];
    //$payment_status = $_POST['payment_status'];
    //$payment_amount = $_POST['mc_gross'];
    //$payment_currency = $_POST['mc_currency'];
    //$txn_id = $_POST['txn_id'];
    //$receiver_email = $_POST['receiver_email'];
    //$payer_email = $_POST['payer_email'];
    // $current_path = dirname ( realpath ( __FILE__ ) );
    // $current_path = preg_replace('/paypalwebhooks/i', '', $current_path);
    // require_once $current_path.'include/default.inc.php';


    $item_name = isset($_POST['item_name']) ? $_POST['item_name'] : '';
    $amount = isset($_POST['mc_gross']) ? $_POST['mc_gross'] : '';
    $currency = isset($_POST['mc_currency']) ? $_POST['mc_currency'] : '';
    $payer_email = isset($_POST['payer_email']) ? $_POST['payer_email'] : '';
    $first_name = isset($_POST['first_name']) ? $_POST['first_name'] : '';
    $last_name = isset($_POST['last_name']) ? $_POST['last_name'] : '';
    $country = isset($_POST['residence_country']) ? $_POST['residence_country'] : '';
    $txn_id = isset($_POST['txn_id']) ? $_POST['txn_id'] : '';
    $txn_type = isset($_POST['txn_type']) ? $_POST['txn_type'] : '';
    $payment_status = isset($_POST['payment_status']) ? $_POST['payment_status'] : '';
    $payment_type = isset($_POST['payment_type']) ? $_POST['payment_type'] : '';
    $payer_id = isset($_POST['payer_id']) ? $_POST['payer_id'] : '';
    $receiver_email = isset($_POST['receiver_email']) ? $_POST['receiver_email'] : '';
    $user_id = isset($_POST['custom']) ? $_POST['custom'] : '';
    $create_date = date('Y-m-d H:i:s');
    $payment_date = date('Y-m-d H:i:s');

    DEFINE('DBHOST', 'localhost');
    DEFINE('DBUSER', 'paulwolbers');
    DEFINE('DBPASS', 'peewee25');
    DEFINE('DBNAAM', 'ews');


    $obj_db = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAAM);
    if ($obj_db === FALSE) {
        $error = "Database connection failed";
        error_log(' <br />Database connection failed<br /> ', 3, LOG_FILE);
        //printf("Connect failed: %s\n", mysqli_connect_error());
        exit();
    }
    error_log(' <br />' . var_export($payment_status, true) . '<br /> ', 3, LOG_FILE);

    if ($payment_status == 'Completed') {

        if ($receiver_email == RECEIVER_EMAIL) {


//mail('paul.wolbers@gmail.com', 'test', 'ipntest completed');
            // check database if txn_id was already processed
            error_log(' <br />' . var_export($_SERVER["HTTP_HOST"], true) . '<br /> ', 3, LOG_FILE);
            // get calendar database




            error_log(' <br />' . var_export($txn_id, true) . '<br /> ', 3, LOG_FILE);

            $str_select_query = 'SELECT * FROM ipn_data WHERE `txn_id` = "' . $txn_id . '"';

            $obj_result = mysqli_query($obj_db, $str_select_query);
            error_log(' <br />' . var_export($obj_result, true) . '<br /> ', 3, LOG_FILE);
            if ($obj_result !== false) {
                $arr_line = mysqli_fetch_array($obj_result, MYSQLI_ASSOC);
                error_log(' <br />' . var_export($arr_line, true) . '<br /> ', 3, LOG_FILE);
                if (empty($arr_line) || is_null($arr_line)) {

                    // not yet in our database
                    // check receiver_email


                    if (!empty($user_id)) {
                        // add the payment
                        $str_query = 'INSERT INTO ipn_data (user_id,item_name,payer_email,first_name,last_name,amount,currency,country,txn_id,txn_type,payer_id,payment_status,payment_type,create_date,payment_date)' .
                                ' VALUES (' . $user_id . ',"' . $item_name . '","' . $payer_email . '","' . $first_name . '","' . $last_name . '","' . $amount . '","' . $currency . '","' . $country . '","' . $txn_id . '","' . $txn_type . '","' . $payer_id . '","' . $payment_status . '","' . $payment_type . '","' . $create_date . '","' . $payment_date . '")';

                        $res2 = mysqli_query($obj_db, $str_query);

                        if ($res2 !== false) {
                            // mail the payment
                            mail($payer_email, 'Subscription prolonged', 'Your payment was successful. Your subscription has been prolonged.');


                            Subscription::saveSubscription($user_id, $amount);
                        }
                    }
                } else {
                    if (!empty($user_id)) {

                        if ($arr_line['payment_status'] != 'Completed') {
                            // find subscription enddate
                            $arr_subscription = Subscription::getSubscriptionByUserId($int_user_id);

                            $enddate = $arr_subscription['enddate'];

                            // update and prolong
                            // update payment_status
                            $str_query = 'UPDATE ipn_data  SET `payment_status` = 1 WHERE `txn_id` = ' . $txn_id . ' AND `user_id` = ' . $user_id;

                            $res2 = mysqli_query($obj_db, $str_query);

                            if ($res2 !== false) {
                                mail($payer_email, 'Subscription prolonged', 'Your payment was successful. Your subscription has been prolonged.');


                                Subscription::saveSubscription($user_id, $amount);
                            }
                        } else {
                            // already was completed, so updating was done already
                        }
                    }
                }
            }





            //mail('paul.wolbers@gmail.com', 'test', '<pre>' . var_export($test,true) . '</pre>');
        }

        if (DEBUG == true) {
            error_log(date('[Y-m-d H:i e] ') . "Verified IPN: $req " . PHP_EOL, 3, LOG_FILE);
        }
    }
} else if (strcmp($res, "INVALID") == 0) {
    // log for manual investigation
    // Add business logic here which deals with invalid IPN messages
    if (DEBUG == true) {
        error_log(date('[Y-m-d H:i e] ') . "Invalid IPN: $req" . PHP_EOL, 3, LOG_FILE);
    }
} else if (strcmp($res, "PENDING") == 0) {
    error_log(' PENDING ', 3, LOG_FILE);

    // log for manual investigation
    // Add business logic here which deals with invalid IPN messages
    if (DEBUG == true) {
        error_log(date('[Y-m-d H:i e] ') . "Invalid IPN: $req" . PHP_EOL, 3, LOG_FILE);
    }
}
