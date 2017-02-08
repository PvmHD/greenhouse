<?php

/*
 *
 * author Yan Gorshtenin
 */

$current_path = dirname ( realpath ( __FILE__ ) );
$current_path = preg_replace('/\include/i', '', $current_path);

if(file_exists($current_path.'configs/config.php')) {
	require_once $current_path.'configs/config.php';
}

if(!defined('SAVE_CURRENT_EDITING')) {
    //define('SAVE_CURRENT_EDITING', false);
    echo "config-option SAVE_CURRENT_EDITING is missing in config/config.php, set to true if you don't want 2 people editing an event at the same time.";exit;
}
if(!defined('OWNER_EXCHANGE_CAL_ALLOWED_WITHOUT_TOKEN')) {
    define('OWNER_EXCHANGE_CAL_ALLOWED_WITHOUT_TOKEN', false);
}
if(!defined('COPY_EVENT_POSSIBLE')) {
    //define('COPY_EVENT_POSSIBLE', false);
    echo "config-option COPY_EVENT_POSSIBLE is missing in config/config.php, set to true if you want to be able to copy events.";exit;
}
if(defined('SCHEDULE_SQLDUMP') && SCHEDULE_SQLDUMP != 'day' && SCHEDULE_SQLDUMP != 'hour' && SCHEDULE_SQLDUMP != 'never') {
    echo 'SCHEDULE_SQLDUMP has not a correct value, go to config/config.php and set it to "day", "hour" or "never"';exit;
} else if(!defined('SCHEDULE_SQLDUMP')) {
    define('SCHEDULE_SQLDUMP', 'day');
}
if(!defined('FIRSTDAY_OF_WEEK') || !defined('FIRST_SCROLL_HOUR')  || !defined('MIN_VISIBLE_TIME') || !defined('SHOW_WEEKENDS')) {
    echo "Some config-options are missing in config/config.php: <br />define('FIRSTDAY_OF_WEEK', 1);  // The day that each week begins. (0 = sunday, 1 = monday etc.)<br />".
    "define('FIRST_SCROLL_HOUR', 6); // Determines the first hour that will be visible in the scroll pane.<br />".
    "define('MIN_VISIBLE_TIME', 0);  // Determines the first hour/time that will be displayed, even when the scrollbars have been scrolled all the way up.<br />".
    "define('SHOW_WEEKENDS', true);   // show weekenddays or not";exit;

}
if(!defined('MAX_VISIBLE_TIME')) {
    echo "A config-option is missing in config/config.php: <br />define('MAX_VISIBLE_TIME', 0);  // Determines the first hour/time that will be displayed, even when the scrollbars have been scrolled all the way up.<br />";exit;

}
if(!defined('ACTION_ON_CLICK_EVENT_IN_CUSTOM_LISTVIEW') || !defined('ADMINS_GET_NOTIFICATION_POPUPS') || !defined('USERS_GET_NOTIFICATION_POPUPS') || !defined('CHECK_FOR_NOTIFICATIONS_EVERY')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('ACTION_ON_CLICK_EVENT_IN_CUSTOM_LISTVIEW', '4');<br />".
                "// 1. simple_edit dialog<br /> ".
                "// 2. go to monthview and emphasize the event<br />".
                "// 3. go to monthview, emphasize the event and open edit dialog<br />".
                "// 4. goto monthview in new tab, emphasize and open edit dialog and close tab after update or close edit dialog<br />".
            "define('ADMINS_GET_NOTIFICATION_POPUPS', false);<br />".
            "define('USERS_GET_NOTIFICATION_POPUPS', false);<br />".
            "define('CHECK_FOR_NOTIFICATIONS_EVERY', 30000);<br /><br />";
}
if(!defined('SHOW_CALENDAR_NAME_IN_LISTVIEW') || !defined('EVENT_TEXT_COLOR') || !defined('VALIDATE_PHONENUMBER_AS_STRING') || !defined('COMBINE_MOREDAYS_EVENTS') || !defined('SHOW_ICON_FOR_MOREDAYS_EVENTS_IN_CUSTOM_LISTVIEW') || !defined('TRUNCATE_TITLE_IN_CUSTOM_LISTVIEW') || !defined('USERS_SORTING')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('SHOW_CALENDAR_NAME_IN_LISTVIEW', true);<br />".
            "define('COMBINE_MOREDAYS_EVENTS', false);<br />".
            "define('SHOW_ICON_FOR_MOREDAYS_EVENTS_IN_CUSTOM_LISTVIEW', false);<br />".
            "define('TRUNCATE_TITLE_IN_CUSTOM_LISTVIEW', true);<br />".
            "define('EVENT_TEXT_COLOR', 'white');  // white or black or colorcode like #FFFFFF, if white or black the icon is also white or black<br />" .
            "define('VALIDATE_PHONENUMBER_AS_STRING', true);<br />" .
            "define('USERS_SORTING', true);";exit;
}


