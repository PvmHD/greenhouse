<?php

/*
 * Created on 17-okt-2011
 * author Paul Wolbers
 *
 */
require_once '../include/default.inc.php';

$arr_submit = array(
    array('cal_id', 'string', false, ''),
);
$frm_submitted = validate_var($arr_submit, true);

$bln_public_calendars = false;
$arr_calendars = Calendar::getCalendarsByIds($frm_submitted['cal_id']);
foreach ($arr_calendars as $cal) {
    if ($cal['share_type'] == 'public') {
        $bln_public_calendars = true;
    }
}

if (ALLOW_ACCESS_BY == 'ip' && !User::ipAllowed()) {
    header('location: ' . FULLCAL_URL . '/noaccess.html'); // fill in a website where you want to redirect
    exit;
} else if (ALLOW_ACCESS_BY == 'login' || (ADMIN_CAN_LOGIN_FROM_ADMIN_URL === true && stristr($_SERVER['SCRIPT_NAME'], '/admin'))) {
    if (!User::isLoggedIn()) {
        echo json_encode(array('success' => false, 'notloggedin' => true, 'error' => 'You are not logged in'));
        exit;
    }
}



switch ($_GET['action']) {
    case 'start':
        getEvents();
        break;
    case 'add':
        addEvent();
        break;
    case 'update':
        updateEvent();
        break;
    case 'customview_update':
        customviewUpdate();
        break;
    case 'resize':
        resizeEvent();
        break;
    case 'del':
        deleteEvent();
        break;
    case 'copy':
        copyEvent();
        break;
    case 'get_cal':
        getCalendar();
        break;
    case 'mail_event':
        mailEvent();
        break;
    case 'start_edit':
        startEdit();
        break;
    case 'stop_edit':
        stopEdit();
        break;
    case 'get_event':
        getEvent();
        break;
    case 'export_to_ics':
        exportToIcs();
        break;
    default:
        break;
}

function addEvent() {

    global $error;

    $validate_phonenumber_as = 'phone';
    if(defined('VALIDATE_PHONENUMBER_AS_STRING')) {
        if(VALIDATE_PHONENUMBER_AS_STRING) {
            $validate_phonenumber_as = 'string';
        }
    }

    $color = DEFAULT_COLOR;
    $arr_submit = array(
        array('cal_id', 'int', false, ''),
        array('user_id', 'int', false, -1), // usergroup dditem
        array('color', 'string', false, DEFAULT_COLOR),
        array('textcolor', 'string', false, '#FFFFFF'),
        array('date_end', 'int', false, ''),
        array('date_start', 'int', false, ''),
        array('str_date_end', 'string', false, ''),
        array('str_date_start', 'string', false, ''),
        array('title', 'string', false, ''),
        array('allDay', 'bool', false, ''),
        array('location', 'string', false, ''),
        array('phone', $validate_phonenumber_as, false, ''),
        array('myurl', 'string', false, ''),
        array('description', 'string', false, ''),
        array('cal_type', 'textonly', false, ''),
        array('interval', 'string', false, ''),
        array('weekdays', 'string', false, ''),
        array('monthday', 'textonly', false, ''),
        array('yearmonthday', 'int', false, ''),
        array('yearmonth', 'int', false, ''),
        array('every_x_days', 'int', false, ''),
        array('every_x_weeks', 'int', false, ''),
        array('recurring', 'bool', false, false),
        array('team_member_id', 'array', false, ''),
        array('dropdown1_option_id', 'int', false, -1),
        array('dropdown2_option_id', 'int', false, -1),
        array('dropdown3_option_id', 'int', false, -1),
        array('dropdown4_option_id', 'int', false, -1),
        array('dropdown5_option_id', 'int', false, -1),
        array('dropdown1', 'string', false, ''),
        array('dropdown2', 'string', false, ''),
        array('dropdown3', 'string', false, ''),
        array('dropdown4', 'string', false, ''),
        array('dropdown5', 'string', false, ''),
        array('assign', 'bool', false, false),
        
    );

    $frm_submitted = validate_var($arr_submit);

    $frm_submitted['title'] = str_replace('&amp;', '&', $frm_submitted['title']);

    $frm_submitted['title'] = stripslashes($frm_submitted['title']);

    if(!empty($frm_submitted['team_member_id'])) {
        $frm_submitted['team_member_id'] = implode(',', $frm_submitted['team_member_id']);
    }
    
    if (!isset($frm_submitted['date_start'])) {
        $frm_submitted['date_start'] = time();
    }

//	$bln_one_calendar = Calendar::hasOneCalendar();
//	if(empty($frm_submitted['cal_id']) && $bln_one_calendar) {
//		if(defined('CAL_ID')) {
//			$frm_submitted['cal_id'] = CAL_ID;
//			if(empty($frm_submitted['cal_id'])) {
//				$frm_submitted['cal_id'] = Calendar::getCalendarId();
//			}
//		}
//	}
    // time offset
    if (!empty($frm_submitted['time_start'])) {
        $frm_submitted['date_start'] = strtotime(date('Y-m-d', $frm_submitted['date_start']) . ' ' . $frm_submitted['time_start']);
    } else {
        if (!IGNORE_TIMEZONE) {
            $frm_submitted['date_start'] -= TIME_OFFSET;
        }
    }

    if ($frm_submitted['str_date_start'] == $frm_submitted['str_date_end'] && (!isset($frm_submitted['date_end']) || empty($frm_submitted['date_end']))) {
        $frm_submitted['date_end'] = $frm_submitted['date_start'];
        if (!isset($frm_submitted['allDay']) || empty($frm_submitted['allDay'])) {
            $frm_submitted['allDay'] = true;
        }
    } else {
        if (!empty($frm_submitted['time_end'])) {
            $frm_submitted['date_end'] = strtotime(date('Y-m-d', $frm_submitted['date_end']) . ' ' . $frm_submitted['time_end']);
        } else {
            if (!IGNORE_TIMEZONE) {
                $frm_submitted['date_end'] -= TIME_OFFSET;
            }
        }
    }


    if (empty($frm_submitted['title'])) {
        echo json_encode(array('success' => false, 'error' => 'Title is required'));
        exit;
    }

    if (empty($error)) {

                
        // check if repeating event
        if ($frm_submitted['recurring'] === true && isset($frm_submitted['interval']) && ($frm_submitted['interval'] == 'W' ||
                $frm_submitted['interval'] == 'D' ||
                $frm_submitted['interval'] == '2W' ||
                $frm_submitted['interval'] == 'M' ||
                $frm_submitted['interval'] == 'Y')) {


            $arr_days = Utils::getDaysInPattern($frm_submitted);
            $arr_event = Events::insertRepeatingEvent($arr_days, $frm_submitted);

            // save to log
            Utils::addLog('changed_event', -1, $arr_event['event_id'], 'insert');
        
            echo json_encode(array('success' => true));
            exit;
        } else {
            // check if this calendar allows overlapping
//			if(!Settings::getSetting('allow_overlapping')) {
//				if(Events::isTimeAvailable($frm_submitted) || $frm_submitted['date_end'] != $frm_submitted['date_start']) {
//					$arr_event = Events::insertEvent($frm_submitted);
//					echo json_encode(array('success'=>true, 'event'=>$arr_event	));exit;
//				} else {
//					echo json_encode(array('success'=>false, 'error'=>'Overlapping'));exit;
//				}
//			} else {	

            $str_error = '';
            $arr_event = Events::insertEvent($frm_submitted, ($frm_submitted['user_id'] > 0 ? $frm_submitted['user_id'] : ''), ($frm_submitted['user_id'] > 0 ? true : false));

            if (is_array($arr_event)) {
                if (!empty($arr_event['error'])) {
                    $str_error = $arr_event['error'];

                    
                    echo json_encode(array('success' => false, 'event' => $arr_event, 'error' => $str_error));
                    exit;
                } else {
                    // save to log
                    Utils::addLog('changed_event', -1, $arr_event['event_id'], 'insert');
                
                    echo json_encode(array('success' => true, 'event' => $arr_event));
                    exit;
                }
            } else {
                echo json_encode(array('success' => false));
                exit;
            }



//			}
        }
    } else {
        echo json_encode(array('success' => false, 'error' => $error));
        exit;
    }
}