if(!defined('VALIDATE_PHONENUMBER_AS_STRING')) {
    define('VALIDATE_PHONENUMBER_AS_STRING', false);
}

if(!defined('CUSTOM_LISTVIEW_IS_DEFAULT_VIEW_FOR_USERS_AND_NOT_LOGGEDIN_VIEWERS')) {
    define('CUSTOM_LISTVIEW_IS_DEFAULT_VIEW_FOR_USERS_AND_NOT_LOGGEDIN_VIEWERS', false);
}
if(!defined('HIDE_PERIOD_REFRESH_BUTTON_FOR_USERS_IN_CUSTOM_LISTVIEW')) {
    define('HIDE_PERIOD_REFRESH_BUTTON_FOR_USERS_IN_CUSTOM_LISTVIEW', false);
}
if(!defined('HIDE_SEARCHFIELD_FOR_USERS_IN_CUSTOM_LISTVIEW')) {
    define('HIDE_SEARCHFIELD_FOR_USERS_IN_CUSTOM_LISTVIEW', false);
}
if(!defined('USERS_CAN_ONLY_CHANGE_TITLE')) {
    define('USERS_CAN_ONLY_CHANGE_TITLE', false);
}


if(!defined('HIDE_MINUTES_IN_MONTH_WEEK_DAY_VIEW') || !defined('HIDE_PDF_BUTTON') || !defined('HIDE_PRINT_BUTTON')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('HIDE_MINUTES_IN_MONTH_WEEK_DAY_VIEW', false); <br /> ".
            "define('HIDE_PDF_BUTTON', false);<br />".
            "define('HIDE_PRINT_BUTTON', false);";exit;
}

if(!defined('SLOT_MINUTES') || !defined('SNAP_MINUTES') || !defined('SHOW_PHONEFIELD_IN_REGISTERFORM') || !defined('SLOT_EVENT_OVERLAP') || !defined('SHOW_CALENDAR_NAME_IN_CUSTOM_LISTVIEW')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('SHOW_PHONEFIELD_IN_REGISTERFORM', false);  // true or false - to show the phonefield in the registration form or not<br /> ".
            "define('SLOT_MINUTES', 15);  // The frequency for displaying time slots, in minutes<br /> ".
            "define('SNAP_MINUTES', 15);  // The time interval at which a dragged event will snap to the agenda view time grid. Also affects the granularity at which selections can be made. Specified in number of minutes<br /> ".
            "define('SLOT_EVENT_OVERLAP', true); // Determines if timed events in agenda view should visually overlap.".
            "define('SHOW_CALENDAR_NAME_IN_CUSTOM_LISTVIEW',true); // to show or hide the calendarname in the custom listview";exit;
}
if(!defined('AVAILABLE_EMPLOYEES_DROPDOWN_EMPTYTEXT')) {
    define('AVAILABLE_EMPLOYEES_DROPDOWN_EMPTYTEXT', 'Select user(s)');
}

if(!defined('DAYDATE_IN_MONTHVIEW_FORMAT')) {
    define('DAYDATE_IN_MONTHVIEW_FORMAT', 'd');
}
if(!defined('CAL_BLOCK_FIXED_POSITION')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('CAL_BLOCK_FIXED_POSITION', false);<br />You can also set HIDE_CSV_BUTTON, HIDE_ICS_BUTTON (work in progress)<br /> AND DAYDATE_IN_MONTHVIEW_FORMAT if want to change the format of the weeknr./date in the agenda list view";exit;
}
if(!defined('BOOTSTRAP_LOGIN')) {
    echo "Some config-options are missing in config/config.php: <br />".
            "define('REFRESH_ICON_WHITE', true);  // true or false<br />".
            "define('ASSIGNED_ICON_WHITE', true); // true or false<br />".
            "define('BOOTSTRAP_LOGIN', true);<br />".
            "define('SHOW_LOGO_IN_LOGIN_FORM',true);";exit;
}

if (isset($_SESSION['ews_custom_field_options'])) {
    foreach($_SESSION['ews_custom_field_options'] as $opt) {
        if(!isset($opt['label'])) {
            // the session has to be created new
            unset($_SESSION['ews_custom_field_options']);
        }
    }
}


if(!defined('EXTERNAL_DIR')) {
	echo 'something wrong with the path "FULLCAL_DIR" or config.php not found, copy and rename config.example.php to config.php';exit;
}
require_once EXTERNAL_DIR.'/smarty/Smarty.class.php';
require_once CLASSES_DIR.'/calendar.class.php';
require_once CLASSES_DIR.'/calendar_options.class.php';
require_once CLASSES_DIR.'/custom_fields.class.php';
require_once CLASSES_DIR.'/lists.class.php';
require_once CLASSES_DIR.'/events.class.php';
require_once CLASSES_DIR.'/users.class.php';
require_once CLASSES_DIR.'/groups.class.php';
require_once CLASSES_DIR.'/schedule.class.php';
require_once CLASSES_DIR.'/settings.class.php';
require_once CLASSES_DIR.'/subscriptions.class.php';
require_once LIB_DIR.'/utils.class.php';

if (!function_exists('json_encode')) {
	require_once LIB_DIR.'/jsonwrapper/jsonwrapper_inner.php';
}

if (session_id() == '') { session_start(); }    // moet altijd na de classes

require_once INCLUDE_DIR.'/validate_functions.php';
require_once CONFIG_DIR.'/db.config.php';
//database_close();
database_connect();

global $obj_smarty;
$obj_smarty = new Smarty();
$obj_smarty->compile_dir = FULLCAL_DIR.'/templates_c/';


if(defined('LANGUAGE')) {
	switch(LANGUAGE) {
		case 'EN';
			$locale = array('en_US.UTF-8', 'en_US', 'english', 'en_US.ISO_8859-1');
			break;
		case 'NL';
			$locale = array('nl_NL.UTF-8', 'nl_NL', 'nld_nld', 'dut', 'nla', 'nl', 'nld', 'dutch', 'nl_NL.ISO_8859-1');
			break;
		case 'DE';
			$locale = array('de_DE.UTF-8', 'de_DE', 'de', 'deutsch', 'deu_deu', 'de_DE.ISO_8859-1');
			break;
		case 'FR';
			$locale = array('fr_FR.UTF-8', 'fr_FR', 'french', 'fr_FR.ISO_8859-1');
			break;
		case 'ES';
			$locale = array('es_ES.UTF-8', 'es_ES', 'spanish', 'es_ES.ISO_8859-1');
			break;
		case 'PL';
			$locale = array('pl_PL.ISO_8859-1', 'pl_PL.UTF-8', 'pl_PL', 'polish');
			break;
                case 'NO';
                        $locale = array('nb-NO.UTF-8', 'nb-NO', 'norwegian');
                        break;
                case 'IT';
                        $locale = array('it_IT.UTF-8', 'it_IT', 'italian');
                        break;
                case 'CZ';
                        $locale = array('cz_CZ.UTF-8', 'cz_CZ', 'czech');
                        break;
	}

	setlocale(LC_ALL, $locale);
} else {
	setlocale(LC_ALL, '');
}

if(!IGNORE_TIMEZONE) {
	if(defined('TIMEZONE') && TIMEZONE != '' ) {
		$timezone_name = TIMEZONE;
	} else {
		$timezone_name = date_default_timezone_get();
	}
	date_default_timezone_set($timezone_name);
	$gettimezone = new DateTimeZone($timezone_name);
	$offset = ($gettimezone->getOffset(new DateTime) );
	define('TIME_OFFSET', $offset);
}
//if(User::isLoggedIn()) {
//	$arr_user = User::getUser();
//	$timezone = Settings::getTimezone($arr_user['user_id']);
//}
//if(!empty($timezone)) {
//	$timezone_name = $timezone;
//} else {
//	$timezone_name = date_default_timezone_get();
//}
//date_default_timezone_set($timezone_name);
//$gettimezone = new DateTimeZone($timezone_name);
//$offset = ($gettimezone->getOffset(new DateTime) );
//define('TIME_OFFSET', $offset);