function updateEvent1() {
    global $error;

    $color = DEFAULT_COLOR;

    $arr_submit = array(
        array('color', 'string', false, DEFAULT_COLOR),
        array('date_end', 'int', true, ''),
        array('date_start', 'int', true, ''),
        array('title', 'string', false, ''),
        array('allDay', 'bool', false, ''),
        array('event_id', 'int', true, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    if (empty($error)) {

        if (!empty($frm_submitted['title'])) {
            $frm_submitted['title'] = stripslashes($frm_submitted['title']);

            $arr_event = Events::updateEvent($frm_submitted);

            if (!$arr_event) {
                echo json_encode(array('success' => false));
                exit;
            } else {
                echo json_encode(array('success' => true, 'event' => $arr_event));
                exit;
            }
        }
    }
    echo json_encode(array('success' => false));
    exit;
}

function startEdit() {
    global $error;

    $arr_submit = array(
        array('event_id', 'int', true, -1),
    );

    $frm_submitted = validate_var($arr_submit);

    $arr_result = Events::startEdit($frm_submitted['event_id']);

    echo json_encode(array('success' => $arr_result['bln_can_edit'], 'token' => $arr_result['token']));
    exit;
}

function stopEdit() {
    global $error;
    $bln_stopped = false;

    $arr_submit = array(
        array('event_id', 'int', true, -1),
        array('token', 'string', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    if (isset($frm_submitted['event_id']) && isset($frm_submitted['token'])) {
        $bln_stopped = Events::stopEdit($frm_submitted['event_id'], $frm_submitted['token']);
    } else {
        $bln_stopped = false;
    }
    echo json_encode(array('success' => $bln_stopped));
    exit;
}

function copyEvent() {
    global $error;

    $arr_submit = array(
        array('event_id', 'int', true, ''),
        array('new_startdate', 'string', true, ''),
        array('copy_files', 'string', false, 'off'),
    );

    $frm_submitted = validate_var($arr_submit);

    $bln_success = false;

    if (empty($error)) {
        $bln_success = Events::copyEvent($frm_submitted['event_id'], $frm_submitted['new_startdate']);

        // TODO copy files
    }
    echo json_encode(array('success' => $bln_success));
    exit;
}

function exportToIcs() {
    global $error;

    $arr_submit = array(
        array('event_id', 'int', true, ''),
        
    );

    $frm_submitted = validate_var($arr_submit);

    $bln_success = false;

    if (empty($error)) {
        $str_ics = Utils::exportToIcs($frm_submitted['event_id']);

        echo json_encode(array('success' => true, 'str_ics' => $str_ics));
        exit;
       
    }
    echo json_encode(array('success' => false));
    exit;
}

function customviewUpdate() {
    global $error;
    
    $validate_phonenumber_as = 'phone';
    if(defined('VALIDATE_PHONENUMBER_AS_STRING')) {
        if(VALIDATE_PHONENUMBER_AS_STRING) {
            $validate_phonenumber_as = 'string';
        }
    }
    
    $arr_submit = array(
        array('event_id', 'int', true, ''),
       
        array('title', 'string', false, ''),
        array('location', 'string', false, ''),
        array('description', 'string', false, ''),
        array('phone', $validate_phonenumber_as, false, ''),
       
        array('cal_id', 'int', false, -1),
        array('calendar_id', 'int', false, -1),
        array('team_member_id', 'array', false, ''),
     
    );

    $frm_submitted = validate_var($arr_submit);
    
    if (empty($error)) {
        $frm_submitted['title'] = str_replace('&amp;', '&', $frm_submitted['title']);

        $frm_submitted['title'] = stripslashes($frm_submitted['title']);
        $frm_submitted['location'] = stripslashes($frm_submitted['location']);
        $frm_submitted['description'] = stripslashes($frm_submitted['description']);
        
        $arr_event = Events::customviewUpdateEvent($frm_submitted);
                
        // save to log
        Utils::addLog('changed_event', -1, $arr_event['event_id'], 'update');

        echo json_encode(array('success' => true, 'event' => $arr_event));
        exit;
    }
    
}

function updateEvent() {

    global $error;

    $validate_phonenumber_as = 'phone';
    if(defined('VALIDATE_PHONENUMBER_AS_STRING')) {
        if(VALIDATE_PHONENUMBER_AS_STRING) {
            $validate_phonenumber_as = 'string';
        }
    }
    
    $arr_submit = array(
        array('event_id', 'int', true, ''),
        array('color', 'string', false, ''),
        array('date_end', 'int', true, ''),
        array('date_start', 'int', true, ''),
        array('str_date_end', 'string', false, ''),
        array('str_date_start', 'string', false, ''),
        array('title', 'string', false, ''),
        array('location', 'string', false, ''),
        array('description', 'string', false, ''),
        array('phone', $validate_phonenumber_as, false, ''),
        array('myurl', 'string', false, ''),
        array('cal_type', 'textonly', false, ''),
        array('allDay', 'bool', false, false),
        array('repair_pattern', 'bool', false, false),
        array('rep_event_id', 'int', false, ''),
        array('cal_id', 'int', false, -1),
        array('calendar_id', 'int', false, -1),
        array('team_member_id', 'array', false, ''),
        array('dropdown1_option_id', 'int', false, -1),
        array('dropdown2_option_id', 'int', false, -1),
        array('dropdown3_option_id', 'int', false, -1),
        array('dropdown4_option_id', 'int', false, -1),
        array('dropdown5_option_id', 'int', false, -1),
        array('dropdown1', 'string', false, ''),
        array('dropdown2', 'string', false, ''),
        array('dropdown3', 'string', false, ''),
        array('dropdown4', 'string', false, ''),
        array('dropdown5', 'string', false, ''),
        
        array('assign', 'bool', false, false),
        array('unassign', 'bool', false, false),
        array('interval', 'string', false, ''),
        array('weekdays', 'string', false, ''),
        array('monthday', 'textonly', false, ''),
        array('yearmonthday', 'int', false, ''),
        array('yearmonth', 'int', false, ''),
        array('every_x_days', 'int', false, ''),
        array('every_x_weeks', 'int', false, ''),
        array('recurring', 'bool', false, false),
        array('token', 'string', false, ''),
        array('updateThisItem', 'bool', false, false),
        array('disconnect', 'bool', false, false),
        array('intern_dd', 'bool', false, false),
        
    );

    $frm_submitted = validate_var($arr_submit);

    if(defined('USERS_CAN_ONLY_CHANGE_TITLE') && USERS_CAN_ONLY_CHANGE_TITLE) {
        if(User::isLoggedIn() && User::isUser()) {
            $arr_event = Events::updateTitle($frm_submitted['title'], $frm_submitted['event_id']);

            // save to log
           // Utils::addLog('changed_event', $arr_event['user_id'], $arr_event['event_id'], 'update');

            echo json_encode(array('success' => true, 'event' => $arr_event));
            exit;
        }
    }
    
    
    if (empty($error)) {
        if(!empty($frm_submitted['team_member_id'])) {
            $frm_submitted['team_member_id'] = implode(',', $frm_submitted['team_member_id']);
        }
        
        
        Events::stopEdit($frm_submitted['event_id'], $frm_submitted['token']);

        $frm_submitted['title'] = str_replace('&amp;', '&', $frm_submitted['title']);

        $frm_submitted['title'] = stripslashes($frm_submitted['title']);
        $frm_submitted['location'] = stripslashes($frm_submitted['location']);
        $frm_submitted['description'] = stripslashes($frm_submitted['description']);

        if (!empty($frm_submitted['time_end'])) {
            $frm_submitted['date_end'] = strtotime(date('Y-m-d', $frm_submitted['date_end']) . ' ' . $frm_submitted['time_end']);
        } else {
            if (!IGNORE_TIMEZONE) {
                $frm_submitted['date_end'] -= TIME_OFFSET;
            }
        }
        if (!empty($frm_submitted['time_start'])) {
            $frm_submitted['date_start'] = strtotime(date('Y-m-d', $frm_submitted['date_start']) . ' ' . $frm_submitted['time_start']);
        } else {
            if (!IGNORE_TIMEZONE) {
                $frm_submitted['date_start'] -= TIME_OFFSET;
            }
        }

        // check if repeating event
        // existing repeating event
        if ($frm_submitted['recurring'] === true && $frm_submitted['date_start'] !== $frm_submitted['date_end'] && isset($frm_submitted['interval']) && ($frm_submitted['interval'] == 'W' ||
                $frm_submitted['interval'] == 'D' ||
                $frm_submitted['interval'] == '2W' ||
                $frm_submitted['interval'] == 'M' ||
                $frm_submitted['interval'] == 'Y')) {

            if ($frm_submitted['rep_event_id'] > 0) {
                if($frm_submitted['disconnect'] === true && $frm_submitted['repair_pattern'] === false) {
                    $frm_submitted['repeating_disconnect'] = true;
                    $arr_event = Events::updateEvent($frm_submitted);   // do not update the dates
                    echo json_encode(array('success' => true, 'event' => $arr_event));
                    exit;
                } else if($frm_submitted['updateThisItem'] === true && $frm_submitted['repair_pattern'] === false) {
                    $frm_submitted['repeating_divergent'] = true;
                    $arr_event = Events::updateEvent($frm_submitted);   // do not update the dates
                    echo json_encode(array('success' => true, 'event' => $arr_event));
                    exit;
                } else {
                    $arr_days = Utils::getDaysInPattern($frm_submitted);
                    $arr_event = Events::updateRepeatingEvent($arr_days, $frm_submitted);

                    // save to log
                    Utils::addLog('changed_event', -1, $arr_event['event_id'], 'update');
            
                    echo json_encode(array('success' => true));
                    exit;
                }
                
            } else {
                // normal event changed to repeating pattern
                $arr_days = Utils::getDaysInPattern($frm_submitted);
                $arr_event = Events::insertRepeatingEvent($arr_days, $frm_submitted);

                if ($frm_submitted['event_id'] > 0) {
                    // delete old normal event
                    $bln_deleted = Events::deleteEvent(array('event_id' => $frm_submitted['event_id'],
                                'rep_event_id' => 0));
                }
                // save to log
                Utils::addLog('changed_event', -1, $arr_event['event_id'], 'update');
            
                echo json_encode(array('success' => true));
                exit;
            }
        } else {

            if ($frm_submitted['rep_event_id'] > 0) {
                // this event changed from repeating event to an normal day event

                $bln_deleted = Events::deleteEvent(array('event_id' => $frm_submitted['event_id'],
                            'rep_event_id' => $frm_submitted['rep_event_id'],
                            'delete_all' => true));

//					// delete repeating_event
//					Events::deleteRepeatingEvent($frm_submitted['rep_event_id']);
//
//					// delete events with this rep_event_id
//
//
                // insert new daily event
                $frm_submitted['repeating_event_id'] = 0;
                $frm_submitted['rep_event_id'] = 0;
                $arr_event = Events::insertEvent($frm_submitted);

                $arr_event['remove_old_event'] = true;
               
                // save to log
                Utils::addLog('changed_event', -1, $arr_event['event_id'], 'update');
            
                echo json_encode(array('success' => true, 'event' => $arr_event));
                exit;
//
//					//Events::setEventToNotRepeating($frm_submitted['rep_event_id']);
            } else {
                $arr_event = Events::updateEvent($frm_submitted);
                
                // save to log
                Utils::addLog('changed_event', -1, $arr_event['event_id'], 'update');
            
                echo json_encode(array('success' => true, 'event' => $arr_event));
                exit;
            }
        }

//
//		if($frm_submitted['interval'] == 'W') {
//			// weekday
//
//			$arr_days = Utils::getDaysInPattern($frm_submitted);
//			$arr_event = Events::updateRepeatingEvent($arr_days, $frm_submitted);
//
//			echo json_encode(array('success'=>true));exit;
//		}
//		else {
//			$arr_days = Utils::getDaysInPattern($frm_submitted);
//			$arr_event = Events::insertRepeatingEvent($arr_days, $frm_submitted);
//			//$arr_event = Events::updateEvent($frm_submitted);
//			echo json_encode(array('success'=>true, 'event'=>$arr_event	));exit;
//		}
    } else {
        echo json_encode(array('success' => false, 'error' => $error));
        exit;
    }
    echo json_encode(array('success' => false));
    exit;
}

function resizeEvent() {
    global $error;

    $arr_submit = array(
        array('event_id', 'int', true, ''),
        array('date_end', 'int', true, ''),
        array('date_start', 'int', true, ''),
        array('str_date_end', 'string', false, ''),
        array('str_date_start', 'string', false, ''),
        array('cal_id', 'int', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    if (!$error) {
        $arr_event = Events::resizeEvent($frm_submitted);

        // save to log
        Utils::addLog('changed_event', -1, $arr_event['event_id'], 'resize');
            
        echo json_encode(array('success' => true, 'event' => $arr_event));
        exit;
    } else {
        echo json_encode(array('success' => false));
        exit;
    }
}

function deleteEvent() {
    global $error;

    $arr_submit = array(
        array('event_id', 'int', true, 0),
        array('rep_event_id', 'int', false, 0),
        array('delete_all', 'bool', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);
    if (empty($error)) {
        $bln_deleted = Events::deleteEvent($frm_submitted);
    } else {
        $bln_deleted = false;
              
    }
    echo json_encode(array('success' => $bln_deleted, 'error'=>$error));
    exit;
}

function getEvents() {
    global $error;

    $arr_submit = array(
        array('cal_id', 'string', false, ''),
        array('uid', 'string', false, ''),
        array('option_id', 'string', false, ''),
        array('start', 'int', true, ''),
        array('end', 'int', true, ''),
        array('sd', 'string', false, ''),
        array('ft', 'string', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);
//print_r(date('w', $frm_submitted['start']));
  //  print_r(date('Y-m-d', $frm_submitted['start']));
    if(date('w', $frm_submitted['start']) == 0) {
        $frm_submitted['start'] = strtotime('+1 DAY', $frm_submitted['start']);
    }
//print_r(date('Y-m-d', $frm_submitted['start']));    
    if (!$error) {
        if (isset($_SESSION['fast-easy-calender-sd'])) {
            $frm_submitted['sd'] = '';
            $frm_submitted['ft'] = '';
            unset($_SESSION['fast-easy-calender-sd']);
        } else {
            $_SESSION['fast-easy-calender-sd'] = true;
        }

        if (!empty($frm_submitted['cal_id'])) {
            $arr_calendar = Calendar::getCalendar($frm_submitted['cal_id']);

            if (isset($arr_calendar['origin']) && $arr_calendar['origin'] == 'exchange') {
                $is_owner = false;
                $owner_allowed_to_see_without_token = false;

                if (User::isLoggedIn()) {
                    $is_owner = Calendar::isOwner($frm_submitted['cal_id']);
                    $owner_allowed_to_see_without_token = defined('OWNER_EXCHANGE_CAL_ALLOWED_WITHOUT_TOKEN') && OWNER_EXCHANGE_CAL_ALLOWED_WITHOUT_TOKEN === true;
                }

                if ($is_owner && $owner_allowed_to_see_without_token) {
                    // the owner of the calendar doesn't have to fill in the token to see the events from the exchange calendar
                } else {
                    if ($arr_calendar['exchange_extra_secure'] == 1) {
                        // user has to fill in a key before events are visible
                        if (!isset($_SESSION['ews_exchange_private_token'])) {
                            echo json_encode(array('success' => false, 'error' => 'Token not found', 'token_not_found' => true));
                            exit;
                        } else {
                            if ($_SESSION['ews_exchange_private_token'] !== CalendarOption::getOption('exchange_token', $frm_submitted['cal_id'])) {
                                echo json_encode(array('success' => false, 'error' => 'Token not correct', 'token_not_correct' => true));
                                exit;
                            }
                        }
                    }
                }
            }

            $arr_content = Events::getEvents($frm_submitted);
        } else {
            $arr_content = array();
        }
    } else {
        echo json_encode(array('success' => false, 'error' => $error));
        exit;
    }

    echo json_encode($arr_content);exit;
}

function getCalendar() {
    $arr_cal = array();
    global $error;

    $arr_submit = array(
        array('cal_id', 'int', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    if (empty($error)) {
        $arr_cal = Calendar::getCalendar($frm_submitted['cal_id']);

        $arr_permissions = Calendar::getPermissions($frm_submitted['cal_id']);
        // print_r($arr_permissions);
        $arr_cal['can_edit'] = $arr_permissions['can_edit'];
        $arr_cal['can_add'] = $arr_permissions['can_add'];
        $arr_cal['can_delete'] = $arr_permissions['can_delete'];
        $arr_cal['can_drag'] = $arr_permissions['can_edit'];
        $arr_cal['can_drag_dd_items'] = $arr_permissions['can_see_dditems'];
        $arr_cal['isOwner'] = Calendar::isOwner($frm_submitted['cal_id']);
        $arr_cal['can_change_color'] = $arr_permissions['can_change_color'];
        $arr_cal['can_mail'] = Calendar::calCanMail($arr_cal);
        $arr_cal['only_viewable'] = $arr_permissions['only_viewable'];
        $arr_cal['calendarname_is_title'] = true;
    }

    echo json_encode($arr_cal);
    exit;
}

function getEvent() {
    $arr_event = array();
    global $error;

    $arr_submit = array(
        array('event_id', 'int', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    if (empty($error)) {
        $arr_event = Events::getEventByEventId($frm_submitted['event_id']);

        $arr_event['allDay'] = $arr_event['allDay'] == 0 ? false : true;
        $arr_event['allowEdit'] = User::canEdit($arr_event['user_id'], $arr_event['calendar_id']);
        $arr_event['editable'] = User::canEdit($arr_event['user_id'], $arr_event['calendar_id']);
        $arr_event['deletable'] = User::canDelete($arr_event['user_id'], $arr_event['calendar_id']);
        $arr_event['canChangeColor'] = User::canChangeColor($arr_event['user_id'], $arr_event['calendar_id']);
        //   $arr_event['borderColor'] = 'lightgray';

        if (isset($_SESSION['ews_calendars']) && isset($_SESSION['ews_calendars'][$arr_event['calendar_id']]) && !empty($_SESSION['ews_calendars'][$arr_event['calendar_id']])) {
            $arr_cal = $_SESSION['ews_calendars'][$arr_event['calendar_id']];
        } else {
            $arr_cal = Calendar::getCalendar($arr_event['calendar_id']);
        }

        $arr_event['canMail'] = Calendar::calCanMail($arr_cal);
        $arr_event['calendar_name'] = $arr_cal['name'];

        $arr_event['show_description_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_description_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_description_field'] : true; 
        $arr_event['show_location_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_location_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_location_field'] : false; 
        $arr_event['show_phone_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_phone_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_phone_field'] : false; 
        $arr_event['show_team_member_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_team_member_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_team_member_field'] : false; 
        $arr_event['allday_is_default'] = isset($arr_calendar_options[$arr_event['calendar_id']]['allday_is_default']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['allday_is_default'] : false; 
        $arr_event['show_url_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_url_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_url_field'] : false; 
        $arr_event['show_dropdown_1_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_1_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_1_field'] : false; 
        $arr_event['show_dropdown_2_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_2_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_2_field'] : false; 
        $arr_event['show_dropdown_3_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_3_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_3_field'] : false; 
        $arr_event['show_dropdown_4_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_4_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_4_field'] : false; 
        $arr_event['show_dropdown_5_field'] = isset($arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_5_field']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['show_dropdown_5_field'] : false; 

        $arr_event['add_team_member_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_team_member_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_team_member_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['add_custom_dropdown1_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown1_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown1_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['add_custom_dropdown2_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown2_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown2_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['add_custom_dropdown3_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown3_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown3_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['add_custom_dropdown4_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown4_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown4_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['add_custom_dropdown5_to_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown5_to_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['add_custom_dropdown5_to_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        $arr_event['calendarname_is_title'] = isset($arr_calendar_options[$arr_event['calendar_id']]['calendarname_is_title']) ? (bool) $arr_calendar_options[$arr_event['calendar_id']]['calendarname_is_title'] : true; //CalendarOption::getOption('show_team_member_field', $arr_event['calendar_id'], false);
        
        
    }

    echo json_encode($arr_event);
    exit;
}

function mailEvent() {

    global $error;

    $validate_phonenumber_as = 'phone';
    if(defined('VALIDATE_PHONENUMBER_AS_STRING')) {
        if(VALIDATE_PHONENUMBER_AS_STRING) {
            $validate_phonenumber_as = 'string';
        }
    }
    
    $color = DEFAULT_COLOR;
    $arr_submit = array(
        array('cal_id', 'int', true, ''),
        array('str_date_end', 'string', false, ''),
        array('str_date_start', 'string', false, ''),
        array('title', 'string', false, ''),
        array('location', 'string', false, ''),
        array('phone', $validate_phonenumber_as, false, ''),
        array('myurl', 'string', false, ''),
        array('description', 'string', false, ''),
    );

    $frm_submitted = validate_var($arr_submit);

    $frm_submitted['title'] = stripslashes($frm_submitted['title']);


    if (empty($frm_submitted['title'])) {
        echo json_encode(array('success' => false, 'error' => 'Title is required'));
        exit;
    }

    if (is_null($error) || empty($error)) {

        // get calendar admin mail
        $arr_calendar = Calendar::getCalendar($frm_submitted['cal_id']);

        $to_mail = '';

        if (isset($arr_calendar['calendar_admin_email']) && !empty($arr_calendar['calendar_admin_email'])) {
            if (Utils::checkEmail($arr_calendar['calendar_admin_email'])) {
                $bln_email_correct = true;
                $to_mail = $arr_calendar['calendar_admin_email'];
            }
        } else {
            if (defined('MAIL_EVENT_MAILADDRESS')) {
                $mailaddress = MAIL_EVENT_MAILADDRESS;
                if (!empty($mailaddress)) {
                    if (Utils::checkEmail($mailaddress)) {
                        $bln_email_correct = true;
                        $to_mail = $mailaddress;
                    } else {
                        echo json_encode(array('success' => false, 'error' => 'No correct emailaddress found'));
                        exit;
                    }
                } else {
                    echo json_encode(array('success' => false, 'error' => 'Emailaddress in config.php is empty'));
                    exit;
                }
            } else {
                echo json_encode(array('success' => false, 'error' => 'No emailaddress found'));
                exit;
            }
        }

        if (!empty($to_mail)) {
            $arr_user = array();
            if (User::isLoggedIn()) {
                $arr_user = User::getUser();
            }
            $bln_send = Utils::sendMail('mail_event', $to_mail, '', $frm_submitted, $arr_user);

            if ($bln_send) {
                echo json_encode(array('success' => true, 'msg' => 'Mail successfully send'));
                exit;
            } else {
                echo json_encode(array('success' => false, 'error' => 'Error while sending the email, contact the admin'));
                exit;
            }
        } else {
            // echo json_encode(array('success'=>false, 'error'=>'No calendar admin email found'));
            //  exit;
        }
    } else {
        echo json_encode(array('success' => false, 'error' => $error));
        exit;
    }
}

?>