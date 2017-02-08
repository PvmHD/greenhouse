<!DOCTYPE html>
<html lang="<?smarty if isset($language) && !empty($language) ?><?smarty $language ?><?smarty else ?><?smarty $smarty.const.LANGUAGE ?><?smarty /if ?>">
    <head>
        <meta charset="utf-8">
        <title><?smarty $smarty.const.CALENDAR_TITLE ?></title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="<?smarty $smarty.const.CALENDAR_TITLE ?>">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
                <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <link href="<?smarty $smarty.const.EXTERNAL_URL ?>/bootstrap/css/bootstrap2.2.min.css" rel="stylesheet">
        <link href="<?smarty $smarty.const.FULLCAL_URL ?>/style/custom_dashboard_styles.css" rel="stylesheet">

        <link rel='stylesheet' type='text/css' href='<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/jqueryui/1.8.17/jquery-ui.css' />
        <link rel='stylesheet' type='text/css' href='<?smarty $smarty.const.EXTERNAL_URL ?>/fullcalendar-1.6.4/fullcalendar/fullcalendar.print.css' media='print' />

        <link rel="shortcut icon" href="/favicon.ico">

        <script src="<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/jquery.1.11.1.min.js"></script>
        <script src="<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/jquery-ui.1.11.1.min.js" type="text/javascript" charset="utf-8"></script>

        <script type="text/javascript" src="<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/multiselect/js/ui.multiselect.js"></script>
        <script type="text/javascript" src="<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/multiselect/js/plugins/tmpl/jquery.tmpl.1.1.1.js"></script>
        
        
        <link rel='stylesheet' href='<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/multiselect/css/ui.multiselect.css' />
		
        <script src='<?smarty $smarty.const.EXTERNAL_URL ?>/bgrins-spectrum/spectrum.js'></script>
        <link rel='stylesheet' href='<?smarty $smarty.const.EXTERNAL_URL ?>/bgrins-spectrum/spectrum.css' />

        <link rel='stylesheet' type='text/css' href='<?smarty $smarty.const.EXTERNAL_URL ?>/jquery-timepicker-1.3.2/jquery.timepicker.css'  />
        <script type='text/javascript' src='<?smarty $smarty.const.EXTERNAL_URL ?>/jquery-timepicker-1.3.2/jquery.timepicker.min.js'></script>
	
        <link rel="stylesheet" href="<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/pq-multiselect/pqselect.dev.css" />   

        <script src = "<?smarty $smarty.const.EXTERNAL_URL ?>/jquery/pq-multiselect/pqselect.dev.js"></script>

        <script type='text/javascript' src='<?smarty $smarty.const.EXTERNAL_URL ?>/dateformat.js'></script>
        
		<style>
			::-webkit-input-placeholder {
			    color: red;
			}
			:-moz-placeholder {
			    color: #acacac !important;
			}
			::-moz-placeholder {
			    color: #acacac !important;
			} /* for the future */
			:-ms-input-placeholder {
			    color: #acacac !important;
			}

			#admin-colpick-colorpicker {
				border:0;
				width:70px;
				border-right:20px solid green;
				border-image: none;
    			border-style: solid;
    			border-width: 1px 20px 1px 1px;
			}

			
            
            fieldset {
                display: block;
                margin-left: 2px;
                margin-right: 2px;
                padding-top: 0.35em;
                padding-bottom: 0.625em;
                padding-left: 0.75em;
                padding-right: 0.75em;
                border: 2px groove (internal value);
            } 
            
            .dashboard_btn {
                padding:4px;
                border:1px solid #D4D4D4;
                border-radius: 3px;
                cursor: pointer;
                text-decoration: none;
            }
            
            .dashboard_block {
                border: 1px solid #DCDCDC;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 15px;
            }
    
            h4 {
                margin: 5px 0;
                padding-top: 10px;
            }
            
            .form-horizontal .control-label {
                width: 230px;
            }
            
            .form-horizontal .controls  {
                margin-left: 250px;
            }
            
            .ui-dialog { z-index: 9999 !important ;}
            
            .ui-multiselect {
                width: auto !important;
                height: 220px;
                border: none;
               
            }
            #select_user .selected, #select_user .available {
                width: auto !important;
                min-width: 190px;
                
            }
            .list {
                height:100% !important;
            }
           
            .connected-list {
                height: 190px !important;
            }
            .ui-dialog .ui-dialog-content {
                padding: 0.5em 0.1em;
                
            }
            
            .ui-dialog-titlebar-close {
                display: none !important;
            }
            
            .ui-multiselect li {
                font-size: 12px;
            }
            
            .sp-replacer {
                width: 50px;
            }
            
            .user-import-sjabloon-block .required {
                background-color: #F3F3F3;
            }
            
            .user-import-sjabloon-block td {
                padding-left:5px;
                padding-right:5px;
                border:1px solid lightgray;
            }
            
            #file_upload_form td {
                height: 30px;
            }
            
            #admin_settings_dropdowns_are_linked td {
                border: 1px solid #AFAFAF;
                text-align: center;
            }
            img {
                max-width: 16px !important;
            }
            
            
		</style>
		<script type='text/javascript'>
			MyCalendar = {};
			MyCalendar.sendActivationMail			= <?smarty if $smarty.const.SEND_ACTIVATION_MAIL ?>true<?smarty else ?>false<?smarty /if ?>;
            MyCalendar.FCfirstDay                   = '<?smarty $smarty.const.FIRSTDAY_OF_WEEK ?>';
    
            var tableToExcel = (function() {
                var uri = 'data:application/vnd.ms-excel;base64,'
                  , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                  , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
                  , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
                return function(table, name) {
                  if (!table.nodeType) table = document.getElementById(table)
                  var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
                  window.location.href = uri + base64(format(template, ctx))
                }
            })();
            
            $(document).ready(function() {
                $('#print_btn2').click(function() {
                    window.print();
                });
                
                $('#lists_to_excel_btn').click(function(t) {
                    tableToExcel('lists_table', 'Hour calculation');
                });
                $('#list_to_excel_btn').click(function(t) {
                    tableToExcel('list_table', 'Hour calculation of');
                });
                
                $('#team_member_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_team_member_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_team_member_to_title').hide();
                    }
                });
                
                $('#custom_dropdown1_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_custom_dropdown1_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_custom_dropdown1_to_title').hide();
                    }
                });
                
                $('#custom_dropdown2_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_custom_dropdown2_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_custom_dropdown2_to_title').hide();
                    }
                });
                
                $('#custom_dropdown3_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_custom_dropdown3_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_custom_dropdown3_to_title').hide();
                    }
                });
                
                $('#custom_dropdown4_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_custom_dropdown4_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_custom_dropdown4_to_title').hide();
                    }
                });
                
                $('#custom_dropdown5_field_id').click(function(t) {
                    if($(this).is(':checked')) {
                        $('#add_custom_dropdown5_to_title').show();
                        $('#event_title_additions_hr').show();
                        $('#event_title_additions_h4').show();
                    } else {
                        $('#add_custom_dropdown5_to_title').hide();
                    }
                });
            });
            
            <?smarty if $active == 'group' ?>
                if(MyCalendar === undefined) {
                    MyCalendar = {};
                }
                MyCalendar.cntGroupUsers = <?smarty if $group.cnt_users !== null && $group.cnt_users !== '' ?><?smarty $group.cnt_users ?><?smarty else ?>0<?smarty /if ?>;
            <?smarty /if ?>
		</script>
        
        <script type='text/javascript' src='<?smarty $smarty.const.FULLCAL_URL ?>/script/listeners.js'></script>
		<script type='text/javascript' src='<?smarty $smarty.const.FULLCAL_URL ?>/script/lang<?smarty $language ?>.js'></script>

	</head>

	<body>

	<div class="navbar navbar-fixed-top">
            <div class="navbar">
                <div class="navbar-inner">
                    <div class="container">

                        <a class="brand" href="<?smarty $smarty.const.FULLCAL_URL ?>/admin">Admin Dashboard</a>
                        <a style="float:left;padding-top:17px;color:#777777;text-decoration: none;" href="<?smarty $smarty.const.FULLCAL_URL ?>">
                            <span class="dashboard_btn"><i class="icon-calendar"></i> <span class="calendar_btn">Calendar</span></span></a>
                        <span style="float:right;padding-top:17px;">Logged in: <?smarty $name ?></span>
                        <span style="float:right;margin-right: 10px;padding-top: 17px;" class="button-fc-like" id="print_btn2">
                            <span class="dashboard_btn">
                                <i class="icon-print"></i> <span class="print_btn">Print</span>
                            </span>
                        </span>
                   		
                    </div>
                </div>
            </div>
	</div>


	<div class="container">
		<div class="row">

			<div class="span12">
				<div class="tabbable tabs-left">

					<ul class="nav nav-tabs">
						<?smarty if $is_super_admin ?>
                        
                        <?smarty else ?>
                        
                        <?smarty /if ?>
                        
                        <li <?smarty if $active == "users" ?>class="active"<?smarty /if ?>><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users"><i class="icon-user"></i> <?smarty if $is_super_admin ?><span id="admin_admins_menu">Admins</span> /<br /><span id="admin_users_menu">Users</span><?smarty else ?><span id="admin_users_menu">Users</span><?smarty /if ?></a></li>
                        
                        <?smarty if $active == "new_user" ?><li class="active"><a href="#new_user" data-toggle="tab"><i class="icon-user"></i> <span id="admin_add_user_menu">Add user</span></a></li><?smarty /if ?>
                        <?smarty if $active == "quick_new_user" ?><li class="active"><a href="#quick_new_user" data-toggle="tab"><i class="icon-user"></i> <span id="<?smarty if $is_super_admin ?>admin_quick_add_admin_menu<?smarty else ?>admin_quick_add_user_menu<?smarty /if ?>">Quick add user</span></a></li><?smarty /if ?>
                        <?smarty if $active == "import_users" ?><li class="active"><a href="#import_users" data-toggle="tab"><i class="icon-user"></i> <span id="admin_import_users_menu">Import users</span></a></li><?smarty /if ?>
                        <?smarty if $active == "availability" ?><li class="active"><a href="#" data-toggle="tab"><i class="icon-list"></i> <span id="admin_add_availability_menu">Add availability</span></a></li><?smarty /if ?>
                        
                        <?smarty if $active == "profile" ?><li class="active"><a href="#profile" data-toggle="tab"><i class="icon-user"></i> <span class="menu_profile">Profile</span></a></li><?smarty /if ?>
						
                        <?smarty if $is_admin ?>
                        <li <?smarty if $active == "groups" ?>class="active"<?smarty /if ?>><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/group.png" style="position:relative;left:-2px;" /> <span style="position:relative;left:-2px;" class="<?smarty if $is_super_admin ?>groups_lable<?smarty elseif $is_admin ?>my_groups_lable<?smarty /if ?>">Groups</span></a></li>
						<?smarty if $active == "group" ?><li class="active"><a href="#group" data-toggle="tab"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/group.png" style="position:relative;left:-2px;" /> <?smarty if isset($smarty.get.action) && $smarty.get.action == 'new_group' ?>Add group<?smarty else ?>Edit group<?smarty /if ?></a></li><?smarty /if ?>
                        <?smarty /if ?>
                        
                        <?smarty if $active == "new_group" ?><li class="active"><a href="#new_group" data-toggle="tab"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/group.png" style="position:relative;left:-2px;" /> <span style="position:relative;left:-2px;" id="admin_add_group_menu">Add group</span></a></li><?smarty /if ?>
                        
                        <li <?smarty if $active == "calendars" ?>class="active"<?smarty /if ?>><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars"><i class="icon-list"></i> <span class="<?smarty if $is_super_admin ?>admin_calendars_menu<?smarty elseif $is_admin ?>admin_my_calendars_menu<?smarty /if ?>">Calendars</span></a></li>
						<?smarty if $active == "calendar" ?><li class="active"><a href="#calendar" data-toggle="tab"><i class="icon-calendar"></i> <?smarty if isset($smarty.get.action) && $smarty.get.action == 'new_calendar' ?>Add calendar<?smarty else ?>Edit calendar<?smarty /if ?></a></li><?smarty /if ?>
                         
                        <?smarty if $is_admin && !$is_super_admin ?>
                        <li <?smarty if $active == "lists" ?>class="active"<?smarty /if ?>><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists"><i class="icon-time"></i> <span id="admin_hour_calculation_menu">Hour Calculation</span></a></li>
						<?smarty /if ?>
                        
                        <?smarty if $is_admin && !$is_super_admin ?>
                        <li <?smarty if $active == "settings" ?>class="active"<?smarty /if ?>><a href="<?smarty $smarty.const.FULLCAL_URL ?>/<?smarty if $is_user ?>user/?action=get_settings<?smarty else ?>admin/settings<?smarty /if ?>"><i class="icon-cog"></i> <span id="admin_settings_menu">Settings</span></a></li>
                        <?smarty /if ?>
                        
                        
                        <li><a href="<?smarty $smarty.const.FULLCAL_URL ?>?action=logoff"><i class="icon-close"></i><span id="menu_logout">Log out</span></a></li>
                    </ul>

					<div class="tab-content">

					<?smarty if $active == 'admin' ?>
						<div id="admin-current-events"  style="padding-top:20px;padding-left:20px;">
							<?smarty if !empty($current_events) ?>
                                <h4>Current events</h4>
                                <div class="dashboard_block">

                                    <?smarty foreach from=$current_events item=event ?>
                                        <span style="font-weight:bold;<?smarty if !empty($event.calendar_color) ?>color: <?smarty $event.calendar_color ?>;<?smarty /if ?>"><?smarty $event.name ?>: &nbsp;</span> 
                                        <?smarty $event.title ?> </span> - 
                                        <?smarty if $event.allDay ?>allDay<?smarty /if ?>
                                        <?smarty if !$event.end_is_today ?>until <?smarty $event.date_end ?> 
                                            <?smarty if !$event.allDay ?> <?smarty $event.time_end ?><?smarty /if ?>
                                        <?smarty else ?>
                                            <?smarty if !$event.allDay ?>until  <?smarty $event.time_end ?><?smarty /if ?>
                                        <?smarty /if ?> <br />
                                    <?smarty /foreach ?>
                                </div>
                            <?smarty /if ?>
                            
                            <?smarty if !empty($last_added_events) ?>
                                <h4>Last added events</h4>
                                <div class="dashboard_block">

                                    <?smarty foreach from=$last_added_events item=event ?>
                                    <span style="font-weight:bold;<?smarty if !empty($event.calendar_color) ?>color: <?smarty $event.calendar_color ?>;<?smarty /if ?>"><?smarty $event.name ?>: &nbsp;</span> 
                                        <?smarty $event.title ?> 
                                        
                                        <?smarty* if $event.allDay ?>allDay<?smarty /if ?>
                                        <?smarty if !$event.end_is_today ?>until <?smarty $event.date_end ?> 
                                            <?smarty if !$event.allDay ?> <?smarty $event.time_end ?><?smarty /if ?>
                                        <?smarty else ?>
                                            <?smarty if !$event.allDay ?>until  <?smarty $event.time_end ?><?smarty /if ?>
                                        <?smarty /if *?> 
                                        <span style="float:right;color:gray;">Added on <?smarty if (isset($settings.show_am_pm) && $settings.show_am_pm == 'on') || (!isset($settings.show_am_pm) && $smarty.const.SHOW_AM_PM) ?><?smarty $event.create_date|date_format:"%m/%d/%Y %r" ?><?smarty else ?><?smarty $event.create_date|date_format:"%d-%m-%Y %R" ?><?smarty /if ?> by <?smarty $event.fullname ?></span>
                                        <br />
                                    <?smarty /foreach ?>
                                </div>
                            <?smarty /if ?>
                            
                            <?smarty if !empty($last_loggedin_users) ?>
                                <h4>Last logged in users</h4>
                                <div class="dashboard_block">

                                    <?smarty foreach from=$last_loggedin_users item=user ?>
                                    <span style="font-weight:bold;"><?smarty $user.firstname ?><?smarty if !empty($user.infix) ?> <?smarty $user.infix ?><?smarty /if ?> <?smarty $user.lastname ?>&nbsp;</span> 
                                        
                                        <span style="float:right;color:gray;"><?smarty if (isset($settings.show_am_pm) && $settings.show_am_pm == 'on') || (!isset($settings.show_am_pm) && $smarty.const.SHOW_AM_PM) ?><?smarty $user.date|date_format:"%m/%d/%Y %r" ?><?smarty else ?><?smarty $user.date|date_format:"%d-%m-%Y %R" ?><?smarty /if ?></span>
                                        <br />
                                    <?smarty /foreach ?>
                                </div>
                            <?smarty /if ?>
                            
						</div>
                    

                            <?smarty elseif $active == 'users' ?>
                            <div id="admin-users"  style="padding-top:20px;padding-left:20px;">
                                    <?smarty if !empty($error) ?>
                                    <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                            <?smarty $error ?>
                                    </div>
                                    <?smarty /if ?>

                                    <?smarty if !empty($msg) ?>
                                    <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                            <?smarty $msg ?>
                                    </div>
                                    <?smarty /if ?>

                                <?smarty if $is_super_admin ?>
                                    <form style="float:right;" id="settings-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=new_admin" method="post" class="form-horizontal">
                                        <?smarty if isset($smarty.session.add_user_error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                            <?smarty $smarty.session.add_user_error ?>
                                        </div>
                                        <?smarty /if ?>

                                        <div>
                                            <button id="add-admin-btn" class="btn btn-primary save" name="add-user" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Add admin</button>
                                        </div>
                                    </form>
                                    <form style="float:right;padding-right:5px;" id="settings-quick-add-user-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=quick_new_admin" method="post" class="form-horizontal">

                                        <div>
                                            <button id="quick_add-admin-btn" class="btn btn-primary save" name="quick-add-user" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Quick add admin</button>
                                        </div>
                                    </form>
                                <?smarty else ?>
                                    <form style="float:right;padding-right:5px;" id="users-import-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=import_users" method="post" class="form-horizontal">

                                        <div>
                                            <button id="quick_import-user-btn" class="btn btn-secondary" name="import-user" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Import users</button>
                                        </div>
                                    </form>
                                    <form style="float:right;padding-right:5px;" id="settings-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=new_user" method="post" class="form-horizontal">
                                        <?smarty if isset($smarty.session.add_user_error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                            <?smarty $smarty.session.add_user_error ?>
                                        </div>
                                        <?smarty /if ?>

                                        <div>
                                            <button id="add-user-btn" class="btn btn-primary save" name="add-user" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Add user</button>
                                        </div>
                                    </form>
                                    <form style="float:right;padding-right:5px;" id="settings-quick-add-user-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=quick_new_user" method="post" class="form-horizontal">

                                        <div>
                                            <button id="quick_add-user-btn" class="btn btn-primary save" name="quick-add-user" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Quick add user</button>
                                        </div>
                                    </form>
                                <?smarty /if ?>
                                
								

                                        <legend><?smarty if $is_super_admin ?><span class="admins_lable">Admins</span> / <span class="users_lable">Users</span><?smarty else ?><span class="users_lable">Users</span><?smarty /if ?></legend>

                                        <form action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/" name="user_search_form" id="user_search_frm" method="post" style="padding-bottom: 20px;">
                                            <span id="users_clear_search_button"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/remove2.png" style="float:right;border:1px solid #cccccc;padding:5px;border-radius: 3px;cursor:pointer;" /></span>
                                            <input type="submit" id="users_search_button" style="float:right;margin-left:5px;margin-right:5px;padding:3px 12px;" class="btn btn-primary" name="search_user"  data-loading-text="search..."  value="Search" /> 
                                            <input type="text" id="users_search_field" name="sq" value="<?smarty $sq ?>" style="float:right;font-size:13px;margin-bottom: 0;width: 150px;padding:3px;" />

                                        
                                        </form>
                                        
                                    
                                        <div id="user_list">
                                                <table class="table table-striped" style="font-size:14px;">
                                                        <thead>
                                                                <tr>
                                                                        <th><span class="username_label">Username</span></th>
                                                                        <th><span class="title_label">Title</span></th>
                                                                        <th><span class="name_label">Name</span></th>
                                                                        <th><span class="email_label">Email</span></th>
                                                                        <th><span class="registration_date_label">Registration date</span></th>
                                                                        <th><span class="active_label">Active</span></th>

                                                                </tr>
                                                        </thead>
                                                        <tbody>

                                                        <?smarty foreach from=$users item=item ?>

                                                                <tr>
                                                                        <td><?smarty $item.username ?></a> <?smarty if $item.superadmin ?><span class="label label-important">superadmin</span><?smarty elseif $item.admin ?><span class="label label-important">admin</span><?smarty elseif $item.trial ?><span class="label label-info">trial</span><?smarty elseif $item.has_subscription ?><span class="label label-info">subscr. ends <?smarty $item.subscription.enddate|date_format:"%d-%m-%Y" ?></span><?smarty /if ?></td>
                                                                        <td><?smarty $item.title ?></td>
                                                                        <td><?smarty $item.firstname ?> <?smarty if !empty($item.infix) ?><?smarty $item.infix ?> <?smarty /if ?><?smarty $item.lastname ?></td>
                                                                        <td><?smarty $item.email ?></td>
                                                                        <td><?smarty $item.registration_date ?></td>
                                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.active ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>

                                                                        <td class="not_print" style="border-left:1px solid #DDDDDD;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users?action=get_profile&uid=<?smarty $item.user_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/edit.png" /></a></td>
                                                                        <td class="not_print"><?smarty if !$item.superadmin && $item.user_id != $user_id ?><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users?action=delete&uid=<?smarty $item.user_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/delete.png" /></a><?smarty /if ?></td>
                                                                </tr>
                                                        <?smarty /foreach ?>

                                                        </tbody>
                                                </table>

								<!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


							</div>

                        <?smarty elseif $active == 'groups' && $is_admin ?>
						
                            <div id="admin-groups"  style="padding-top:20px;padding-left:20px;">
                                    <?smarty if !empty($error) ?>
                                    <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                            <?smarty $error ?>
                                    </div>
                                    <?smarty /if ?>

                                    <?smarty if !empty($msg) ?>
                                    <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                            <?smarty $msg ?>
                                    </div>
                                    <?smarty /if ?>

                                    <form style="float:right;" id="settings-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups/?action=new_group" method="post" class="form-horizontal">
                                        <?smarty if isset($smarty.session.add_user_error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                            <?smarty $smarty.session.add_user_error ?>
                                        </div>
                                        <?smarty /if ?>

                                        <div>
                                            <button id="add-group-btn" class="btn btn-primary save" name="add-group" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Add group</button>
                                        </div>
                                    </form>
                                                                   								

                                    <legend><span class="<?smarty if $is_super_admin ?>groups_lable<?smarty elseif $is_admin ?>my_groups_lable<?smarty /if ?>">My Groups</span></legend>

                                    <div id="user_list">
                                            <table class="table table-striped" style="font-size:14px;">
                                                    <thead>
                                                            <tr>
                                                                    <th><span class="name_label">Name</span></th>
                                                                    <th><span class="count_users_label">Count users</span></th>
                                                                    <?smarty if $is_super_admin ?><th><span class="owner_label">Owner</span></th><?smarty /if ?>
                                                                    <th><span class="active_label">Active</span></th>

                                                            </tr>
                                                    </thead>
                                                    <tbody>

                                                    <?smarty foreach from=$groups item=item ?>

                                                            <tr>
                                                                    <td><?smarty $item.name ?></td>
                                                                    <td><?smarty $item.cnt_users ?></td>
                                                                    <?smarty if $is_super_admin ?><td><?smarty $item.fullname ?></td><?smarty /if ?>
                                                                    <td style="text-align:left;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.active ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>

                                                                    <td class="not_print" style="width:10px;border-left:1px solid #DDDDDD;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups/?action=get_group&gid=<?smarty $item.group_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/edit.png" /></a></td>
                                                                    <td class="not_print" style="width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups?action=delete&gid=<?smarty $item.group_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/delete.png" /></a></td>
                                                            </tr>
                                                    <?smarty /foreach ?>

                                                    </tbody>
                                            </table>

								<!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


					</div>
                                </div>
                    <?smarty elseif $active == 'group' ?>
                        <div id="admin-user-add-group" style="padding-top:20px;padding-left:20px;">
                                <?smarty if isset($error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                                <?smarty $error ?>
                                        </div>
                                <?smarty /if ?>

                                <legend><?smarty if isset($smarty.get.action) && $smarty.get.action == 'new_group' ?><span id="add_group_label">Add group</span><?smarty else ?><span id="edit_group_label">Edit group</span>: <strong><?smarty $group.name ?></strong><?smarty /if ?></legend>

                                <form action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups/?action=save_group" method="POST" class="form-horizontal">
                                    <div class="control-group">
                                            <label for="admin_add_name" class="control-label">Name </label>
                                            <div class="controls">
                                            <input type="text" class="input-xlarge" id="addgroup_name" name="name" value="<?smarty $group.name ?>">
                                                </div>
                                        </div>

                                        <div class="control-group">
                                                <label for="admin_add_description" class="control-label">Description </label>
                                                <div class="controls">
                                                        <input type="text" class="input-xlarge" id="addgroup_description" name="description" value="<?smarty $group.description ?>">
                                                </div>
                                        </div>

                                    <div class="control-group">
                                        <label for="admin_group_active" class="control-label" id="admin_group_active_label"> Active </label>
                                        <div class="controls">
                                            <input type="checkbox" id="admin_group_active" name="active" <?smarty if $group.active ?>checked="true"<?smarty /if ?> />
                                        </div>
                                    </div>
                                   
                                    <div class="control-group" id="admin_groupusers_field" style="margin-bottom:1px;">
                                        <label id="admin_user_label_id" class="control-label" style="padding-right:20px;">Users </label>
                                        <div class="controls" style="margin-left:3px;">
                                            <select id="admin_user_selectbox" name="groupusers[]" multiple="multiple" style="">
                                                <?smarty if isset($group.users) ?>
                                                <?smarty foreach from=$group.users item=item ?>
                                                    <option <?smarty if $item.selected == 1 ?>selected="selected"<?smarty /if ?> class="" value="<?smarty $item.user_id ?>" ><?smarty $item.title ?> <?smarty $item.fullname ?></option>
                                                <?smarty /foreach ?>
                                                <?smarty elseif isset($users) ?>
                                                <?smarty foreach from=$users item=item ?>
                                                    <option <?smarty if $item.selected == 1 ?>selected="selected"<?smarty /if ?> class="" value="<?smarty $item.user_id ?>" ><?smarty $item.title ?> <?smarty $item.fullname ?></option>
                                                <?smarty /foreach ?>
                                                <?smarty /if ?>
                                            </select>
                                        </div>

                                    </div>
                                    
                                 
                                    
                                    <input type="hidden" name="group_id" value="<?smarty $group.group_id ?>" />

                                    <div class="form-actions">
                                            <button class="btn btn-primary save" name="save-add-group" type="submit">Save group</button>
                                    </div>
                                </form>
                            </div>
                    
                    <?smarty elseif $active == 'import_users' ?>
                        <div id="admin-user-add-user" style="padding-top:20px;padding-left:20px;">
                                <?smarty if isset($error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                                <?smarty $error ?>
                                        </div>
                                <?smarty /if ?>

                                <legend>Import users</legend>
                                <p>
                                    Export your users table completely (all columns) to CSV. <br />
                                    Choose export method: 'extended'. <br />
                                    Columns enclosed with: [empty]<br />
                                    Columns converted with character: [empty]<br />
                                    Column names places in the first row: true<br /><br />
                                </p>
                                <form id="file_upload_form" method="post" enctype="multipart/form-data" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=upload_file_and_import" class="form-horizontal">
                                    <table>
                                        <tr>
                                            <td style="width:20px;">
                                                <input type="radio" name="user_import_file" value="wordpress" />    
                                            </td>
                                            <td>
                                                <b>Wordpress</b> (10 columns)
                                            </td>  
                                        
                                        </tr> 
                                    </table>
                                    <table>
                                        <tr class="user-import-sjabloon-block" style="height:20px;">
                                            <td style="width:20px !important;">ID</td>
                                            <td class="required">user_login</td>
                                            <td>user_pass</td>
                                            <td>user_nicename</td>
                                            <td class="required">user_email</td>
                                            <td>user_url</td>
                                            <td class="required">user_registered</td>
                                            <td>user_activation_key</td>
                                            <td>user_status</td>
                                            <td class="required">display_name</td>
                                            
                                        </tr>
                                    </table>
                                    <br />
                                    <table>
                                        <tr>
                                            <td style="width:20px;">
                                                <input type="radio" name="user_import_file" value="phpbb_3.0.14" />   
                                            </td>
                                            <td>
                                                <b>phpBB 3.0.14</b> (76 columns)
                                            </td>  
                                            
                                            
                                        </tr> 
                                    </table>
                                    <table>
                                        <tr class="user-import-sjabloon-block" style="height:20px;">
                                            <td>...</td>	
                                            <td class="required">user_ip</td>
                                            <td class="required">user_regdate</td>
                                            <td class="required">username</td>
                                            <td>...</td> 	
                                            <td class="required">user_email</td>
                                            <td>...</td>	
                                            <td class="required">user_birthday</td>
                                            <td>...</td>
                                            <td class="required">user_from</td>
                                            <td>...</td> 
                                            <td class="required">user_interests</td>
                                            
                                        </tr>
                                    </table>
                                    <br />
                                    <table>
                                        <tr>
                                            <td style="width:20px;">
                                                <input type="radio" name="user_import_file" value="phpbb_3.1.7" />   
                                            </td>
                                            <td>
                                                <b>phpBB 3.1.7</b> (66 columns)
                                            </td>  
                                            
                                            
                                        </tr> 
                                    </table>
                                    <table>
                                        <tr class="user-import-sjabloon-block" style="height:20px;">
                                            <td>...</td>	
                                            <td class="required">user_ip</td>
                                            <td class="required">user_regdate</td>
                                            <td class="required">username</td>
                                            <td>...</td> 	
                                            <td class="required">user_email</td>
                                            <td>...</td>	
                                            <td class="required">user_birthday</td>
                                            <td>...</td>
                                             
                                            
                                        </tr>
                                    </table>
                                    <br />
                                    <table>
                                        <tr>
                                            <td style="width:20px;">
                                                <input type="radio" name="user_import_file" checked="checked" value="generic" />    
                                            </td>
                                            <td style="width:70px;">
                                                <b>Generic</b>    
                                            </td>  
                                            
                                        </tr>  
                                    </table>
                                    <table>
                                        <tr class="user-import-sjabloon-block" style="height:20px;">
                                            <td>title</td>	
                                            <td>firstname</td>	
                                            <td>infix</td>	
                                            <td class="required">lastname</td>	
                                            <td class="required">email</td>
                                            <td class="required">registration_date</td>
                                            <td>birth_date</td> 	
                                            <td class="required">username</td>
                                            <td>ip</td>
                                            <td>country</td>
                                            <td>user_info</td>
                                            
                                        </tr>
                                    </table>
                                                         
                                    <br /><br />
                                    <div class="control-group">
                                        <label for="admin_import_users_select_file" class="control-label">Select a CSV file </label>
                                        <div class="controls">
                                            <input name="file" type="file" id="select_file_field" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label for="admin_import_users_separated_by" class="control-label">Columns separated by </label>
                                        <div class="controls">
                                            <select style="width:40px;" name='columns_separated_by'>
                                                <option value='comma'>,</option>
                                                <option value='dot_comma'>;</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    
                                    <div class="form-actions">
                                            <button class="btn btn-primary" name="save-import-users" type="submit">Import</button>
                                    </div>
                                </form>
                        </div>

                    
                    <?smarty elseif $active == 'new_user' ?>
                                <div id="admin-user-add-user" style="padding-top:20px;padding-left:20px;">
                                        <?smarty if isset($error) ?>
                                                <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                                        <?smarty $error ?>
                                                </div>
                                        <?smarty /if ?>

                                        <legend>Add user</legend>

                                <form action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=add_<?smarty if $is_super_admin ?>admin<?smarty else ?>user<?smarty /if ?>" method="POST" class="form-horizontal">
                                    <div class="control-group">
                                            <label for="admin_user_add_title" class="control-label">Title </label>
                                            <div class="controls">
                                                    <input type="text" class="input-xlarge" id="adduser_title" name="title" value="">
                                            </div>
                                    </div>
                                    <div class="control-group">
                                        <label for="admin_user_add_name" class="control-label">Name </label>
                                        <div class="controls">
                                                <input style="width:94px;" type="text" class="input-xlarge" id="adduser_firstname" name="firstname" placeholder="Firstname" value="">
                                                <?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>
                                                        <input style="width:30px;" type="text" class="input-xlarge" id="adduser_infix" name="infix" value="">
                                                <?smarty /if ?>
                                                <input style="width:<?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>110<?smarty else ?>152<?smarty /if ?>px;" type="text" class="input-xlarge" id="adduser_lastname" name="lastname" placeholder="Lastname" value="">
                                        </div>
                                </div>

                                <div class="control-group">
                                        <label for="admin_user_add_email" class="control-label">Email </label>
                                        <div class="controls">
                                                <input type="text" class="input-xlarge" id="adduser_email" name="email" value="">
                                        </div>
                                </div>
                                    
                                    <div class="control-group">
                                        <label for="admin_user_add_phone" class="control-label">Phone </label>
                                        <div class="controls">
                                                <input type="text" class="input-xlarge" id="adduser_phone" name="phone" value="">
                                        </div>
                                </div>

                                <?smarty if $smarty.const.SHOW_USERNAME_IN_USER_FRM ?>
                                <div class="control-group">
                                        <label for="admin_user_add_username" class="control-label">Username </label>
                                        <div class="controls">
                                                <input type="text" autocomplete="off" class="input-xlarge" id="adduser_username" name="username" value="">
                                        </div>
                                </div>
                                <?smarty /if ?>

                                    <?smarty if !$is_super_admin ?>
                                        <?smarty if $smarty.const.SHOW_CHECKBOX_COPY_TO_ADMIN ?>
                                        <div class="control-group">
                                            <label id="adduser_copy_to_admin_label_id" class="control-label">Copy to admin </label>
                                            <div class="controls">
                                                <span style="position: relative;top: 5px;">
                                                    <input type="checkbox" id="adduser_copy_to_admin" name="copy_to_admin" style="width:0;" />
                                                </span>
                                            </div>
                                        </div>
                                        <?smarty /if ?>
                                    <?smarty /if ?>

                                    <?smarty if $smarty.const.SEND_ACTIVATION_MAIL ?>
                                            <p style="font-style:italic;color:#AFAFAF;font-size:0.9em;" id="adduser_activationlink_text">The user can activate with the activation link included in the email.</p>
                                    <?smarty else ?>
                                            <p style="font-style:italic;color:#AFAFAF;font-size:0.9em;" id="adduser_password_text">A password will be generated and included in the email.</p>
                                    <?smarty /if ?>

                                    <div class="form-actions">
                                            <button class="btn btn-primary save" name="save-add-user" type="submit">Save user</button>
                                    </div>
                            </form>
                    </div>

                    <?smarty elseif $active == 'quick_new_user' ?>
                                    <div id="admin-user-quick-add-user" style="padding-top:20px;padding-left:20px;">
                                            <?smarty if isset($error) ?>
                                                    <div style="position:absolute;left:400px;top:80px;color:red;font-weight:bold;">
                                                            <?smarty $error ?>
                                                    </div>
                                            <?smarty /if ?>

                                            <legend id="quick_add_user_label">Quick add <?smarty if $is_super_admin ?>admin<?smarty else ?>user<?smarty /if ?></legend>
                                <p style="font-size:14px;padding-bottom:10px;color:#AFAFAF;">With this form you can quickly add <?smarty if $is_super_admin ?> an admin<?smarty else ?>a user<?smarty /if ?><br />No email is send to the user and the admin sets the password.<br /><span style="font-style:italic;">Title, first name and prefix are optional.</span></p>
                                
                                <form action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=quick_add_<?smarty if $is_super_admin ?>admin<?smarty else ?>user<?smarty /if ?>" method="POST" class="form-horizontal">
                                    <div class="control-group">
                                            <label for="admin_user_add_title" class="control-label admin_user_profile_title_label">Title </label>
                                            <div class="controls">
                                                    <input type="text" class="input-xlarge admin_user_profile_title_label" id="adduser_title" name="title" value="<?smarty $values.title ?>">
                                            </div>
                                    </div>
                                    <div class="control-group">
                                        <label for="admin_user_add_name" class="control-label admin_user_profile_name_label">Name </label>
                                        <div class="controls">
                                            <input style="width:94px;" type="text" class="input-xlarge" id="adduser_firstname" name="firstname" placeholder="First name" value="<?smarty $values.firstname ?>">
                                                    <?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>
                                                            <input style="width:30px;" type="text" class="input-xlarge" id="adduser_infix" name="infix" value="<?smarty $values.infix ?>">
                                                    <?smarty /if ?>
                                                    <input style="width:<?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>110<?smarty else ?>152<?smarty /if ?>px;" type="text" class="input-xlarge" id="adduser_lastname" name="lastname" placeholder="Last name" value="<?smarty $values.lastname ?>">
                                            </div>
                                    </div>

                                    <div class="control-group">
                                            <label for="admin_user_add_email" class="control-label admin_user_profile_email_label">Email </label>
                                            <div class="controls">
                                                    <input type="text" class="input-xlarge admin_user_profile_email_label" id="adduser_email" name="email" value="<?smarty $values.email ?>">
                                            </div>
                                    </div>
                                    <div class="control-group">
                                            <label for="admin_user_add_phone" class="control-label admin_user_profile_phone_label">Phone </label>
                                            <div class="controls">
                                                    <input type="text" class="input-xlarge admin_user_profile_phone_label" id="adduser_phone" name="phone" value="<?smarty $values.phone ?>">
                                            </div>
                                    </div>
                                    
                                    <div class="control-group">
                                            <label for="admin_user_add_username" class="control-label admin_user_profile_username_label">Username </label>
                                            <div class="controls">
                                                    <input type="text" autocomplete="off" class="input-xlarge" id="adduser_username" name="username" value="<?smarty $values.username ?>">
                                            </div>
                                    </div>
                                    <div class="control-group">
                                            <label for="admin_user_add_password" class="control-label admin_user_profile_password_label">Password </label>
                                            <div class="controls">
                                                    <input type="password" autocomplete="off" class="input-xlarge" id="adduser_username" name="password" value="">
                                            </div>
                                    </div>

                                    <div class="form-actions">
                                            <button class="btn btn-primary save" name="save-quick-add-user" type="submit">Save user</button>
                                    </div>
                            </form>
			</div>

					<?smarty elseif $active == 'calendars' ?>
							<div id="admin-calendars"  style="padding-top:20px;padding-left:20px;">
								<?smarty if !empty($error) ?>
								<div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
									<?smarty $error ?>
								</div>
								<?smarty /if ?>

								<?smarty if !empty($msg) ?>
								<div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
									<?smarty $msg ?>
								</div>
								<?smarty /if ?>

								<?smarty if !$is_super_admin ?>
								<form id="calendars-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars/?action=new_calendar" method="post" class="form-horizontal">
									<?smarty if isset($smarty.session.add_calendar_error) ?>
									<div style="position:absolute;left:400px;color:red;font-weight:bold;">
										<?smarty $smarty.session.add_calendar_error ?>
									</div>
									<?smarty /if ?>

									<div style="float:right;">
                                                                            <button id="add-calendar-btn" class="btn btn-primary save" name="add-calendar" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Add calendar</button>
									</div>
 								</form>
								<?smarty /if ?>
								
								<legend class="<?smarty if $is_super_admin ?>admin_calendars_menu<?smarty elseif $is_admin ?>admin_my_calendars_menu<?smarty /if ?>">Calendars</legend>

								<div id="calendar_list">
									<table class="table table-striped" style="font-size:14px;">
										<thead>
											<tr>
												<th colspan="5"></th>
												<th style="text-align:center;" colspan="4">Others/Group can</th>
												<th colspan="2"></th>
											</tr>
										</thead>
                                        <thead>
                                                <tr>
                                                        <th class="not_print" style="border-top:0 none;"></th>
                                                        <th style="border-top:0 none;"><span class="name_label">Name</span></th>
                                                        <th style="border-top:0 none;"><span class="origin_label">Origin</span></th>
                                                        <!--<?smarty if !$is_super_admin ?><th style="border-top:0 none;"><span class="canseedditems_label">Can see DD-items</span></th><?smarty /if ?>-->
                                                        <th style="border-top:0 none;"><span class="type_label">Type</span></th>
                                                        <th style="text-align:center;border-top:0 none;width:45px;"><span class="view_label">Public view</span></th>
                                                        <th style="text-align:center;border-top:1px dotted lightgray;width:45px;"><span class="add_label">Add</span></th>
                                                        <th style="text-align:center;border-top:1px dotted lightgray;width:45px;"><span class="edit_label">Edit</span></th>
                                                        <th style="text-align:center;border-top:1px dotted lightgray;width:45px;"><span class="delete_label">Delete</span></th>
                                                        <th style="text-align:center;border-top:1px dotted lightgray;width:45px;"><span class="changecolor_label">Change color</span></th>
                                                        <th style="text-align:center;border-top:0 none;"><span class="initialshow_label">Initial show</span></th>
                                                        <th style="text-align:center;border-top:0 none;"><span class="active_label">Active</span></th>
                                                        <?smarty if $is_super_admin ?><th style="border-top:0 none;"><span class="owner_label">Owner</span></th><?smarty /if ?>

                                                </tr>
                                        </thead>
                                        <tbody>

                                        <?smarty foreach from=$calendars item=item name=calendars ?>

                                                <tr>
                                                        <td style="border: 14px solid white;width:1px;background-color:<?smarty $item.calendar_color ?>;"></td>
                                                        <td><?smarty $item.name ?></a> <?smarty if $item.superadmin ?><span class="label label-important">superadmin</span><?smarty elseif $item.admin ?><span class="label label-important">admin</span><?smarty /if ?></td>
                                                        <td><?smarty $item.origin ?></td>
                                                        <!--<?smarty if !$is_super_admin ?><td><?smarty if $item.can_dd_drag == "only_owner" ?>Only owner<?smarty elseif $item.can_dd_drag == "only_loggedin_users" ?>Only loggedin users<?smarty else ?>Everyone<?smarty /if ?></td><?smarty /if ?>-->
                                                        <td><?smarty if $item.share_type == "private_group" ?>Private (group)<?smarty elseif $item.share_type == "private" ?>Private<?smarty else ?><?smarty $item.share_type ?><?smarty /if ?></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.can_view ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.can_add ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.can_edit ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.can_delete ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.can_change_color ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.initial_show ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <td style="text-align:center;"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/<?smarty if $item.active == 'yes' ?>checked.png<?smarty else ?>unchecked.png<?smarty /if ?>" /></td>
                                                        <?smarty if $is_super_admin ?><td><?smarty $item.fullname ?></td><?smarty /if ?>
                                                        <?smarty if !$smarty.foreach.calendars.first ?><td class="not_print" style="border-left:1px solid #DDDDDD;width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars/?action=up&ids=<?smarty $cal_ids ?>&cid=<?smarty $item.calendar_id ?>"><img width="14" src="<?smarty $smarty.const.FULLCAL_URL ?>/images/glyphicons/glyphicons-214-up-arrow.png" /></a></td>
                                                        <?smarty else ?><td class="not_print" style="border-left:1px solid #DDDDDD;width:10px;">&nbsp;</td><?smarty /if ?>

                                                        <?smarty if $smarty.foreach.calendars.last ?><td class="not_print" style="width:10px;">&nbsp;</td>
                                                        <?smarty else ?>
                                                        <td class="not_print" style="width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars/?action=down&ids=<?smarty $cal_ids ?>&cid=<?smarty $item.calendar_id ?>"><img width="14" src="<?smarty $smarty.const.FULLCAL_URL ?>/images/glyphicons/glyphicons-213-down-arrow.png" /></a></td>
                                                        <?smarty /if ?>
                                                        <?smarty if $item.deleted == 0 ?>
                                                        <td class="not_print" style="border-left:1px solid #DDDDDD;width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?action=get_calendar&cid=<?smarty $item.calendar_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/edit.png" /></a></td>
                                                            <?smarty if $user_id == $item.creator_id ?><td class="not_print" style="width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?action=delete&cid=<?smarty $item.calendar_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/delete.png" /></a></td><?smarty /if ?>
                                                        <?smarty else ?>
                                                            <?smarty if $user_id == $item.creator_id ?><td class="not_print" style="width:10px;"><a class="undo_delete_btn" href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?action=undelete&cid=<?smarty $item.calendar_id ?>">Undo delete</a></td><?smarty /if ?>

                                                        <?smarty /if ?>
                                                    </tr>
                                                            <?smarty /foreach ?>

                                                            </tbody>
                                                    </table>
                                    <?smarty if $cnt_deleted_calendars > 0 && $smarty.get.action != 'get_deleted' ?>
                                    <div style="float:right;padding-top:20px;">
                                        <a id="deleted_cals_btn" href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?action=get_deleted">Deleted calendars</a>
                                    </div>
                                    <?smarty /if ?>
                                    
								<!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


							</div>

					
                                    <?smarty elseif $active == 'profile' ?>
					<div class="left-tabs clearfix">
                                                <ul class="nav nav-tabs">
                                                    <li <?smarty if $subactive == 'profile' ?>class="active"<?smarty else ?><?smarty /if ?>><a data-toggle="tab" href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=get_profile&uid=<?smarty $profile.user_id ?>"><span class="menu_profile">Profile</span></a></li>
                                                    <li <?smarty if $subactive == 'availibility' ?>class="active"<?smarty else ?><?smarty /if ?>><a data-toggle="tab" href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?action=get_availibility&uid=<?smarty $profile.user_id ?>"><span class="availability_label">Availability</span></a></li>
                                                </ul>

                                        </div>	
                                        <div class="tab_content">
                                        <?smarty if $subactive == 'profile' ?>
                                            <div id="admin-user-profile" class="tab-pane <?smarty if $subactive == 'profile' ?>active<?smarty /if ?>" style="padding-top:20px;padding-left:20px;">
                                            <?smarty if !empty($save_profile_error) ?>
                                            <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                                    <?smarty $save_profile_error ?>
                                            </div>
                                            <?smarty /if ?>

                                            <?smarty if !empty($save_profile_success) ?>
                                            <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                                    <?smarty $save_profile_success ?>
                                            </div>
                                            <?smarty /if ?>


                                            <form action="<?smarty $smarty.const.FULLCAL_URL ?><?smarty if $is_user ?>/user<?smarty else ?>/admin/users<?smarty /if ?>/?action=save_profile" method="post" class="form-horizontal">
                                
                                                <div class="control-group" <?smarty if $is_super_admin ?>style="display:none;"<?smarty /if ?> >
                                                        <label for="admin_profile_useractive" class="control-label" id="admin_profile_user_active_label"> Active </label>
                                                        <div class="controls">
                                                                <input type="checkbox" id="admin_profile_user_active" name="active" <?smarty if $profile.active ?>checked="true"<?smarty /if ?> />
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_title" class="control-label admin_user_profile_title_label">Title </label>
                                                        <div class="controls">
                                                                <input type="text" class="input-xlarge" id="profile_title" name="title" value="<?smarty $profile.title ?>">
                                                        </div>
                                                </div>
                                                <div class="control-group">
                                                        <label for="admin_user_profile_name" class="control-label admin_user_profile_name_label">Name </label>
                                                        <div class="controls">
                                                                <input style="width:94px;" type="text" class="input-xlarge" id="profile_firstname" name="firstname" placeholder="Firstname" value="<?smarty $profile.firstname ?>">
                                                                <?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>
                                                                        <input style="width:30px;" type="text" class="input-xlarge" id="profile_infix" name="infix" value="<?smarty $profile.infix ?>">
                                                                <?smarty /if ?>
                                                                <input style="width:<?smarty if $smarty.const.SHOW_INFIX_IN_USER_FRM ?>110<?smarty else ?>152<?smarty /if ?>px;" type="text" class="input-xlarge" id="profile_lastname" name="lastname" placeholder="Lastname" value="<?smarty $profile.lastname ?>">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_birthdate" class="control-label admin_user_profile_birthdate_label">Birthdate </label>
                                                        <div class="controls">
                                                        <?smarty if $smarty.const.DATEPICKER_DATEFORMAT == 'dd/mm/yy' ?>
                                                                <input style="width:25px;" type="text" placeholder="DD" class="input-xlarge" id="profile_birthdate_day" name="birthdate_day" value="<?smarty $profile.birthdate_day ?>">
                                                                <input style="width:25px;" type="text" placeholder="MM" class="input-xlarge" id="profile_birthdate_month" name="birthdate_month" value="<?smarty $profile.birthdate_month ?>">

                                                        <?smarty else ?>
                                                                <input style="width:25px;" type="text" placeholder="MM" class="input-xlarge" id="profile_birthdate_month" name="birthdate_month" value="<?smarty $profile.birthdate_month ?>">
                                                                <input style="width:25px;" type="text" placeholder="DD" class="input-xlarge" id="profile_birthdate_day" name="birthdate_day" value="<?smarty $profile.birthdate_day ?>">

                                                        <?smarty /if ?>
                                                        <input style="width:45px;" type="text" placeholder="YYYY" class="input-xlarge" id="profile_birthdate_year" name="birthdate_year" value="<?smarty $profile.birthdate_year ?>">

                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_country" class="control-label" id="admin_user_profile_country_label">Country </label>
                                                        <div class="controls">
                                                                <input type="text" class="input-xlarge" id="profile_country" name="country" value="<?smarty $profile.country ?>">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_email" class="control-label admin_user_profile_email_label" >Email </label>
                                                        <div class="controls">
                                                                <input type="text" class="input-xlarge" id="profile_email" name="email" value="<?smarty $profile.email ?>">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_phone" class="control-label admin_user_profile_phone_label">Phone </label>
                                                        <div class="controls">
                                                                <input type="text" class="input-xlarge" class="phone_label" name="phone" value="<?smarty $profile.phone ?>">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_username" class="control-label admin_user_profile_username_label">Username </label>
                                                        <div class="controls">
                                                                <input type="text" class="input-xlarge" id="profile_username" name="username" value="<?smarty $profile.username ?>">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_password" class="control-label admin_user_profile_new_password_label">New password </label>
                                                        <div class="controls">
                                                                <input type="password" autocomplete="off" class="input-xlarge" id="profile_password" name="password" placeholder="Leave blank for no change">
                                                        </div>
                                                </div>

                                                <div class="control-group">
                                                        <label for="admin_user_profile_new_password" class="control-label admin_user_profile_new_password2_label">New password again </label>
                                                        <div class="controls">
                                                                <input type="password" autocomplete="off" class="input-xlarge" id="profile_confirm" name="confirm" placeholder="Leave blank for no change">
                                                        </div>
                                                </div>
                                
                                <div class="control-group">
									<label for="admin_user_profile_user_info" class="control-label" id="admin_user_profile_info_label">Info </label>
									<div class="controls">
                                        <textarea autocomplete="off" style="height:100px;" class="input-xlarge" id="profile_user_info" name="user_info"><?smarty $profile.user_info ?></textarea>
									</div>
								</div>
                                
                                                 <div class="control-group">
                                                                <label for="admin_user_color_active" class="control-label"><span class="color_label">Color</span> </label>
                                                                <div class="controls"  style="padding-top:5px;">
                                                        <span>
                                                            <input type="radio" value="yes" name="coloractive"  style="float:left;margin-right:5px;" id="admin_user_color_active_yes" <?smarty if isset($profile.user_color) && !empty($profile.user_color) ?>checked="true"<?smarty /if ?> /><label for="admin_user_color_active_yes" style="padding-top:1px;width: 50px;float:left;padding-right:20px;"><span id="yes_label">Yes</span> </label>
                                                            <input type="radio" value="no" name="coloractive"  style="float:left;margin-right:5px;" <?smarty if !isset($profile.user_color) || empty($profile.user_color) || $profile.user_color == null ?>checked="true"<?smarty /if ?> /><label for="admin_user_color_active_no" style="padding-top:1px;width: 50px;float:left;padding-right:20px;"><span id="no_label">No</span> </label>
                                                            
                                                                                            </span>
                                                    </div>
                                                </div>
                                                
                                                <div class="control-group" id="user_color_field" <?smarty if empty($profile.user_color) ?>style="display:none;"<?smarty /if ?>>
                                                
                                                        <div class="controls" style="width:150px;">
                                                                <input type="text" class="input-xlarge" id="admin-spectrum-user-colorpicker" name="user_color" value="<?smarty $profile.user_color ?>">
                                                        </div>
                                                </div>
                                                
                                                <input type="hidden" name="user_id" value="<?smarty $profile.user_id ?>" />
                                                        <div class="form-actions">
                                                                <button id="save-profile" class="btn btn-primary save" name="save-profile" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Save changes</button>
                                                        </div>

						</form>


							</div>
                                        <?smarty /if ?>      
                                        <?smarty if $subactive == 'availibility' ?>
                                        <div id="admin-user-availibility" style="padding-top:20px;padding-left:20px;">
                                             <div id="admin-availibility-rows"  style="padding-top:20px;padding-left:20px;">
                                                <?smarty if !empty($error) ?>
                                                <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                                        <?smarty $error ?>
                                                </div>
                                                <?smarty /if ?>

                                                <?smarty if !empty($msg) ?>
                                                <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                                        <?smarty $msg ?>
                                                </div>
                                                <?smarty /if ?>

                                                <form style="float:right;" id="settings-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/availability/?action=new" method="post" class="form-horizontal">
                                                    <?smarty if isset($smarty.session.add_user_error) ?>
                                                    <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                                        <?smarty $smarty.session.add_user_error ?>
                                                    </div>
                                                    <?smarty /if ?>

                                                    <div>
                                                        <button id="add-availability-btn" class="btn btn-primary save" name="add-group" data-complete-text="Changes saved" data-loading-text="saving..." type="submit">Add availability</button>
                                                    </div>
                                                </form>


                                                <legend><span class="groups_label">Availability</span></legend>

                                                <div id="user_availability">
                                                        <table class="table table-striped" style="font-size:14px;">
                                                                <thead>
                                                                        <tr>
                                                                                <th><span class="name_label">Info</span></th>
                                                                                <th><span class="startdate_label">Start date</span></th>
                                                                                <th><span class="enddate_label">End date</span></th>
                                                                                
                                                                        </tr>
                                                                </thead>
                                                                <tbody>

                                                                <?smarty foreach from=$groups item=item ?>

                                                                        <tr>
                                                                                <td><?smarty $item.name ?></td>
                                                                                <td><?smarty $item.cnt_users ?></td>
                                                                                <td><?smarty $item.cnt_users ?></td>
                                                                                
                                                                                <td class="not_print" style="width:10px;border-left:1px solid #DDDDDD;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups?action=get_group&gid=<?smarty $item.group_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/edit.png" /></a></td>
                                                                                <td class="not_print" style="width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/groups?action=delete&gid=<?smarty $item.group_id ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/delete.png" /></a></td>
                                                                        </tr>
                                                                <?smarty /foreach ?>

                                                                </tbody>
                                                        </table>

                                                                            <!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/users?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


                                                    </div>
                                            </div>
                                        </div>
                                        <?smarty /if ?>
                                      
                                    </div><!-- EO tab-content -->
                                    
                                    <?smarty elseif $active == 'availability' ?>
                                    <div id="admin-user-calendar" style="padding-top:20px;padding-left:20px;">
                                        <legend>(UNDER CONSTRUCTION)<?smarty if isset($smarty.get.action) && $smarty.get.action == 'new' ?><span id="add_availability_label">Add availability</span><?smarty else ?><span id="edit_availability_label">Edit availability</span>: <strong><?smarty $availability.name ?></strong><?smarty /if ?></legend>

                                        <?smarty if !empty($save_calendar_error) ?>
                                        <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                                <?smarty $save_calendar_error ?>
                                        </div>
                                        <?smarty /if ?>

                                        <?smarty if !empty($save_calendar_success) ?>
                                        <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                                <?smarty $save_calendar_success ?>
                                        </div>
                                        <?smarty /if ?>
                                        
                                        <form id="availability_save_form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/availability/?action=save_availability" method="post" class="form-horizontal">

                                            <div class="control-group">
                                            <span id="month_label_id" style="padding-left:30px;margin-bottom: 0;">Info: </span>
                                                <input type="text" name="info" style="font-size:13px;margin-bottom: 0;width: 300px;padding:3px;z-index:9999;">
                                            <span id="month_label_id" style="padding-left:30px;margin-bottom: 0;">From: </span>
                                                <input type="text" name="startdate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;z-index:9999;">
                                            <span id="time_label_id">To: </span>
                                                <input type="text" name="enddate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;" />
                                            </div>
                                        <hr />
                                       
                                           
                                            <!--<div class="control-group">
                                                <label class="control-label"><span id="availability_tuesday_label">Tuesday</span> </label>
                                                <div class="controls">
                                                    <span>
                                                        <input type="text" class="input-xlarge" id="admin_calendar_admin_email" name="calendar_admin_email" value="<?smarty $calendar.calendar_admin_email ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;">
                                                        <input type="text" class="input-xlarge" id="admin_monday_enddate" name="calendar_admin_email" value="<?smarty $calendar.calendar_admin_email ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;">
                                                    </span>
                                                    <span style="padding-left:40px;">
                                                        <input type="text" class="input-xlarge" id="admin_calendar_admin_email" name="calendar_admin_email" value="<?smarty $calendar.calendar_admin_email ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;">
                                                        <input type="text" class="input-xlarge" id="admin_monday_enddate" name="calendar_admin_email" value="<?smarty $calendar.calendar_admin_email ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;">
                                                
                                                    </span>
                                                </div>
                                            </div>
                                            -->
                                        <div class="control-group">
                                            <label class="control-label"><span id="availability_monday_label">Monday</span> </label>
                                            <div class="controls">
                                                <div id="time-range-1">
                                                    <div class="slider-1" style="width:70%;float:left;">
                                                        <div class="slider-range1" data-nr="m1" data-st="540" data-e="1020"></div>
                                                        <div class="slider-range2" data-nr="m2" style="display:none;" data-st="1080" data-e="1380"></div>
                                                    </div>
                                                    <div style="float:right;padding-top:5px;"><span id="slider-1-1"></span> - <span id="slider-1-2"></span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><span id="availability_tuesday_label">Tuesday</span> </label>
                                            <div class="controls">
                                                <div id="time-range-2">
                                                    <div class="slider-2" style="width:70%;float:left;">
                                                        <div class="slider-range1" data-nr="t1" data-st="540" data-e="1020"></div>
                                                        <div class="slider-range2" data-nr="t2" style="display:none;" data-st="1080" data-e="1380"></div>
                                                    </div>
                                                    <div style="float:right;padding-top:5px;"><span id="slider-2-1"></span> - <span id="slider-2-2"></span></div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                            <input type="hidden" id="slider-1-time-1" name="slider-1-time-1" value="<?smarty $availability.slider-1-time-1 ?>" />
                                            <input type="hidden" id="slider-1-time-2" name="slider-1-time-2" value="<?smarty $availability.slider-1-time-2 ?>" />
                                            <input type="hidden" id="slider-2-time-1" name="slider-2-time-1" value="<?smarty $availability.slider-2-time-1 ?>" />
                                            <input type="hidden" id="slider-2-time-2" name="slider-2-time-2" value="<?smarty $availability.slider-2-time-2 ?>" />
                                            
                                            <input type="hidden" name="availability_id" value="<?smarty $availability.availability_id ?>" />
                                            <div class="form-actions">
                                                    <button id="save-availability" class="btn btn-primary save" name="save-availability" data-complete-text="Changes saved" data-loading-text="saving..." >Save changes</button>
                                            </div>

                                        </form>
                                        
                                    </div>
                                    
                                    <?smarty elseif $active == 'calendar' ?>
                                            <div id="admin-user-calendar" style="padding-top:20px;padding-left:20px;">
                            <legend><?smarty if isset($smarty.get.action) && $smarty.get.action == 'new_calendar' ?><span id="add_calendar_label">Add calendar</span><?smarty else ?><span id="edit_calendar_label">Edit calendar</span>: <strong><?smarty $calendar.name ?></strong><?smarty /if ?></legend>

                            <?smarty if !empty($save_calendar_error) ?>
                            <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                    <?smarty $save_calendar_error ?>
                            </div>
                            <?smarty /if ?>

                            <?smarty if !empty($save_calendar_success) ?>
                            <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                    <?smarty $save_calendar_success ?>
                            </div>
                            <?smarty /if ?>

                            <form id="calendar_save_form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars/?action=save_calendar" method="post" class="form-horizontal">

                                <div class="control-group">
                                    <label for="admin_user_calendar_name" class="control-label"><span class="name_label">Name</span> </label>
                                            <div class="controls">
                                                    <input type="text" class="input-xlarge" id="calendar_name" name="name" placeholder="Name" value="<?smarty $calendar.name ?>">
                                            </div>
                                    </div>
                                                            
                                    <div class="control-group">
                                                <label for="admin_user_calendar_active" class="control-label"><span id="active_label">Active</span> </label>
                                                <div class="controls"  style="padding-top:5px;">
                                        <span>
                                            <input type="radio" value="yes" name="active"  style="float:left;margin-right:5px;" id="admin_calendar_active_yes" <?smarty if $calendar.active == 'yes' || !isset($calendar.active) || empty($calendar.active) ?>checked="true"<?smarty /if ?> /><label for="admin_calendar_active_yes" style="padding-top:1px;width: 50px;float:left;padding-right:20px;"><span id="yes_label">Yes</span> </label>
                                            <input type="radio" value="no" name="active"  style="float:left;margin-right:5px;" <?smarty if $calendar.active == 'no' ?>checked="true"<?smarty /if ?> /><label for="admin_calendar_active_yes" style="padding-top:1px;width: 50px;float:left;padding-right:20px;"><span id="no_label">No</span> </label>
                                            <input type="radio" value="period" id="radio_specific_period" name="active"  style="float:left;margin-right:5px;" <?smarty if $calendar.active == 'period' ?>checked="true"<?smarty /if ?> /><label for="admin_calendar_active_yes" style="padding-top:1px;width: 200px;float:left;padding-right:20px;"><span id="in_specific_period_label">In specific period</span> </label>
									    </span>
                                    </div>
				</div>
                               
                                <!-- active period -->
                                <div class="control-group">
                                    <label for="admin_calendar_active" class="control-label"><span id="active_period_label">Active period</span> </label>
									<span class="simple_starttime_label" style="padding-left:20px;margin-bottom: 0;">From: </span>
                                    <input type="text" name="cal_startdate" id="active_period_datepicker_startdate" value="<?smarty $calendar.cal_startdate ?>" <?smarty if $calendar.active != 'period' ?>disabled="disabled"<?smarty /if ?> style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;z-index:9999;">
                                    <span class="simple_endtime_label">Until: </span>
                                        <input type="text" name="cal_enddate" id="active_period_datepicker_enddate" value="<?smarty $calendar.cal_enddate ?>" <?smarty if $calendar.active != 'period' ?>disabled="disabled"<?smarty /if ?> style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;" />
                                </div>
                                
                                <!-- alterable period restriction -->
                                <div class="control-group">
                                    <label for="admin_calendar_alterable" class="control-label"><span id="alterable_period_label">Alterable period</span> </label>
									<span class="simple_starttime_label" style="padding-left:20px;margin-bottom: 0;">From: </span>
                                        <input type="text" name="alterable_startdate" id="alterable_period_datepicker_startdate" value="<?smarty $calendar.alterable_startdate ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;z-index:9999;">
                                    <span class="simple_endtime_label">To: </span>
                                        <input type="text" name="alterable_enddate" id="alterable_period_datepicker_enddate" value="<?smarty $calendar.alterable_enddate ?>" style="font-size:13px;margin-bottom: 0;width: 95px;padding:3px;" />
                                </div>
                                        
				<div class="control-group">
                                    <label for="admin_user_calendar_next_days_visible" class="control-label"><span class="next_days_visible_label">Users can see next</span> </label>
                                    <div class="controls">
                                            <input type="text" style="width:50px;" class="input-xlarge" id="calendar_next_days_visible" name="next_days_visible" value="<?smarty $calendar.next_days_visible ?>"> days
                                    </div>
                                </div>				

								<!--<div class="control-group">
									<label for="admin_user_calendar_share_type" class="control-label">Type </label>
									<div class="controls">
										<input type="text" class="input-xlarge" id="calendar_type" name="country" value="<?smarty $calendar.share_type ?>">
									</div>
								</div>-->
                                <hr />
                                <h4 style="padding: 10px 0 10px 180px;font-weight:bold;">
                                    <span id="">Usergroup Drag & drop items</span>
                                </h4>
                                <h5 id="usergroup_dditems_info">When 'assign to users' is on and dragging onto the calendar, the hours are counted in the hour-calculation</h5>
                                <div class="control-group">
                                        <label for="admin_usergroup_dditems" class="control-label" id="admin_usergroup_dditems_label">User-group DD-items </label>
						<div class="controls">
					<select name="dditems_usergroup_id" id="admin_dditems_usergroups">
                                            <option value="0" <?smarty if $calendar.dditems_usergroup_id == 0 ?>selected="selected"<?smarty /if ?>>none</option>
                                            <?smarty foreach from=$my_groups item=item ?>
                                            <option value="<?smarty $item.group_id ?>" <?smarty if $calendar.dditems_usergroup_id == $item.group_id ?>selected="selected"<?smarty /if ?>><?smarty $item.name ?></option>
                                            <?smarty /foreach ?>
                                        </select>
                                        <?smarty if $my_groups|@count == 0 ?>
                                            No active groups found
                                        <?smarty /if ?>
									</div>
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
					<label id="" class="control-label"></label>
						<input type="checkbox" name="assign_dditem_to_user" <?smarty if $calendar.assign_dditem_to_user == 1 ?>checked="checked" <?smarty /if ?> />
						<span id="assign_to_users_label" style="padding-top:5px;vertical-align:middle;">Assign to users</span>
                                    </div>
				</div>
                                <div class="control-group">
					<label for="admin_usergroup_dditems_viewtype" class="control-label" id="admin_usergroup_dditems_viewtype_label">How to show DD-items </label>
					<div class="controls">
										<!--  -->
						<select name="usergroup_dditems_viewtype">
							<option value="dropdown" <?smarty if $calendar.usergroup_dditems_viewtype == "dropdown" ?>selected="selected"<?smarty /if ?>>Dropdown list</option>
							<option value="buttons" <?smarty if !isset($calendar.usergroup_dditems_viewtype) || $calendar.usergroup_dditems_viewtype == "buttons" ?>selected="selected"<?smarty /if ?>>Show all DD-items</option>
						</select>
					</div>
				</div>
                                <hr>
                                <h4 style="padding: 10px 0 10px 180px;font-weight:bold;">
                                    <span id="">Custom Drag & drop items</span>
                                </h4>
                                <h5 id="custom_dditems_info">These items are not counted in the hour-calculation because there is no direct link with a user. You can assign to a user in the edit dialog afterwards or you can use the user-group DD-items above.</h5>
                                
				<div class="control-group" style="padding-top:10px;">
                                    <label for="admin_user_calendar_dditems" style="padding-top: 35px;" class="control-label"><span id="dd_items_label" >Custom DD-items</span> </label>
									<div class="controls">
										<!--<textarea class="input-xlarge" id="calendar_dditems" name="dditems" ><?smarty $calendar.dditems ?></textarea>-->
                                        <input type="hidden" id="calendar_dditems" name="dditems" value="<?smarty $str_dditems ?>" />
									
                                        <table class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="" colspan="2"><span></span></th>
                                                    <th style="text-align:center;border-bottom:1px dotted lightgray;" colspan="2"><span id="monthview_label">Monthview</span></th>
                                                    <th style=""><span></span></th>
                                                   
                                               </tr>
                                            </thead>
                                            <thead>
                                                <tr style="">
                                                    <th style="text-align:center;width:195px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span id="title_label">Title</span> *</th>
                                                    <th style="text-align:center;width:195px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span id="info_label">Info</span></th>
                                                    <th style="text-align:center;width:100px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span id="starttime_label">Start time</span></th>
                                                    <th style="text-align:center;width:100px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span id="endtime_label">End time</span></th>
                                                    <th style="text-align:center;width:100px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span id="nightshift_label">Night shift</span></th>
                                                    <th style="text-align:center;width:60px;border-top:0 none;padding:0;border-bottom:1px solid lightgray;"><span class="color_label">Color</span></th>
                                               </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty if !empty($calendar.dditems) ?>
                                                <?smarty foreach from=$calendar.dditems item=item ?>
                                                    <?smarty if !empty($item) ?>
                                                    <tr>
                                                        <td style="padding:1px;border:none;"><input type="text" style="width:150px;" name="title<?smarty $item.dditem_id ?>" value="<?smarty $item.title ?>" class="admin-dditem-title" id="admin-spectrum-colorpicker-dditem-title-<?smarty $item.dditem_id ?>" /></td>
                                                        <td style="padding:1px;border:none;"><input type="text" style="width:150px;" name="info<?smarty $item.dditem_id ?>" value="<?smarty $item.info ?>" class="admin-dditem-info" id="admin-dditem-info-<?smarty $item.dditem_id ?>" /></td>
                                                        <td style="padding:2px;border:none;"><input type="text" class="dditem_timepicker_starttime" id="dditem_timepicker_starttime-<?smarty $item.dditem_id ?>" name="starttime<?smarty $item.dditem_id ?>" value="" style="font-size:13px;width: 80px;"></td>
                                                        <td style="padding:2px;border:none;"><input type="text" class="dditem_timepicker_endtime" id="dditem_timepicker_endtime-<?smarty $item.dditem_id ?>" name="endtime<?smarty $item.dditem_id ?>" value="" style="font-size:13px;width: 80px;"></td>
                                                        <td style="padding:2px;border:none;"><input type="checkbox" class="admin_dditem_nightshift" id="admin-dditem-nightshift-<?smarty $item.dditem_id ?>" name="nightshift<?smarty $item.dditem_id ?>" <?smarty if $item.nightshift ?>checked="checked"<?smarty /if ?> style="font-size:13px;width: 80px;"></td>
                                                        <td style="padding:1px;border:none;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dditems" id="admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>" name="dditem_color[]" value="<?smarty $item.color ?>" data-title="<?smarty $item.title ?>" data-number="<?smarty $item.dditem_id ?>"></td>
                                                    </tr>
                                                    <?smarty /if ?>
                                                <?smarty /foreach ?>
                                            <?smarty /if ?>
                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dditem" style="margin-top:10px;" value="Add a DD-item" />
                                    </div>
								</div>
                                 <div class="control-group">
                                        <label for="admin_calendar_can_see_dditems" class="control-label" id="admin_can_see_dditems_label">Can see DD-items </label>
                                        <div class="controls">
                                                <!--  -->
                                                <select name="can_dd_drag">
                                                        <option value="only_owner" <?smarty if $calendar.can_dd_drag == "only_owner" ?>selected="selected"<?smarty /if ?>>Only calendar owner</option>
                                                        <option value="only_loggedin_users" <?smarty if $calendar.can_dd_drag == "only_loggedin_users" ?>selected="selected"<?smarty /if ?>>Only loggedin users</option>
                                                        <option value="everyone" <?smarty if $calendar.can_dd_drag == "everyone" ?>selected="selected"<?smarty /if ?>>Everyone</option>
                                                </select>
                                        </div>
                                </div>
   <hr />
                                <div class="control-group">
                                        <label for="admin_calendar_origin" class="control-label" id="admin_origin_label">Origin </label>
                                        <div class="controls">
                                                <!--  -->
                                                <select name="origin" id="admin_calendar_origin">
                                                        <option value="default" <?smarty if !isset($calendar.origin) || empty($calendar.origin) || $calendar.origin == "default" ?>selected="selected"<?smarty /if ?>>Default</option>
                                                        <option value="exchange" <?smarty if $calendar.origin == "exchange" ?>selected="selected"<?smarty /if ?>>Exchange</option>

                                                </select>
                                        </div>
                                </div>
                                <div class="control-group" id="exchange_username_field" style="padding-left: 130px;display:<?smarty if isset($calendar.origin) && !empty($calendar.origin) && $calendar.origin == "exchange" ?>block<?smarty else ?>none<?smarty /if ?>;">
									<div style="padding-left: 130px;padding-bottom:4px;font-style: italic;">mcrypt is used to save username and password in the database</div>
                                    <label for="admin_exchange_username" class="control-label">Username </label>
									<div class="controls">
										<input type="text" class="" id="exchange_username" name="exchange_username" value="<?smarty $calendar.exchange_username ?>">
                                    </div>
								</div>
                                <div class="control-group" id="exchange_password_field" style="padding-left: 130px;display:<?smarty if isset($calendar.origin) && !empty($calendar.origin) && $calendar.origin == "exchange" ?>block<?smarty else ?>none<?smarty /if ?>;">
									<label for="admin_exchange_password" class="control-label">Password </label>
									<div class="controls">
									    <input type="password" class="" id="exchange_password" name="exchange_password" value="<?smarty $calendar.exchange_password ?>">
                                    </div>
								</div>
                                <div class="control-group" id="admin_exchange_extra_secure" style="margin-bottom:1px;display:<?smarty if isset($calendar.origin) && !empty($calendar.origin) && $calendar.origin == "exchange" ?>block<?smarty else ?>none<?smarty /if ?>;">
									<div class="controls" style="margin-left:20px;padding-bottom:5px;">
										<label id="" class="control-label"></label>
                                        <input type="checkbox" id="exchange_extra_secure_checkbox" <?smarty if $calendar.exchange_extra_secure == 1 ?>checked="checked" <?smarty /if ?> name="exchange_extra_secure" />
										<span id="admin_exchange_extra_secure" style="padding-top:5px;vertical-align:middle;">Extra secure, user needs to know this token</span>
									</div>
								</div>
                                <div class="control-group" id="exchange_token_field" style="padding-left: 130px;display:<?smarty if isset($calendar.origin) && !empty($calendar.origin) && $calendar.origin == "exchange" ?>block<?smarty else ?>none<?smarty /if ?>;">
                                    <label for="admin_exchange_token" class="control-label">Secret token </label>
                                    <div class="controls">
                                        <input type="password" class="" id="exchange_token" name="exchange_token" value="<?smarty $calendar.exchange_token ?>" <?smarty if !$calendar.exchange_extra_secure == 1 ?>disabled="disabled" <?smarty /if ?>>
                                    </div>
								</div>
                                <div class="control-group">
                                        <label for="admin_calendar_share_type" class="control-label" id="admin_share_type_label">Share type </label>
                                        <div class="controls">
                                                <!--  -->
                                                <select name="share_type" id="admin_calendar_share_type">
                                                        <option value="public" <?smarty if $calendar.share_type == "public" ?>selected="selected"<?smarty /if ?>>Public</option>
                                                        <option value="private" <?smarty if $calendar.share_type == "private" ?>selected="selected"<?smarty /if ?>>Private (only for me)</option>
                                                        <option value="private_group" <?smarty if $calendar.share_type == "private_group" ?>selected="selected"<?smarty /if ?>>Private (only for group)</option>
                                                </select>
                                        </div>
                                </div>
                                <div class="control-group" id="admin_calendar_group_combo" style= "<?smarty if $calendar.share_type == 'private_group' ?>display:block;<?smarty else ?>display:none;<?smarty /if ?>">
                                    <label for="admin_calendar_admingroups" class="control-label" id="admin_admin_groups_label"> </label>
                                    <div class="controls">
                                            <!--  -->
                                            <select name="usergroup_id" id="admin_settings_usergroups">
                                                    <?smarty foreach from=$my_groups item=item ?>
                                            <option value="<?smarty $item.group_id ?>" <?smarty if $calendar.usergroup_id == $item.group_id ?>selected="selected"<?smarty /if ?>><?smarty $item.name ?></option>
                                            <?smarty /foreach ?>
                                        </select>
                                        <?smarty if $my_groups|@count == 0 ?>
                                            No active groups found
                                        <?smarty /if ?>
									</div>
                                </div>
				<div id="admin_others_can_view" class="control-group" style="margin:0;display: <?smarty if $calendar.share_type == 'private_group' ?>block<?smarty else ?>none<?smarty /if ?>;">
                                    <label for="admin_calendar_otherscanview" class="control-label" id="admin_calendar_can_view_label"><span class="others_label">Others</span> <span id="can_view_label">can view</span> </label>
                                            <div class="controls">
                                                    <input type="checkbox" id="admin_calendar_others_can_view" name="can_view" <?smarty if $calendar.can_view && $calendar.share_type == "private_group" ?>checked="true"<?smarty /if ?> />
                                            </div>
                                    </div>
                                    <div class="control-group" style="margin:0;">
                                    <label for="admin_calendar_canview_assigned" class="control-label" id="admin_calendar_can_view_own_assigned_label"> <span id="can_view_own_assigned_label">User can only see own assigned items</span> </label>
                                        <div class="controls">
                                                <input type="checkbox" id="admin_calendar_can_view_own_assigned" name="can_view_own_assigned" <?smarty if $calendar.can_view_own_assigned && $calendar.share_type != "private" ?>checked="true"<?smarty /if ?> <?smarty if $calendar.share_type == "private" ?>disabled="disabled"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div class="control-group" style="margin:0;">
                                    <label for="admin_calendar_canadd" class="control-label" id="admin_calendar_can_add_label"><?smarty if $calendar.share_type == "private_group" ?>Group<?smarty else ?><span class="others_label">Others</span><?smarty /if ?> <span id="can_add_label">can add</span> </label>
                                        <div class="controls">
                                                <input type="checkbox" id="admin_calendar_can_add" name="can_add" <?smarty if $calendar.can_add && $calendar.share_type != "private" ?>checked="true"<?smarty /if ?> <?smarty if $calendar.share_type == "private" ?>disabled="disabled"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div class="control-group" style="margin:0;">
                                    <label for="admin_calendar_canedit" class="control-label" id="admin_calendar_can_edit_label"><?smarty if $calendar.share_type == "private_group" ?>Group<?smarty else ?><span class="others_label">Others</span><?smarty /if ?> <span id="can_edit_label">can edit</span> </label>
                                            <div class="controls">
                                                    <input type="checkbox" id="admin_calendar_can_edit" name="can_edit" <?smarty if $calendar.can_edit && $calendar.share_type != "private" ?>checked="true"<?smarty /if ?> <?smarty if $calendar.share_type == "private" ?>disabled="disabled"<?smarty /if ?> />
                                            </div>
                                    </div>
                                <div class="control-group" style="margin:0;">
                                    <label for="admin_calendar_candelete" class="control-label" id="admin_calendar_can_delete_label"><?smarty if $calendar.share_type == "private_group" ?>Group<?smarty else ?><span class="others_label">Others</span><?smarty /if ?> <span id="can_delete_label">can delete</span> </label>
                                            <div class="controls">
                                                    <input type="checkbox" id="admin_calendar_can_delete" name="can_delete" <?smarty if $calendar.can_delete && $calendar.share_type != "private" ?>checked="true"<?smarty /if ?> <?smarty if $calendar.share_type == "private" ?>disabled="disabled"<?smarty /if ?> />
                                            </div>
                                    </div>
                                    <div class="control-group" style="margin:0;">
                                            <label for="admin_calendar_canchange_color" class="control-label" id="admin_calendar_can_change_color_label"><?smarty if $calendar.share_type == "private_group" ?>Group<?smarty else ?><span class="others_label">Others</span><?smarty /if ?> <span id="can_change_color_label">can change color</span> </label>
                                            <div class="controls">
                                                    <input type="checkbox" id="admin_calendar_can_change_color" name="can_change_color" <?smarty if $calendar.can_change_color && $calendar.share_type != "private" ?>checked="true"<?smarty /if ?> <?smarty if $calendar.share_type == "private" ?>disabled="disabled"<?smarty /if ?> />
                                            </div>
                                    </div>
                                    <div class="control-group" style="margin:0;">
                                    <label for="admin_calendar_default" class="control-label"><span id="admin_default_calendar_label">Default calendar</span></label>
                                    <div class="controls">
                                            <input type="checkbox" name="initial_show" <?smarty if $calendar.initial_show ?>checked="true"<?smarty /if ?> />
									    
                                    </div>
								</div>
                               

				<div class="control-group">
                                    <label for="admin_calendar_color" class="control-label"><span class="backgroundcolor_label">Background-color</span> </label>
                                            <div class="controls" style="width:150px;">
                                                    <input type="text" class="input-xlarge" id="admin-spectrum-colorpicker" name="calendar_color" value="<?smarty $calendar.calendar_color ?>">
                                            </div>
                                    </div>
                                
   
                                    <div class="control-group" id="color_change_all_events" style="margin-bottom:1px;">
                                            <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                    <label id="" class="control-label"></label>
                                                    <input type="checkbox" name="checkbox_use_color_for_all_events" />
                                                    <span id="use_color_for_all_events_label" style="padding-top:5px;vertical-align:middle;">Use current background-color for all the events of this calendar</span>
                                            </div>
                                    </div>
   
                                    <div class="control-group">
                                    <label for="admin_calendar_textcolor" class="control-label"><span class="textcolor_label">Text-color</span> </label>
                                            <div class="controls" style="width:150px;">
                                                    <input type="text" class="input-xlarge" id="calendar-textcolor-colorpicker" name="calendar_textcolor" value="<?smarty $calendar.calendar_textcolor ?>">
                                            </div>
                                    </div>
                                <hr />
                                <h4 style="padding: 10px 0 10px 180px;font-weight:bold;">
                                    <span id="">Edit-dialog fields</span>
                                </h4>
                                <div class="control-group" style="margin:0;">
                                    <div style="float:left;">
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_description_in_edit_dialog_checkbox_label">Show description field</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="show_description_field" <?smarty if $calendar.show_description_field ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div>
                                        <label class="control-label" style="padding-top:1px;width:130px;padding-right: 20px;">
                                        <span id="admin_description_field_required_checkbox_label">Required</span>
                                        </label>
                                        <div class="controls" style="margin-left:400px;">
                                            <input type="checkbox" name="description_field_required" <?smarty if $calendar.description_field_required ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;">
                                        <label class="control-label" style="padding-top:0;">
                                            <span id="admin_show_location_in_edit_dialog_checkbox_label">Show location field</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="show_location_field" <?smarty if $calendar.show_location_field ?>checked="checked"<?smarty /if ?> />
                                        </div> 
                                    </div>
                                    <div>
                                        <label class="control-label" style="padding-top:1px;width:130px;padding-right: 20px;">
                                        <span id="admin_location_field_required_checkbox_label">Required</span>
                                        </label>
                                        <div class="controls" style="margin-left:400px;">
                                            <input type="checkbox" name="location_field_required" <?smarty if $calendar.location_field_required ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_phone_in_edit_dialog_checkbox_label">Show description field</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="show_phone_field" <?smarty if $calendar.show_phone_field ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div>
                                        <label class="control-label" style="padding-top:1px;width:130px;padding-right: 20px;">
                                        <span id="admin_phone_field_required_checkbox_label">Required</span>
                                        </label>
                                        <div class="controls" style="margin-left:400px;">
                                            <input type="checkbox" name="phone_field_required" <?smarty if $calendar.phone_field_required ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                            <span id="admin_show_url_in_edit_dialog_checkbox_label">Show URL field</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="show_url_field" <?smarty if $calendar.show_url_field ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div>
                                        <label class="control-label" style="padding-top:1px;width:130px;padding-right: 20px;">
                                        <span id="admin_url_field_required_checkbox_label">Required</span>
                                        </label>
                                        <div class="controls" style="margin-left:400px;">
                                            <input type="checkbox" name="url_field_required" <?smarty if $calendar.url_field_required ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_teammember_in_edit_dialog_checkbox_label">Show team member field</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" id="team_member_field_id" name="show_team_member_field" <?smarty if $calendar.show_team_member_field === true ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                    <div>
                                        <label class="control-label" style="padding-top:1px;width:130px;padding-right: 20px;">
                                        <span id="admin_notify_assign_teammember_checkbox_label">When assigned notify user</span>
                                        </label>
                                        <div class="controls" style="margin-left:400px;">
                                            <input type="checkbox" name="notify_assign_teammember" <?smarty if $calendar.notify_assign_teammember ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_1_field_in_edit_dialog_checkbox_label">Show custom dropdown #1</span>
                                        </label>
                                        <div class="controls" style="width:250px;">
                                            <input type="checkbox" id="custom_dropdown1_field_id" name="show_dropdown_1_field" <?smarty if $calendar.show_dropdown_1_field ?>checked="checked"<?smarty /if ?> /> <span style="vertical-align:middle;font-style:italic;"> &nbsp;<?smarty $calendar.dropdown1_label ?></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_2_field_in_edit_dialog_checkbox_label">Show custom dropdown #2</span>
                                        </label>
                                        <div class="controls" style="width:250px;">
                                            <input type="checkbox" id="custom_dropdown2_field_id" name="show_dropdown_2_field" <?smarty if $calendar.show_dropdown_2_field ?>checked="checked"<?smarty /if ?> /> <span style="vertical-align:middle;font-style:italic;"> &nbsp;<?smarty $calendar.dropdown2_label ?></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_3_field_in_edit_dialog_checkbox_label">Show custom dropdown #3</span>
                                        </label>
                                        <div class="controls" style="width:250px;">
                                            <input type="checkbox" id="custom_dropdown3_field_id" name="show_dropdown_3_field" <?smarty if $calendar.show_dropdown_3_field ?>checked="checked"<?smarty /if ?> /> <span style="vertical-align:middle;font-style:italic;"> &nbsp;<?smarty $calendar.dropdown3_label ?></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_4_field_in_edit_dialog_checkbox_label">Show custom dropdown #4</span>
                                        </label>
                                        <div class="controls" style="width:250px;">
                                            <input type="checkbox" id="custom_dropdown4_field_id" name="show_dropdown_4_field" <?smarty if $calendar.show_dropdown_4_field ?>checked="checked"<?smarty /if ?> /> <span style="vertical-align:middle;font-style:italic;"> &nbsp;<?smarty $calendar.dropdown4_label ?></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_5_field_in_edit_dialog_checkbox_label">Show custom dropdown #5</span>
                                        </label>
                                        <div class="controls" style="width:250px;">
                                            <input type="checkbox" id="custom_dropdown5_field_id" name="show_dropdown_5_field" <?smarty if $calendar.show_dropdown_5_field ?>checked="checked"<?smarty /if ?> /> <span style="vertical-align:middle;font-style:italic;"> &nbsp;<?smarty $calendar.dropdown5_label ?></span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="control-group">
                                    <label for="admin_user_calendar_location" class="control-label"><span id="event_location_label">Event location field</span> </label>
									<div class="controls"  style="padding-top:5px;">
                                        <span>
                                            <input type="radio" value="text" name="locationfield"  style="float:left;margin-right:5px;" id="admin_calendar_location_text" <?smarty if $calendar.locations|@count == 0 || !isset($calendar.locations) || empty($calendar.locations) ?>checked="true"<?smarty /if ?> /><label for="admin_calendar_locationfield_text" style="padding-top:1px;width: 33px;float:left;padding-right:20px;">text </label>
                                            <input type="radio" value="combo" name="locationfield"  style="float:left;margin-right:5px;" <?smarty if $calendar.locations|@count > 0 ?>checked="true"<?smarty /if ?> /><label for="admin_calendar_locationfield_combo" style="padding-top:1px;width: 33px;float:left;padding-right:20px;">dropdown-list </label>
                                        </span>
                                    </div>
				</div>
                                <div class="control-group" id="" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_show_dropdown_1_field_in_edit_dialog_checkbox_label">Allday is default</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" id="allday_is_default_id" name="allday_is_default" <?smarty if $calendar.allday_is_default ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                
                                
                                <div class="control-group" id="locations" style="<?smarty if !isset($calendar.locations) || empty($calendar.locations) ?>display:none;<?smarty /if ?>">
                                    <label for="admin_user_calendar_locations" style="padding-top:35px;" class="control-label"><span id="predefined_locations_label">Predefined locations</span> </label>
									<div class="controls">
										<input type="hidden" id="calendar_locations" name="locations" value="<?smarty $str_locations ?>" />
									
                                        <table id="locationtable" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:50px;border-top:0 none;text-align:left;"><span class="name_label">Name</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$calendar.locations item=item ?>
                                                <tr>
                                                    <td style="width:50px;padding:1px;border:none;"><input type="text" name="name<?smarty $item.location_id ?>" value="<?smarty $item.name ?>" data-number="<?smarty $item.location_id ?>" class="admin-location-name" id="admin-location-name-<?smarty $item.location_id ?>" /></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_locationfield" value="Add a location" />
                                    </div>
				</div>
                                
                                <hr id="event_title_additions_hr" style="display:<?smarty if !$calendar.show_team_member_field && !$calendar.show_dropdown_1_field && !$calendar.show_dropdown_2_field && !$calendar.show_dropdown_3_field && !$calendar.show_dropdown_4_field && !$calendar.show_dropdown_5_field ?>none;<?smarty else ?>block;<?smarty /if ?>" />
                                <h4 id="event_title_additions_h4" style="padding: 10px 0 10px 180px;font-weight:bold;display:<?smarty if !$calendar.show_team_member_field && !$calendar.show_dropdown_1_field && !$calendar.show_dropdown_2_field && !$calendar.show_dropdown_3_field && !$calendar.show_dropdown_4_field && !$calendar.show_dropdown_5_field ?>none;<?smarty else ?>block;<?smarty /if ?>">
                                    <span id="">Event title additions</span>
                                </h4>
                                
                                <div class="control-group" id="calendarname_is_title_field" style="margin-bottom:1px;">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_calendarname_is_title_label">Calendarname = event title</span>
                                        </label>
                                        <div class="controls">
                                            <input type="checkbox" name="calendarname_is_title" <?smarty if $calendar.calendarname_is_title ?>checked="checked"<?smarty /if ?> />
                                        <span id="calendarname_is_title_label" style="padding-top:5px;vertical-align:middle;">When adding an event, the calendarname is set as title</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_team_member_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_team_member_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_team_member_to_title_label">Team member</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_team_member_to_title" <?smarty if $calendar.add_team_member_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_custom_dropdown1_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_dropdown_1_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_custom_dropdown1_to_title_label">Custom dropdown #1</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_custom_dropdown1_to_title" <?smarty if $calendar.add_custom_dropdown1_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_custom_dropdown2_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_dropdown_2_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_custom_dropdown2_to_title_label">Custom dropdown #2</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_custom_dropdown2_to_title" <?smarty if $calendar.add_custom_dropdown2_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_custom_dropdown3_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_dropdown_3_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_custom_dropdown3_to_title_label">Custom dropdown #3</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_custom_dropdown3_to_title" <?smarty if $calendar.add_custom_dropdown3_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_custom_dropdown4_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_dropdown_4_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_custom_dropdown4_to_title_label">Custom dropdown #4</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_custom_dropdown4_to_title" <?smarty if $calendar.add_custom_dropdown4_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="add_custom_dropdown5_to_title" style="margin-bottom:1px;display:<?smarty if $calendar.show_dropdown_5_field ?>block;<?smarty else ?>none;<?smarty /if ?>">
                                    <div style="float:left;"> 
                                        <label class="control-label" style="padding-top:0;">
                                        <span id="admin_add_custom_dropdown5_to_title_label">Custom dropdown #5</span>
                                        </label>
                                        <div class="controls" style="width:80px;">
                                            <input type="checkbox" name="add_custom_dropdown5_to_title" <?smarty if $calendar.add_custom_dropdown5_to_title ?>checked="checked"<?smarty /if ?> />
                                        </div>
                                    </div>
                                </div>
                                
                                
                                
                       <hr />         
                                <h4 style="padding: 10px 0 10px 180px;font-weight:bold;">
                                    <span id="notifications_label">Notifications (only when a user is logged in)</span>
                                </h4>
                                <div class="control-group">
                                    <label for="users_can_email_event" class="control-label"><span id="manually_label">Manually</span> </label>
                                        <div class="controls">
                                                <input type="checkbox" name="users_can_email_event" <?smarty if $calendar.users_can_email_event ?>checked="true"<?smarty /if ?> />
                                            <span id="manually_info_label" style="padding-top:5px;vertical-align:middle;">Users can mail an event to admin/employer</span>
                                    </div>
				</div>
                                <div class="control-group">
                                    <label for="all_event_mods_to_admin" class="control-label"><span id="automatic_label">Automatic</span> </label>
                                        <div class="controls">
                                                <input type="checkbox" name="all_event_mods_to_admin" <?smarty if $calendar.all_event_mods_to_admin ?>checked="true"<?smarty /if ?> />
                                            <span id="automatic_info_label" style="padding-top:5px;vertical-align:middle;">An email with event changes is automatically send to admin/employer</span>
                                    </div>
                                        <div class="controls">
                                                <input type="checkbox" name="all_event_mods_to_admin_when_loggedin" <?smarty if $calendar.all_event_mods_to_admin_when_loggedin ?>checked="true"<?smarty /if ?> />
                                            <span id="automatic_when_loggedin_label" style="padding-top:5px;vertical-align:middle;">When the user is logged in</span>
                                    </div>
				</div>
                                
                                <div class="control-group">
                                    <label for="admin_calendar_admin_email" class="control-label"><span id="calendar_admin_email_label">Calendar admin email</span> </label>
					<div class="controls">
                                            <input type="text" class="input-xlarge" style="width:700px;" id="admin_calendar_admin_email" name="calendar_admin_email" value="<?smarty $calendar.calendar_admin_email ?>"><br />
                                            <span style="padding-left:5px;font-style:italic;" id="when_admin_email_is_empty_info">When empty: MAIL_EVENT_MAILADDRESS from config.php is used</span>
                                    </div>
				</div>
                               <hr />
                                <div class="control-group">
                                    <label for="assigned_event_to_admin" class="control-label"><span id="assigned_event_to_user_label">Assigned events</span> </label>
                                        <div class="controls" style="padding-bottom:10px;">
                                                <input type="checkbox" name="mail_assigned_event_to_user" <?smarty if $calendar.mail_assigned_event_to_user ?>checked="true"<?smarty /if ?> />
                                            <span id="assigned_event_to_user_info_label" style="padding-top:5px;vertical-align:middle;">An email is sent to the assigned user</span>
                                    </div>
                                    <span style="padding-left:240px;font-style:italic;" id="fill_in_from_mailaddress">FROM_EMAILADDRESS needs to be filled in in config.php</span>
                                    
                                        </div>

                                        <input type="hidden" name="calendar_id" value="<?smarty $calendar.calendar_id ?>" />
                                                <div class="form-actions">
                                                        <button id="save-calendar" class="btn btn-primary save" name="save-calendar" data-complete-text="Changes saved" data-loading-text="saving..." >Save changes</button>
                                                </div>

                                </form>


                                </div>

                    
					<?smarty elseif $active == 'settings' ?>
						<div id="admin-settings" style="padding-top:20px;padding-left:20px;">
							<legend id="admin_settings_legend">Settings</legend>
                            
                           <p id="admin_settings_info_text" style="padding: 0 0 20px 180px;font-style: italic;">
                                Some of these settings will only be applied when someone is logged in, otherwise the settings from config.php will be used.
                            </p>
                            
                        <?smarty if !empty($save_settings_error) ?>
                        <div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
                                <?smarty $save_settings_error ?>
                        </div>
                        <?smarty /if ?>

                        <?smarty if !empty($save_settings_success) ?>
                        <div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
                                <?smarty $save_settings_success ?>
                        </div>
                        <?smarty /if ?>


                        <form action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/settings/?action=save_settings" method="post" class="form-horizontal">

                             <div class="control-group">
                                <label for="calendar" class="control-label"><span id="settings_calendar_title_label">Calendar title</span> </label>
                                <div class="controls">
                                    <input type="text" class="input-xlarge" id="settings_calendar_title" name="calendar_title" value="<?smarty $settings.calendar_title ?>">
                                </div>
                            </div>                            
                            <div class="control-group">
                                <label for="admin_user_calendar_active" class="control-label"><span id="topbar_cal_logo_or_title_label">Show title / logo</span> </label>
                                <div class="controls"  style="padding-top:5px;">
                                    <span>
                                        <input type="radio" value="only_text" name="topbar_cal_logo_or_title"  style="float:left;margin-right:5px;" <?smarty if $settings.topbar_cal_logo_or_title == 'only_text' || !isset($settings.topbar_cal_logo_or_title) || empty($settings.topbar_cal_logo_or_title) ?>checked="true"<?smarty /if ?> /><label for="settings_topbar_only_text" style="padding-top:1px;width: 80px;float:left;padding-right:20px;"><span id="only_text_label">Only text</span> </label>
                                        <input type="radio" value="only_logo" name="topbar_cal_logo_or_title"  style="float:left;margin-right:5px;" id="settings_topbar_only_logo" <?smarty if $settings.topbar_cal_logo_or_title == 'only_logo' ?>checked="true"<?smarty /if ?> /><label for="settings_topbar_only_logo" style="padding-top:1px;width: 80px;float:left;padding-right:20px;"><span id="only_logo_label">Only logo</span> </label>
                                        <input type="radio" value="both" id="settings_topbar_both" name="topbar_cal_logo_or_title"  style="float:left;margin-right:5px;" <?smarty if $settings.topbar_cal_logo_or_title == 'both' ?>checked="true"<?smarty /if ?> /><label for="settings_topbar_both" style="padding-top:1px;width: 200px;float:left;padding-right:20px;"><span id="both_label">Both</span> </label>
                                        
                                    </span>
                                    
                                </div>
                            </div>   
                            <span id="" style="padding-left: 250px;font-style:italic;">Optional: Place your logo (calendar_logo.png) in the 'uploads' folder</span>                         
                            <hr>
                                                        
                                                        
                            
                            
                                <div class="control-group">
                                        <label for="admin_settings_default_view" class="control-label" id="admin_settings_defaultview_label">Default calendar view </label>
                                        <div class="controls">
                                                <!-- month, basicWeek, agendaWeek, basicDay, agendaDay , agendaList-->
                                                <select name="default_view">
                                                        <option value="month" <?smarty if $settings.default_view == "month" ?>selected="selected"<?smarty /if ?>>month</option>
                                                        <option value="agendaWeek" <?smarty if $settings.default_view == "agendaWeek" ?>selected="selected"<?smarty /if ?>>week</option>
                                                        <option value="agendaDay" <?smarty if $settings.default_view == "agendaDay" ?>selected="selected"<?smarty /if ?>>day</option>
                                                        <option value="agendaList" <?smarty if $settings.default_view == "agendaList" ?>selected="selected"<?smarty /if ?>>list</option>
                                                        <option value="customList" <?smarty if $settings.default_view == "customList" ?>selected="selected"<?smarty /if ?>>custom list</option>
                                                </select>
                                        </div>
                                </div>
                                <div class="control-group">
                                        <label for="admin_settings_week_view_type" class="control-label" id="admin_settings_week_view_type_label">Weekview type </label>
                                        <div class="controls">
                                                <!-- basicWeek, agendaWeek -->
                                                <select name="week_view_type">
                                                        <option value="agendaWeek" <?smarty if $settings.week_view_type == "agendaWeek" ?>selected="selected"<?smarty /if ?>>Agenda week</option>
                                                        <option value="basicWeek" <?smarty if $settings.week_view_type == "basicWeek" ?>selected="selected"<?smarty /if ?>>Basic week</option>
                                                </select>
                                        </div>
                                </div>
                                <div class="control-group">
                                        <label for="admin_settings_day_view_type" class="control-label" id="admin_settings_day_view_type_label">Dayview type </label>
                                        <div class="controls">
                                                <!-- basicDay, agendaDay -->
                                                <select name="day_view_type">
                                                        <option value="agendaDay" <?smarty if $settings.day_view_type == "agendaDay" ?>selected="selected"<?smarty /if ?>>Agenda day</option>
                                                        <option value="basicDay" <?smarty if $settings.day_view_type == "basicDay" ?>selected="selected"<?smarty /if ?>>Basic day</option>
                                                </select>
                                        </div>
                                </div>

                                <div class="control-group">
                                        <label for="admin_settings_language" class="control-label" id="admin_settings_language_label">Language </label>
                                        <div class="controls">
                                                <select name="language">
                                                        <?smarty foreach from=$current_languages name="current_languages" item=item key=key ?>
                                            <option value="<?smarty $key ?>" <?smarty if $settings.language == $key ?>selected="selected" checked="checked"<?smarty /if ?>><?smarty $item ?></option>
                                            <?smarty /foreach ?>
                                        </select>
                                        </div>
                                </div>

                                <div class="control-group">
                                        <label for="admin_settings_other_language_label_id" class="control-label" id="admin_settings_other_language_label">Other language </label>
                                        <div class="controls">
                                        <input type="text" class="input-xlarge" style="width:30px;" name="other_language" value="<?smarty $settings.other_language ?>" /> <span id="admin_settings_two_capitals_label">Two capital characters</span> (eg. EN, ES, DE) - <strong>Custom lang**.js is required in script folder</strong>
                                        </div>
                                </div>

                                <div class="control-group" id="admin_settings_show_weeknumbers" style="margin-bottom:1px;">
                                        <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                <label id="" class="control-label"></label>
                                                <input type="checkbox" name="show_weeknumbers" <?smarty if $settings.show_weeknumbers == "on" ?>checked="checked"<?smarty /if ?> />
                                                <span id="admin_show_weeknumbers_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show weeknumbers</span>
                                        </div>
                                </div>
                                
                                <!--<div class="control-group" id="admin_settings_custom_list_button" style="margin-bottom:1px;">
									<div class="controls" style="margin-left:20px;padding-bottom:5px;">
										<label id="" class="control-label"></label>
										<input type="checkbox" name="show_custom_list_button" <?smarty if $settings.show_custom_list_button == "on" ?>checked="checked"<?smarty /if ?> />
										<span id="admin_show_custom_list_btn_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show custom listview button</span>
									</div>
								</div>-->
                                
                                <div class="control-group" id="admin_settings_show_am_pm" style="margin-bottom:1px;">
                                        <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                <label id="" class="control-label"></label>
                                                <input type="checkbox" name="show_am_pm" <?smarty if $settings.show_am_pm == "on" ?>checked="checked"<?smarty /if ?> />
                                                <span id="admin_show_am_pm_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show AM/PM</span>
                                        </div>
                                </div>
                                <div class="control-group" id="admin_settings_show_notallowed_messages" style="margin-bottom:1px;">
                                        <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                <label id="" class="control-label"></label>
                                                <input type="checkbox" name="show_notallowed_messages" <?smarty if $settings.show_notallowed_messages == "on" ?>checked="checked"<?smarty /if ?> />
                                                <span id="admin_show_notallowed_messages_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show "not allowed" messages</span>
                                        </div>
                                </div>
                                <div class="control-group" id="admin_settings_show_user_filter" style="margin-bottom:1px;">
                                        <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                <label id="" class="control-label"></label>
                                                <input type="checkbox" name="show_user_filter" <?smarty if $settings.show_user_filter == "on" ?>checked="checked"<?smarty /if ?> />
                                                <span id="admin_show_user_filter_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show user filter</span>
                                        </div>
                                </div>
                                <div class="control-group">
                                        <label for="admin_settings_preview_type" class="control-label" id="admin_settings_mouseover_popup_label">Mouseover popup </label>
                                        <div class="controls">
                                                <select name="show_view_type">
                                                        <option value="mouseover" <?smarty if $settings.show_view_type == "mouseover" ?>selected="selected"<?smarty /if ?>>Mouseover</option>
                                                        <option value="none" <?smarty if $settings.show_view_type == "none" ?>selected="selected"<?smarty /if ?>>None</option>

                                                </select>
                                        </div>
                                </div>
                                <div class="control-group" id="admin_settings_truncate_title" style="margin-bottom:1px;">
                                        <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                                <label id="" class="control-label"></label>
                                                <input type="checkbox" name="truncate_title" <?smarty if $settings.truncate_title == "on" ?>checked="checked"<?smarty /if ?> />
                                                <span id="admin_truncate_title_checkbox_label" style="padding-top:5px;vertical-align:middle;">Truncate title</span>
                                        </div>
                                </div>
                                <div class="control-group">
                                    <label for="admin_settings_truncate_length_label_id" class="control-label" id="admin_settings_truncate_length_label">Title length </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" style="width:30px;" name="truncate_length" value="<?smarty $settings.truncate_length ?>" /> <span id="admin_settings_amount_of_characters_label">Amount of characters</span>
                                        </div>
                                </div>
                                
                        <hr />        <h4 style="padding:30px 0 10px 180px;font-weight:bold;" id="admin_settings_custom_listview_label">Custom Listview</h4>
                                <p id="admin_settings_registration_info_label" style="padding-left: 250px;font-style: italic;">
                                    SHOW_CUSTOM_LISTVIEW_BUTTON can be set in config.php
                                </p>
                                
                                <div class="control-group">
                                    <label for="admin_settings_next_days_visible" class="control-label"><span class="next_days_visible_label">Users can see next</span> </label>
                                    <div class="controls">
                                            <input type="text" style="width:50px;" class="input-xlarge" id="settings_next_days_visible" name="next_days_visible" value="<?smarty $settings.next_days_visible ?>"> days &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Logged in users and not logged in viewers)
                                    </div>
                                </div>
                        
                        <div class="control-group">
                                    <label for="admin_settings_past_days_visible" class="control-label"><span class="past_days_visible_label">Users can see past</span> </label>
                                    <div class="controls">
                                            <input type="text" style="width:50px;" class="input-xlarge" id="settings_past_days_visible" name="past_days_visible" value="<?smarty $settings.past_days_visible ?>"> days &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Logged in users and not logged in viewers)
                                    </div>
                                </div>
                                
                                                                
                        <hr />        <h4 style="padding:30px 0 10px 180px;font-weight:bold;" id="admin_settings_edit_dialog_label">Edit-dialog:</h4>
                                
                                <div class="control-group">
                                        <label for="admin_settings_colorpicker_type" class="control-label" id="admin_settings_colorpicker_type_label">Colorpicker type </label>
                                        <div class="controls">
                                                <select name="editdialog_colorpicker_type">
                                                        <option value="spectrum" <?smarty if $settings.editdialog_colorpicker_type == "spectrum" ?>selected="selected"<?smarty /if ?>>Spectrum</option>
                                                        <option value="simple" <?smarty if $settings.editdialog_colorpicker_type == "simple" ?>selected="selected"<?smarty /if ?>>Simple</option>

                                                </select>
                                        </div>
                                </div>
                                <div class="control-group">
                                        <label for="admin_settings_timepicker_type" class="control-label" id="admin_settings_timepicker_type_label">Timepicker type </label>
                                        <div class="controls">
                                                <select name="editdialog_timepicker_type">
                                                        <option value="ui" <?smarty if $settings.editdialog_timepicker_type == "ui" ?>selected="selected"<?smarty /if ?>>jQuery UI</option>
                                                        <option value="simple" <?smarty if $settings.editdialog_timepicker_type == "simple" ?>selected="selected"<?smarty /if ?>>Simple</option>

                                                </select>
                                        </div>
                                </div>
                                
                                
                                
                                <!--<div class="control-group" id="admin_settings_show_description_in_edit_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_description_field" <?smarty if $settings.show_description_field == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_description_in_edit_dialog_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show description field</span>
                                    </div>
                                </div><div class="control-group" id="admin_settings_show_location_in_edit_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_location_field" <?smarty if $settings.show_location_field == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_location_in_edit_dialog_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show location field</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_show_phone_in_edit_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_phone_field" <?smarty if $settings.show_phone_field == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_phone_in_edit_dialog_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show phone field</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_show_url_in_edit_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_url_field" <?smarty if $settings.show_url_field == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_url_in_edit_dialog_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show url field</span>
                                    </div>
                                </div>-->
                                <div class="control-group" id="admin_settings_show_delete_confirm_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_delete_confirm_dialog" <?smarty if $settings.show_delete_confirm_dialog == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_delete_confirm_dialog_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show confirm dialog when deleting an item</span>
                                    </div>
                                </div>
                                
                                <hr>
                                <H5 style="padding:50px 0 10px 180px;font-weight:bold;font-size:14px;">Custom dropdown-field 1</h5>
                                
                               <!-- <div class="control-group" id="show_custom_dropdown_1_dialog" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_custom_dropdown_1" <?smarty if $settings.show_custom_dropdown_1 == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="show_custom_dropdown_1_checkbox_label" style="padding-top:5px;vertical-align:middle;">Active</span>
                                    </div>
                                </div>-->
                                
                                <div class="control-group">
                                    <label for="settings_custom_dropdown_1_label" class="control-label"><span id="settings_custom_dropdown_1_label_label">Label</span> </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" id="settings_custom_dropdown_1_label" name="dropdown1_label" value="<?smarty $settings.dropdown1_label ?>">
                                    </div>
				</div>
                                <input type="hidden" id="settings_dropdown_1" name="dropdown_1_options" value="<?smarty $str_dropdown_1 ?>" />
					
                                
                                <div class="control-group" id="custom_dropdown_1" style="">
                                    <label for="admin_user_calendar_locations" style="padding-top:35px;" class="control-label"><span id="dropdown_1_options_label">Dropdown items</span> </label>
                                        <div class="controls">
                                                			
                                        <table id="dropdown_1_table" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:10px;border-top:0 none;text-align:left;"><span class="items_label">Items</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$settings.dropdown_1 item=item ?>
                                                <tr>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_1_item" value="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>" class="settings-dropdown_1_label" id="settings-dropdown-1-option-<?smarty $item.option_id ?>" /></td>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_1" id="admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>" name="dropdown_1_color" value="<?smarty $item.color ?>" data-title="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>"></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dropdown_1_option_field" class="add_an_item_btn" value="Add an item" />
                                    </div>
				</div>
                                <div class="control-group" id="admin_settings_show_custom_dropdown1_filter" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_custom_dropdown1_filter" <?smarty if $settings.show_custom_dropdown1_filter == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_custom_dropdown1_filter_checkbox_label" class="show_filter_label" style="padding-top:5px;vertical-align:middle;">Show filter</span>
                                    </div>
                                </div> 
                                
                                <hr />
                                <H5 style="padding:10px 0 10px 180px;font-weight:bold;font-size:14px;">Custom dropdown-field 2</h5>
                                
                                
                                <div class="control-group">
                                    <label for="settings_custom_dropdown_2_label" class="control-label"><span id="settings_custom_dropdown_2_label_label">Label</span> </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" id="settings_custom_dropdown_2_label" name="dropdown2_label" value="<?smarty $settings.dropdown2_label ?>">
                                    </div>
				</div>
                                <input type="hidden" id="settings_dropdown_2" name="dropdown_2_options" value="<?smarty $str_dropdown_2 ?>" />
					
                               
                                <div class="control-group" id="custom_dropdown_2" style="">
                                    <label for="admin_user_calendar_locations" style="padding-top:35px;" class="control-label"><span id="dropdown_2_options_label">Dropdown items</span> </label>
                                        <div class="controls">
                                                			
                                        <table id="dropdown_2_table" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:50px;border-top:0 none;text-align:left;"><span class="items_label">Items</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$settings.dropdown_2 item=item ?>
                                                <tr>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_2_item" value="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>" class="settings-dropdown_2_label" id="settings-dropdown-2-option-<?smarty $item.option_id ?>" /></td>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_2" id="admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>" name="dropdown_2_color" value="<?smarty $item.color ?>" data-title="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>"></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dropdown_2_option_field" class="add_an_item_btn" value="Add an item" />
                                    </div>
				</div>
                                
                                <div class="control-group" id="admin_settings_show_custom_dropdown2_filter" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="show_custom_dropdown2_filter" <?smarty if $settings.show_custom_dropdown2_filter == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_show_custom_dropdown2_filter_checkbox_label" class="show_filter_label" style="padding-top:5px;vertical-align:middle;">Show filter</span>
                                    </div>
                                </div> 
                                
                                <H5 style="padding:50px 0 10px 180px;font-weight:bold;font-size:14px;">Method of filtering the custom dropdowns</h5>
                                
                                <div class="control-group" id="admin_settings_dropdowns_are_linked" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="dropdowns_are_linked" <?smarty if $settings.dropdowns_are_linked == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_dropdowns_are_linked_checkbox_label" style="padding-top:5px;vertical-align:middle;">Dropdowns are linked ('AND' condition, events are visible where A1 AND B1 are set )</span>
                                        
                                    </div>
                                </div> 
                                <hr>
                                <!-- custom dropdown 3 -->
                                <H5 style="padding:10px 0 10px 180px;font-weight:bold;font-size:14px;">Custom dropdown-field 3</h5>
                                
                                
                                <div class="control-group">
                                    <label for="settings_custom_dropdown_3_label" class="control-label"><span id="settings_custom_dropdown_3_label_label">Label</span> </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" id="settings_custom_dropdown_3_label" name="dropdown3_label" value="<?smarty $settings.dropdown3_label ?>">
                                    </div>
				</div>
                                <input type="hidden" id="settings_dropdown_3" name="dropdown_3_options" value="<?smarty $str_dropdown_3 ?>" />
					
                               
                                <div class="control-group" id="custom_dropdown_3" style="">
                                    <label style="padding-top:35px;" class="control-label"><span id="dropdown_3_options_label">Dropdown items</span> </label>
                                        <div class="controls">
                                                			
                                        <table id="dropdown_3_table" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:50px;border-top:0 none;text-align:left;"><span class="items_label">Items</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$settings.dropdown_3 item=item ?>
                                                <tr>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_3_item" value="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>" class="settings-dropdown_3_label" id="settings-dropdown-3-option-<?smarty $item.option_id ?>" /></td>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_3" id="admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>" name="dropdown_3_color" value="<?smarty $item.color ?>" data-title="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>"></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dropdown_3_option_field" class="add_an_item_btn" value="Add an item" />
                                    </div>
				</div>
                                <hr>
                                <!-- custom dropdown 4 -->
                                <H5 style="padding:10px 0 10px 180px;font-weight:bold;font-size:14px;">Custom dropdown-field 4</h5>
                                
                                
                                <div class="control-group">
                                    <label for="settings_custom_dropdown_4_label" class="control-label"><span id="settings_custom_dropdown_4_label_label">Label</span> </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" id="settings_custom_dropdown_4_label" name="dropdown4_label" value="<?smarty $settings.dropdown4_label ?>">
                                    </div>
				</div>
                                <input type="hidden" id="settings_dropdown_4" name="dropdown_4_options" value="<?smarty $str_dropdown_4 ?>" />
					
                               
                                <div class="control-group" id="custom_dropdown_4" style="">
                                    <label style="padding-top:35px;" class="control-label"><span id="dropdown_4_options_label">Dropdown items</span> </label>
                                        <div class="controls">
                                                			
                                        <table id="dropdown_4_table" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:50px;border-top:0 none;text-align:left;"><span class="items_label">Items</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$settings.dropdown_4 item=item ?>
                                                <tr>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_4_item" value="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>" class="settings-dropdown_4_label" id="settings-dropdown-4-option-<?smarty $item.option_id ?>" /></td>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_4" id="admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>" name="dropdown_4_color" value="<?smarty $item.color ?>" data-title="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>"></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dropdown_4_option_field" class="add_an_item_btn" value="Add an item" />
                                    </div>
				</div>
                                
                                <hr>
                                <!-- custom dropdown 5 -->
                                <H5 style="padding:10px 0 10px 180px;font-weight:bold;font-size:14px;">Custom dropdown-field 5</h5>
                                
                                
                                <div class="control-group">
                                    <label for="settings_custom_dropdown_5_label" class="control-label"><span id="settings_custom_dropdown_5_label_label">Label</span> </label>
                                    <div class="controls">
                                        <input type="text" class="input-xlarge" id="settings_custom_dropdown_5_label" name="dropdown5_label" value="<?smarty $settings.dropdown5_label ?>">
                                    </div>
				</div>
                                <input type="hidden" id="settings_dropdown_5" name="dropdown_5_options" value="<?smarty $str_dropdown_5 ?>" />
					
                               
                                <div class="control-group" id="custom_dropdown_5" style="">
                                    <label style="padding-top:35px;" class="control-label"><span id="dropdown_5_options_label">Dropdown items</span> </label>
                                        <div class="controls">
                                                			
                                        <table id="dropdown_5_table" class="table table-striped" style="font-size:14px;width:510px;font-size:13px;margin-bottom:0;">
                                            <thead>
                                                <tr style="">
                                                    <th style="width:50px;border-top:0 none;text-align:left;"><span class="items_label">Items</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            <?smarty foreach from=$settings.dropdown_5 item=item ?>
                                                <tr>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_5_item" value="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>" class="settings-dropdown_5_label" id="settings-dropdown-5-option-<?smarty $item.option_id ?>" /></td>
                                                    <td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_5" id="admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>" name="dropdown_5_color" value="<?smarty $item.color ?>" data-title="<?smarty $item.text ?>" data-number="<?smarty $item.option_id ?>"></td>
                                                </tr>
                                               
                                            <?smarty /foreach ?>

                                            </tbody>
                                        </table>
                                       <input type="button" id="add_dropdown_5_option_field" class="add_an_item_btn" value="Add an item" />
                                    </div>
				</div>
                                
                        <hr />        <h4 style="padding:30px 0 10px 180px;font-weight:bold;" id="admin_settings_pdf_export_label">PDF export:</h4>
                                
                                <div class="control-group" id="admin_settings_pdf_table_look" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_table_look" <?smarty if $settings.pdf_table_look == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_table_look_checkbox_label" style="padding-top:5px;vertical-align:middle;">Table-look</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_show_time_columns" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_show_time_columns" <?smarty if !isset($settings.pdf_show_time_columns) || $settings.pdf_show_time_columns == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_show_time_columns_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show the time columns</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_show_date_on_every_line" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_show_date_on_every_line" <?smarty if $settings.pdf_show_date_on_every_line == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_show_date_on_every_line_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show date on every line</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_show_logo" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_show_logo" <?smarty if !isset($settings.pdf_show_logo) || $settings.pdf_show_logo == "on" ?>checked="checked"<?smarty /if ?> />
                                               <span id="admin_pdf_show_logo_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show your logo</span> &nbsp;&nbsp;<span style="padding-top:5px;vertical-align:middle;font-style:italic;"> (Place your logo (pdf_logo.png) in the 'uploads' folder)</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_show_custom_dropdown_values" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_show_custom_dropdown_values" <?smarty if !isset($settings.pdf_show_custom_dropdown_values) || $settings.pdf_show_custom_dropdown_values == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_show_custom_dropdown_values_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show the custom dropdown values</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_show_calendarname_each_line" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_show_calendarname_each_line" <?smarty if !isset($settings.pdf_show_calendarname_each_line) || $settings.pdf_show_calendarname_each_line == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_show_calendarname_each_line_checkbox_label" style="padding-top:5px;vertical-align:middle;">Show calendar name on each line</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_fontweight_bold" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_fontweight_bold" <?smarty if $settings.pdf_fontweight_bold == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_fontweight_bold_checkbox_label" style="padding-top:5px;vertical-align:middle;">Font-weight: bold</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_colored_rows" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_colored_rows" <?smarty if $settings.pdf_colored_rows == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_colored_rows_checkbox_label" style="padding-top:5px;vertical-align:middle;">Row colors gray/white</span>
                                    </div>
                                </div>
                                <div class="control-group" id="admin_settings_pdf_sorting" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="pdf_sorting" <?smarty if $settings.pdf_sorting == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_pdf_sorting_checkbox_label" style="padding-top:5px;vertical-align:middle;">Sort by calendar order</span>
                                    </div>
                                </div>
                                
                                <div id="admin_pdf_pagination_translation" style="padding:10px 0 10px 200px;font-weight:bold;">Pagination translation</div>
                                <div class="control-group">
                                    <div style="padding-left:260px;"><span class="admin_label_page">Page</span>&nbsp;&nbsp;&nbsp; 1 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<span class="admin_label_of">of</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</div>
                                    <div class="controls">
										<input type="text" class="input-xlarge" style="width:50px;" name="lang_page" value="<?smarty $settings.lang_page ?>" />
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="text" class="input-xlarge" style="width:40px;" name="lang_of" value="<?smarty $settings.lang_of ?>" />
                                        
                                    </div>
								</div>
                                <div id="admin_pdf_column_names" style="padding:10px 0 10px 200px;font-weight:bold;">Table column names</div>
                                <div class="control-group">
                                    <div style="padding-left:250px;"><span class="admin_label_date_column">Date column</span> | <span class="admin_label_start_time_column">Start time column</span> | <span class="admin_label_end_time_column">End time column</span> | <span class="admin_label_event_title_column">Event title column</span></div>
                                    <div class="controls">
										<input type="text" class="input-xlarge" style="width:90px;" name="date_header" value="<?smarty $settings.date_header ?>" />
                                        <input type="text" class="input-xlarge" style="width:90px;" name="starttime_header" value="<?smarty $settings.starttime_header ?>" />
                                        <input type="text" class="input-xlarge" style="width:90px;" name="endtime_header" value="<?smarty $settings.endtime_header ?>" />
                                        <input type="text" class="input-xlarge" style="width:90px;" name="title_header" value="<?smarty $settings.title_header ?>" />
                                    </div>
								</div>
                                
                                <h4 style="padding:50px 0 10px 180px;font-weight:bold;" id="admin_settings_hour_calculation_label">Hour calculation:</h4>
                                
                                <div class="control-group">
									<label for="admin_settings_workday_hours_label_id" class="control-label" id="admin_settings_workday_hours_label">Workday hours </label>
									<div class="controls">
                                        <input type="text" class="input-xlarge" style="width:30px;" name="hourcalculation_workday_hours" value="<?smarty $settings.hourcalculation_workday_hours ?>" /> <span id="admin_settings_amount_of_hours_label">Amount of hours in a workday</span>
									</div>
								</div>
                                <div class="control-group">
									<label for="admin_settings_default_period_label_id" class="control-label" id="admin_settings_default_period_label">Default period </label>
									<div class="controls">
										<input type="text" class="input-xlarge" style="width:30px;" name="hourcalculation_default_period" value="<?smarty $settings.hourcalculation_default_period ?>" /> <span id="admin_settings_initial_period_label">Initial period in months</span>
									</div>
								</div>
                                
                                
                                <!--<div class="control-group" id="admin_settings_users_can_register" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="users_can_register" <?smarty if $settings.users_can_register == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_users_can_register_checkbox_label" style="padding-top:5px;vertical-align:middle;">Users can register</span>
                                    </div>
                                </div>-->
                               
                        
                        <h4 style="padding:50px 0 10px 180px;font-weight:bold;" id="admin_settings_registration_label">Registration:</h4>
                                <p id="admin_settings_registration_info_label" style="padding-left: 250px;font-style: italic;">
                                    USERS_CAN_REGISTER can be set in config.php
                                </p>
                                <div class="control-group" id="admin_settings_send_activation_mail" style="margin-bottom:1px;">
                                    <div class="controls" style="margin-left:20px;padding-bottom:5px;">
                                        <label id="" class="control-label"></label>
                                        <input type="checkbox" name="send_activation_mail" <?smarty if $settings.send_activation_mail == "on" ?>checked="checked"<?smarty /if ?> />
                                        <span id="admin_send_activation_mail_checkbox_label" style="padding-top:5px;vertical-align:middle;">Send activation mail</span>
                                    </div>
                                </div>
                               
                                            <input type="hidden" name="user_id" value="<?smarty $user_id ?>" />
                                            <div class="form-actions">
                                                    <button id="save-settings" class="btn btn-primary save" name="save-settings" data-complete-text="Changes saved" data-loading-text="saving..." >Save changes</button>
                                            </div>
                                          

                                    </form>
                            </div>

					<?smarty elseif $active == 'lists' ?>
						<div id="admin-lists"  style="padding-top:20px;padding-left:20px;">
								<?smarty if !empty($error) ?>
								<div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
									<?smarty $error ?>
								</div>
								<?smarty /if ?>

								<?smarty if !empty($msg) ?>
								<div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
									<?smarty $msg ?>
								</div>
								<?smarty /if ?>

                                <span style="float:right;padding-top: 17px;" id="lists_to_excel_btn" class="not_print">
                                    <span class="dashboard_btn not_print">
                                        <i class="icon-th"></i> To Excel
                                    </span>
                                </span>	
                                
                                <form id="calendars-form" action="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars/?action=new_calendar" method="post" class="form-horizontal">
                                        <?smarty if isset($smarty.session.add_calendar_error) ?>
                                        <div style="position:absolute;left:400px;color:red;font-weight:bold;">
                                                <?smarty $smarty.session.add_calendar_error ?>
                                        </div>
                                        <?smarty /if ?>

                                </form>

                                <legend id="admin_settings_hour_calculation_legend">Hour calculation</legend>
								
								
                                <div class="control-group" style="padding: 20px 0 30px 0;">
									<span class="control-label" id="admin_settings_calendars_label" style="width:auto;padding-right:5px;">Calendar </span>
                                    <select id="calendar_selectbox" name="calendar" style="width:150px;margin-bottom: 0;">
                                        <option class="calendar_option" value="all" <?smarty if $selected_calendar == "all" ?>selected="selected"<?smarty /if ?>>All</option>
                                        <?smarty foreach from=$calendars item=item ?>
                                            <option class="calendar_option" value="<?smarty $item.calendar_id ?>" <?smarty if $selected_calendar == $item.calendar_id ?>selected="selected"<?smarty /if ?>><?smarty $item.name ?></option>
                                        <?smarty /foreach ?>
                                    </select>


                                    <span id="month_label_id" style="padding-left:30px;margin-bottom: 0;">From: </span>
                                        <input type="text" id="hourcalc_datepicker_startdate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;z-index:9999;">
                                    <span id="time_label_id">To: </span>
                                        <input type="text" id="hourcalc_datepicker_enddate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;" />

                                    <button id="dates_clear_button" style="padding:3px 12px;" class="btn btn-secondary" name="clear-list" data-complete-text="fields cleared" data-loading-text="saving..." >Clear</button> 
                                    <button id="dates_refresh_button" style="float:right;margin-left:50px;padding:3px 12px;" class="btn btn-primary" name="refresh-list" data-complete-text="Changes saved" data-loading-text="saving..." >Refresh</button> 
								</div>

								<div id="calendar_list">
									<table class="table table-striped" id="lists_table" style="font-size:14px;">
										<thead>
											<tr>
												<th><span class="name_label">Name</span></th>
												<th><span class="days_label">Days</span></th>
												<th><span class="hours_label">Hours</span></th>
												
											</tr>
										</thead>
										<tbody>

										<?smarty foreach from=$list item=item ?>

											<tr>
												<td><?smarty $item.fullname ?> <?smarty if $item.superadmin ?><span class="label label-important">superadmin</span><?smarty elseif $item.admin ?><span class="label label-important">admin</span><?smarty /if ?></td>
												<td><?smarty $item.days ?></td>
												<td><?smarty $item.hours ?></td>
                                                <td class="not_print" style="border-left:1px solid #DDDDDD;width:10px;"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists?action=get_list&uid=<?smarty $item.user_id ?><?smarty if isset($smarty.get.cid) && !empty($smarty.get.cid) ?>&cid=<?smarty $smarty.get.cid ?><?smarty /if ?>"><img src="<?smarty $smarty.const.FULLCAL_URL ?>/images/view.png" /></a></td>
												
												
											</tr>
										<?smarty foreachelse ?>
											<tr>
												<td>No rows found</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
										<?smarty /foreach ?>

										</tbody>
									</table>

								<!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


							</div>
					<?smarty elseif $active == 'list' ?>
						<div id="admin-list"  style="padding-top:20px;padding-left:20px;">
								<?smarty if !empty($error) ?>
								<div style="position:absolute;left:400px;top:60px;color:red;font-weight:bold;">
									<?smarty $error ?>
								</div>
								<?smarty /if ?>

								<?smarty if !empty($msg) ?>
								<div style="position:absolute;left:400px;top:60px;color:green;font-weight:bold;">
									<?smarty $msg ?>
								</div>
								<?smarty /if ?>

								
								<!--<form id="calendars-form" action="" method="post" class="form-horizontal">-->
									<?smarty if isset($smarty.session.add_calendar_error) ?>
									<div style="position:absolute;left:400px;color:red;font-weight:bold;">
										<?smarty $smarty.session.add_calendar_error ?>
									</div>
									<?smarty /if ?>

                                    <span style="float:right;" id="list_to_excel_btn">
                                        <span class="dashboard_btn">
                                            <i class="icon-th"></i> To Excel
                                        </span>
                                    </span>	
									
								
                                    <legend><span id="admin_settings_user_hour_calculation_legend">Hour calculation of</span> <strong><?smarty $user.title ?> <?smarty $user.lastname ?>, <?smarty $user.firstname ?> <?smarty $user.infix ?></strong></legend>
								
								<div class="control-group" style="padding: 20px 0 30px 0;">
									<span class="control-label" id="admin_settings_calendars_label" style="width:auto;padding-right:5px;">Calendar </span>
                                    <select id="calendar_selectbox" name="calendar" style="width:150px;margin-bottom: 0;">
                                        <option class="calendar_option" value="all" <?smarty if $selected_calendar == "all" ?>selected="selected"<?smarty /if ?>>All</option>
                                        <?smarty foreach from=$calendars item=item ?>
                                            <option class="calendar_option" value="<?smarty $item.calendar_id ?>" <?smarty if $selected_calendar == $item.calendar_id ?>selected="selected"<?smarty /if ?>><?smarty $item.name ?></option>
                                        <?smarty /foreach ?>
                                    </select>


                                    <span id="month_label_id" style="padding-left:30px;margin-bottom: 0;">From: </span>
                                        <input type="text" id="hourcalc_datepicker_startdate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;z-index:9999;">
                                    <span id="time_label_id">To: </span>
                                        <input type="text" id="hourcalc_datepicker_enddate" style="font-size:13px;margin-bottom: 0;width: 80px;padding:3px;" />

                                    <button id="dates_clear_button" style="padding:3px 12px;" class="btn btn-secondary" name="clear-list" data-complete-text="fields cleared" data-loading-text="saving..." >Clear</button> 
                                    <button id="user_dates_refresh_button" style="float:right;margin-left:50px;padding:3px 12px;" class="btn btn-primary" name="refresh-list" data-complete-text="Changes saved" data-loading-text="saving..." >Refresh</button> 
								</div>
							

								<!--</form>-->
								
								<div id="calendar_list">
									<table class="table table-striped" id="list_table" style="font-size:14px;">
										<thead>
											<tr>
												<th><span class="date_label">Date</span></th>
												<th><span class="time_label">Time</span></th>
												<th><span class="days_label">Days</span></th>
												<th><span class="hours_label">Hours</span></th>
												<th><span class="calendar_label">Calendar</span></th>

											</tr>
										</thead>
										<tbody>

										<?smarty foreach from=$list item=item ?>

											<tr>
												<td style="width:190px;"><?smarty $item.date_start ?><?smarty if $item.date_end != $item.date_start ?> - <?smarty $item.date_end ?><?smarty /if ?></td>
												<td><?smarty if $item.allDay ?>allday<?smarty else ?><?smarty $item.time_start ?> - <?smarty $item.time_end ?><?smarty /if ?></td>
												<td><?smarty $item.days ?></td>
												<td><?smarty $item.hours ?></td>
												<td><?smarty $item.name ?></td>
											</tr>
										<?smarty /foreach ?>
										
										<tr style="border-top:2px solid #333333;">
											<td>Total</td>
											<td>&nbsp;</td>
											<td><?smarty $total_day_count ?></td>
											<td><?smarty $total_hour_count ?></td>
											<td>&nbsp;</td>
										</tr>
											
										</tbody>
									</table>

								<!--	<div class="pagination"><ul><li class="prev disabled"><a href="<?smarty $smarty.const.FULLCAL_URL ?>/admin/calendars?to=<?smarty $from ?>"> Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next </a></li></ul></div>	</div>-->


							</div>
					
                    
					<?smarty /if ?>

				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
            MyCalendar.datePickerDateFormat = '<?smarty $smarty.const.DATEPICKER_DATEFORMAT ?>';
            MyCalendar.last_dditem = '';
            MyCalendar.dditem_string = '';
            MyCalendar.last_location = '';
            MyCalendar.location_string = '';
            MyCalendar.last_dropdown_1_option = '';
            MyCalendar.last_dropdown_2_option = '';
            MyCalendar.last_dropdown_3_option = '';
            MyCalendar.last_dropdown_4_option = '';
            MyCalendar.last_dropdown_5_option = '';

            MyCalendar.timePickerMinHour = <?smarty $smarty.const.MINHOUR ?>;
            MyCalendar.timePickerMaxHour = <?smarty $smarty.const.MAXHOUR ?>;
            MyCalendar.timePickerMinuteInterval = <?smarty $smarty.const.MINUTE_INTERVAL ?>;
            MyCalendar.showAMPM	= <?smarty if $settings.show_am_pm == 'on' ?>true<?smarty else ?>false<?smarty /if ?>;
	
        $('#calendar_dditems').val('<?smarty $str_dditems ?>');
        $('#settings_dropdown_1').val('<?smarty $str_dropdown_1 ?>');
        $('#settings_dropdown_2').val('<?smarty $str_dropdown_2 ?>');
        $('#settings_dropdown_3').val('<?smarty $str_dropdown_3 ?>');
        $('#settings_dropdown_4').val('<?smarty $str_dropdown_4 ?>');
        $('#settings_dropdown_5').val('<?smarty $str_dropdown_5 ?>');
    
	var current_user = '<?smarty if isset($user) && isset($user.user_id) ?><?smarty $user.user_id ?><?smarty /if ?>';
		
	$(document).ready(function() {
            MyCalendar.last_dditem = 1000000;
            MyCalendar.last_dropdown_1_option = 1000000;
            MyCalendar.last_dropdown_2_option = 1000000;
            MyCalendar.last_dropdown_3_option = 1000000;
            MyCalendar.last_dropdown_4_option = 1000000;
            MyCalendar.last_dropdown_5_option = 1000000;
            MyCalendar.last_location = '<?smarty $last_location ?>';
            
            $('#hourcalc_datepicker_startdate').val('<?smarty $startdate ?>');
            $('#hourcalc_datepicker_enddate').val('<?smarty $enddate ?>');
           
            
            $('#active_period_datepicker_startdate').val('<?smarty $calendar.cal_startdate ?>');
            $('#active_period_datepicker_enddate').val('<?smarty $calendar.cal_enddate ?>');
            
            $('#alterable_period_datepicker_startdate').val('<?smarty $calendar.alterable_startdate ?>');
            $('#alterable_period_datepicker_enddate').val('<?smarty $calendar.alterable_enddate ?>');
            
            $('.lists_calendar_option').click(function(t) {
                location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists/?cid='+$(this).val();
            });
            
            //$('#users_search_button').click(function() {
            //    location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/users/?sq='+$('#users_search_field').val();
            //});
            
            $('#users_clear_search_button').click(function() {
                $('#users_search_field').val('');
                $('#user_search_frm').submit();
       
                //location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/users';
            });
            
            
            $('.calendar_option').click(function(t) {
                    //location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists/?action=get_list&uid='+current_user+'&cid='+$(this).val();
            });
			
            
            $('#dates_clear_button').click(function(t) {
                $('#hourcalc_datepicker_startdate').val('');
                $('#hourcalc_datepicker_enddate').val('');
                
            });
            $('#dates_refresh_button').click(function(t) {
				var startdate = $('#hourcalc_datepicker_startdate').val();
                var enddate = $('#hourcalc_datepicker_enddate').val();
                var selected_cal = $('#calendar_selectbox').val();
                location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists/?cid='+selected_cal+'&st='+startdate+'&end='+enddate;
			});
            
             $('#user_dates_refresh_button').click(function(t) {
				var startdate = $('#hourcalc_datepicker_startdate').val();
                var enddate = $('#hourcalc_datepicker_enddate').val();
                var selected_cal = $('#calendar_selectbox').val();
                location.href = '<?smarty $smarty.const.FULLCAL_URL ?>/admin/lists/?action=get_list&uid='+current_user+'&cid='+selected_cal+'&st='+startdate+'&end='+enddate;
			});
            
            $('input[name="active"]').change(function(t) {
                if($(this).val() == 'period') {
                    $('#active_period_datepicker_startdate').prop('disabled', false);
                    $('#active_period_datepicker_enddate').prop('disabled', false);
                } else {
                    $('#active_period_datepicker_startdate').prop('disabled', true);
                    $('#active_period_datepicker_enddate').prop('disabled', true);
                }
                
            });
            
            $('input[name="locationfield"]').change(function(t) {
                if($(this).val() == 'combo') {
                    $('#locations').show();
                    
                } else {
                    $('#locations').hide();
                   
                }
                
            });
            
            $('#admin_calendar_origin').change(function(t) {
                if($(this).val() == 'exchange') {
                    // show groups combo
                    $('#exchange_username_field').show();
                    $('#exchange_password_field').show();
                    $('#exchange_token_field').show();
                    $('#admin_exchange_extra_secure').show();
                } else {
                    $('#exchange_username_field').hide();
                    $('#exchange_password_field').hide();
                    $('#exchange_token_field').hide();
                    $('#admin_exchange_extra_secure').hide();
                }
            });
            
            $('#exchange_extra_secure_checkbox').click(function(t,b) {
                if($(this).is(':checked')) {
                    $('#exchange_token').removeAttr('disabled');
                } else {
                    $('#exchange_token').prop('disabled', true);
                }
            });
            
            $('#admin_calendar_share_type').change(function(t) {
                if($(this).val() == 'private') {
                    // disable checkboxes
                    $('#admin_calendar_can_add').prop('disabled', true);
                    $('#admin_calendar_can_view_own_assigned').prop('disabled', true);
                    $('#admin_calendar_can_edit').prop('disabled', true);
                    $('#admin_calendar_can_delete').prop('disabled', true);
                    $('#admin_calendar_can_change_color').prop('disabled', true);
                    
                    $('#admin_calendar_can_add').attr('checked', false);
                    $('#admin_calendar_can_view_own_assigned').attr('checked', false);
                    $('#admin_calendar_can_edit').attr('checked', false);
                    $('#admin_calendar_can_delete').attr('checked', false);
                    $('#admin_calendar_can_change_color').attr('checked', false);
                } else {
                    // enable checkboxes
                    $('#admin_calendar_can_add').prop('disabled', false);
                    $('#admin_calendar_can_view_own_assigned').prop('disabled', false);
                    $('#admin_calendar_can_edit').prop('disabled', false);
                    $('#admin_calendar_can_delete').prop('disabled', false);
                    $('#admin_calendar_can_change_color').prop('disabled', false);
                }
                if($(this).val() == 'private_group') {
                    $('#admin_calendar_can_add_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanAdd);
                    $('#admin_calendar_can_view_own_assigned_label').text(Lang.Calendar.LabelCanViewOwnAssigned);
                    $('#admin_calendar_can_edit_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanEdit);
                    $('#admin_calendar_can_delete_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanDelete);
                    $('#admin_calendar_can_change_color_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanChangeColor);
                    $('#admin_calendar_can_view_label').text(Lang.Calendar.LabelEverybody +' '+ Lang.Calendar.LabelCanView);
                    
                    
                    // show groups combo
                    $('#admin_calendar_group_combo').show();
                    $('#admin_others_can_view').show();
                } else {
                    $('#admin_calendar_can_add_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanAdd);
                    $('#admin_calendar_can_view_own_assigned_label').text(Lang.Calendar.LabelCanViewOwnAssigned);
                    $('#admin_calendar_can_edit_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanEdit);
                    $('#admin_calendar_can_delete_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanDelete);
                    $('#admin_calendar_can_change_color_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanChangeColor);
                    
                    // hide groups combo
                    $('#admin_calendar_group_combo').hide();
                    $('#admin_others_can_view').hide();
                }
            });
      
            <?smarty if $calendar.share_type == "private_group" ?>
                $('#admin_calendar_can_add_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanAdd);
                $('#admin_calendar_can_view_own_assigned_label').text(Lang.Calendar.LabelCanViewOwnAssigned);
                $('#admin_calendar_can_edit_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanEdit);
                $('#admin_calendar_can_delete_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanDelete);
                $('#admin_calendar_can_change_color_label').text(Lang.Calendar.LabelGroup +' '+ Lang.Calendar.LabelCanChangeColor);
                $('#admin_calendar_can_view_label').text(Lang.Calendar.LabelEverybody +' '+ Lang.Calendar.LabelCanView);
                    
                <?smarty else ?>
                $('#admin_calendar_can_add_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanAdd);
                $('#admin_calendar_can_view_own_assigned_label').text(Lang.Calendar.LabelCanViewOwnAssigned);
                $('#admin_calendar_can_edit_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanEdit);
                $('#admin_calendar_can_delete_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanDelete);
                $('#admin_calendar_can_change_color_label').text(Lang.Calendar.LabelOthers +' '+ Lang.Calendar.LabelCanChangeColor);
                    
            <?smarty /if ?>
            
            <?smarty if $active == 'availability' ?>
            
            var updateTimes = function(arrMinutes, me) {
                var hours1 = Math.floor(arrMinutes[0] / 60);
                var minutes1 = arrMinutes[0] - (hours1 * 60);

                $('#'+me.parent()[0].className+'-time-1').val(hours1 +':'+ (minutes1 == '0' ? '00' : minutes1));
                
                if (hours1.length == 1) hours1 = '0' + hours1;
                if (minutes1.length == 1) minutes1 = '0' + minutes1;
                if (minutes1 == 0) minutes1 = '00';
                if (hours1 >= 12) {
                    if (hours1 == 12) {
                        
                        minutes1 = minutes1 + " PM";
                    } else {
                        hours1 = hours1 - 12;
                        minutes1 = minutes1 + " PM";
                    }
                } else {
                    
                    minutes1 = minutes1 + " AM";
                }
                if (hours1 == 0) {
                    hours1 = 12;
                    minutes1 = minutes1;
                }


                $('#'+me.parent()[0].className+'-1').html(hours1 + ':' + minutes1);

                var hours2 = Math.floor(arrMinutes[1] / 60);
                var minutes2 = arrMinutes[1] - (hours2 * 60);

                $('#'+me.parent()[0].className+'-time-2').val(hours2 +':'+ (minutes2 == '0' ? '00' : minutes2));
                
                if (hours2.length == 1) hours2 = '0' + hours2;
                if (minutes2.length == 1) minutes2 = '0' + minutes2;
                if (minutes2 == 0) minutes2 = '00';
                if (hours2 >= 12) {
                    if (hours2 == 12) {
                        hours2 = hours2;
                        minutes2 = minutes2 + " PM";
                    } else if (hours2 == 24) {
                        hours2 = 11;
                        minutes2 = "59 PM";
                    } else {
                        hours2 = hours2 - 12;
                        minutes2 = minutes2 + " PM";
                    }
                } else {
                    hours2 = hours2;
                    minutes2 = minutes2 + " AM";
                }

                $('#'+me.parent()[0].className+'-2').html(hours2 + ':' + minutes2);

            };
    
            MyCalendar.sliders = [];
            for(i=1;i<6;i++) {
            $(".slider-range"+i).slider({
                range: true,
                min: 0,
                max: 1440,
                step: 15,
                values: [$(".slider-range"+i).data('st'), $(".slider-range"+i).data('e')],
                nr: $(".slider-range"+i).data('nr'),
                //slide: function(e, ui) {
                    //var hours = Math.floor(ui.value / 60);
                    //var minutes = ui.value - (hours * 60);

                    //if(hours.toString().length == 1) hours = '0' + hours;
                    //if(minutes.toString().length == 1) minutes = '0' + minutes;

                    //$('.slider-time').html(hours+':'+minutes);
                //}
                create: function( event, ui ) {
                    //$( ".slider-range" ).slider( "values", 0, 55 );
                    MyCalendar.sliders[i] = $(".slider-range"+i).data('nr');
                    
                  //  console.log($(".slider-range"+i).css('display'));
                    if($(".slider-range"+i).css('display') !== 'none') {
                        updateTimes([$(".slider-range"+i).data('st'), $(".slider-range"+i).data('e')], $(this));
                    }
                    
                },
                slide: function (e, ui) {//console.log(ui, $(this).parent()[0].className);
                    updateTimes(ui.values, $(this));
                }
            });
            $(".slider-range"+i).slider('option',{nr:i});
        }
            <?smarty /if ?>
            
            
                
            $('select[name="default_view"] option[value="month"]').text(Lang.Fullcalendar.buttonText.month);
            $('select[name="default_view"] option[value="agendaWeek"]').text(Lang.Fullcalendar.buttonText.week);
            $('select[name="default_view"] option[value="agendaDay"]').text(Lang.Fullcalendar.buttonText.day);
            $('select[name="default_view"] option[value="agendaList"]').text(Lang.Fullcalendar.buttonText.agendaList);
            $('select[name="default_view"] option[value="customList"]').text(Lang.Calendar.ButtonCustomList);
            
            $('select[name="week_view_type"] option[value="agendaWeek"]').text(Lang.Options.AgendaWeekView);
            $('select[name="week_view_type"] option[value="basicWeek"]').text(Lang.Options.BasicWeekView);
            $('select[name="day_view_type"] option[value="agendaDay"]').text(Lang.Options.AgendaDayView);
            $('select[name="day_view_type"] option[value="basicDay"]').text(Lang.Options.BasicDayView);
            
            $('select[name="language"] option[value="CZ"]').text(Lang.Options.czech);
            $('select[name="language"] option[value="NL"]').text(Lang.Options.dutch);
            $('select[name="language"] option[value="EN"]').text(Lang.Options.english);
            $('select[name="language"] option[value="FR"]').text(Lang.Options.french);
            $('select[name="language"] option[value="DE"]').text(Lang.Options.german);
            $('select[name="language"] option[value="IT"]').text(Lang.Options.italian);
            $('select[name="language"] option[value="NO"]').text(Lang.Options.norwegian);
            $('select[name="language"] option[value="PL"]').text(Lang.Options.polish);
            $('select[name="language"] option[value="ES"]').text(Lang.Options.spanish);
            
            $('select[name="show_view_type"] option[value="mouseover"]').text(Lang.Options.Mouseover);
            $('select[name="show_view_type"] option[value="none"]').text(Lang.Options.None);
            
            
            
	});
        
        var getStarttime = function(number) {
            var str_time_start = '';
            var starttime = $('#dditem_timepicker_starttime-'+number).val();
            if(starttime !== '') {
                var str_date_start_tmp = new Date().format('mm/dd/yyyy') + ' ' + starttime;
                var str_time_start = new Date(str_date_start_tmp).format('HH:MM:00');
            }
            return str_time_start;
        };
        var getEndtime = function(number) {
            var str_time_end = '';
            var endtime = $('#dditem_timepicker_endtime-'+number).val();
            if(endtime !== '') {
                var str_date_end_tmp = new Date().format('mm/dd/yyyy') + ' ' + endtime;
                var str_time_end = new Date(str_date_end_tmp).format('HH:MM:00');
            }
            return str_time_end;
        };
        
        var setStringDDItems = function() {
            MyCalendar.dditem_string = '';
            $('.admin-spectrum-colorpicker-dditems').each(function(index,item) {
                var number = $(item).data('number');       
                var starttime = getStarttime(number);
                var endtime = getEndtime(number);
                
                MyCalendar.dditem_string += number + '|' + $('#admin-spectrum-colorpicker-dditem-title-'+number).val() + '|' + $('#admin-dditem-info-'+number).val() + '|' + starttime + '|' + endtime + '|' + $('#admin-dditem-nightshift-'+number).is(':checked')+ '|' + $(item).val() + ',';
            });
            $('#calendar_dditems').val(MyCalendar.dditem_string);
        };
        
        var setStringCustomDropdowns = function() {
            MyCalendar.dropdown_1_string = '';
            MyCalendar.dropdown_2_string = '';
            MyCalendar.dropdown_3_string = '';
            MyCalendar.dropdown_4_string = '';
            MyCalendar.dropdown_5_string = '';
            $('.admin-spectrum-colorpicker-dropdown_1').each(function(index,item) {
                var number = $(item).data('number');
                
                MyCalendar.dropdown_1_string += number + '|' + $('#settings-dropdown-1-option-'+number).val() + '|' + $(item).val() + ',';
            });
            $('#settings_dropdown_1').val(MyCalendar.dropdown_1_string);
            
            $('.admin-spectrum-colorpicker-dropdown_2').each(function(index,item) {
                var number = $(item).data('number');       
                
                MyCalendar.dropdown_2_string += number + '|' + $('#settings-dropdown-2-option-'+number).val() + '|' + $(item).val() + ',';
            });
            $('#settings_dropdown_2').val(MyCalendar.dropdown_2_string);
            
            $('.admin-spectrum-colorpicker-dropdown_3').each(function(index,item) {
                var number = $(item).data('number');
                
                MyCalendar.dropdown_3_string += number + '|' + $('#settings-dropdown-3-option-'+number).val() + '|' + $(item).val() + ',';
            });
            $('#settings_dropdown_3').val(MyCalendar.dropdown_3_string);
            
            $('.admin-spectrum-colorpicker-dropdown_4').each(function(index,item) {
                var number = $(item).data('number');
                
                MyCalendar.dropdown_4_string += number + '|' + $('#settings-dropdown-4-option-'+number).val() + '|' + $(item).val() + ',';
            });
            $('#settings_dropdown_4').val(MyCalendar.dropdown_4_string);
            
            $('.admin-spectrum-colorpicker-dropdown_5').each(function(index,item) {
                var number = $(item).data('number');
                
                MyCalendar.dropdown_5_string += number + '|' + $('#settings-dropdown-5-option-'+number).val() + '|' + $(item).val() + ',';
            });
            $('#settings_dropdown_5').val(MyCalendar.dropdown_5_string);
            
            
        };
    
    
        $('.admin-location-name').focusout(function(t) {
            MyCalendar.location_string = '';
            $('.admin-location-name').each(function(index,item) {
                var number = $(item).data('number');
                MyCalendar.location_string += $('#admin-location-name-'+number).val() + ',';
            });
            $('#calendar_locations').val(MyCalendar.location_string);
        });
        
        
        var arr_palette = [
            ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
            ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
            ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
            ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
            ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
            ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
            ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
            ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
        ];

        <?smarty if $active == 'profile' ?>
            $("#admin-spectrum-user-colorpicker").spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-user-colorpicker").val(color.toHexString());
                    $("#admin-spectrum-user-colorpicker").spectrum('hide');
                }
            });
            $("#admin-spectrum-user-colorpicker").val('<?smarty $profile.user_color ?>');
            $("#admin-spectrum-user-colorpicker").spectrum('set', '<?smarty $profile.user_color ?>');
        
            $('#admin_user_color_active_yes').click(function() {
                $('#user_color_field').show();
            });
            $('#admin_user_color_active_no').click(function() {
                $('#user_color_field').hide();
            });
            
        <?smarty /if ?>
        
        <?smarty if $active == 'calendar' ?>
        
        $("#admin-spectrum-colorpicker").spectrum({
            showPaletteOnly: true,
            showPalette:true,
            color: 'blanchedalmond',
            palette: arr_palette,
            change: function(color) {
                 // #ff0000
                $("#admin-spectrum-colorpicker").val(color.toHexString());
                $("#admin-spectrum-colorpicker").spectrum('hide');
            }
        });
        $("#admin-spectrum-colorpicker").val('<?smarty $calendar.calendar_color ?>');
        $("#admin-spectrum-colorpicker").spectrum('set', '<?smarty $calendar.calendar_color ?>');
        
               
        $("#calendar-textcolor-colorpicker").spectrum({
            showPaletteOnly: true,
            showPalette:true,
            color: 'blanchedalmond',
            palette: arr_palette,
            change: function(color) {
                 // #ff0000
                $("#calendar-textcolor-colorpicker").val(color.toHexString());
                $("#calendar-textcolor-colorpicker").spectrum('hide');
            }
        });
        $("#calendar-textcolor-colorpicker").val('<?smarty $calendar.calendar_textcolor ?>');
        $("#calendar-textcolor-colorpicker").spectrum('set', '<?smarty $calendar.calendar_textcolor ?>');

        // dditems colors
        <?smarty foreach from=$calendar.dditems item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>").spectrum('hide');

                    //    setStringDDItems();
                    }
                });
                $("#admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?><?smarty $calendar.calendar_color ?><?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dditem-<?smarty $item.dditem_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?><?smarty $calendar.calendar_color ?><?smarty /if ?>');

                <?smarty if !empty($item.starttime) ?>
                    var now = new Date();
                    var startdate     = new Date(now.format('mm/dd/yyyy')+ ' <?smarty $item.starttime ?>');
                    var enddate     = new Date(now.format('mm/dd/yyyy')+ ' <?smarty $item.endtime ?>');
                    
                   
                    if(MyCalendar.showAMPM) {
                        $('#dditem_timepicker_starttime-<?smarty $item.dditem_id ?>').val(dateFormat(startdate,'hh:MM TT'));
                        $('#dditem_timepicker_endtime-<?smarty $item.dditem_id ?>').val(dateFormat(enddate,'hh:MM TT'));
                    } else {
                        $('#dditem_timepicker_starttime-<?smarty $item.dditem_id ?>').val('<?smarty $item.starttime ?>');
                        $('#dditem_timepicker_endtime-<?smarty $item.dditem_id ?>').val('<?smarty $item.endtime ?>');
                    }
                <?smarty /if ?>
                
                $('#dditem_timepicker_starttime-<?smarty $item.dditem_id ?>').timepicker({
                    zindex:9999,
                    interval: MyCalendar.timePickerMinuteInterval,
                    timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
                });
                $('#dditem_timepicker_endtime-<?smarty $item.dditem_id ?>').timepicker({
                    zindex:9999,
                    interval: MyCalendar.timePickerMinuteInterval,
                    timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
                });


            <?smarty /if ?>
        <?smarty /foreach ?>

        <?smarty /if ?>

        <?smarty if $active == 'settings' ?>
        
        <?smarty if isset($settings.dropdown_1) ?>
        <?smarty foreach from=$settings.dropdown_1 item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>").spectrum('hide');
                    }
                });
                $("#admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dropdown_1-<?smarty $item.option_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');

            <?smarty /if ?>
        <?smarty /foreach ?>
        <?smarty /if ?>
        
        <?smarty if isset($settings.dropdown_2) ?>
        <?smarty foreach from=$settings.dropdown_2 item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>").spectrum('hide');
                    }
                });
                $("#admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dropdown_2-<?smarty $item.option_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');

            <?smarty /if ?>
        <?smarty /foreach ?>
        <?smarty /if ?>
        
        <?smarty if isset($settings.dropdown_3) ?>
        <?smarty foreach from=$settings.dropdown_3 item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>").spectrum('hide');
                    }
                });
                $("#admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dropdown_3-<?smarty $item.option_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');

            <?smarty /if ?>
        <?smarty /foreach ?>
        <?smarty /if ?>
        
        <?smarty if isset($settings.dropdown_4) ?>
        <?smarty foreach from=$settings.dropdown_4 item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>").spectrum('hide');
                    }
                });
                $("#admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dropdown_4-<?smarty $item.option_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');

            <?smarty /if ?>
        <?smarty /foreach ?>
        <?smarty /if ?>
        
        <?smarty if isset($settings.dropdown_5) ?>
        <?smarty foreach from=$settings.dropdown_5 item=item ?>
            <?smarty if !empty($item) ?>
                $("#admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>").spectrum({
                    showPaletteOnly: true,
                    showPalette:true,
                    color: 'blanchedalmond',
                    palette: arr_palette,
                    change: function(color) {
                         // #ff0000
                        $("#admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>").val(color.toHexString());
                        $("#admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>").spectrum('hide');
                    }
                });
                $("#admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>").val('<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');
                $("#admin-spectrum-colorpicker-dropdown_5-<?smarty $item.option_id ?>").spectrum('set', '<?smarty if $item.color !== null && !empty($item.color) ?><?smarty $item.color ?><?smarty else ?>#3366CC<?smarty /if ?>');

            <?smarty /if ?>
        <?smarty /foreach ?>
        <?smarty /if ?>
        
        <?smarty /if ?>
            
        $('#add_dditem').click(function(t) {
            MyCalendar.last_dditem ++;
            $('.table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" style="width:150px;" name="title'+MyCalendar.last_dditem+'" class="admin-dditem-title" id="admin-spectrum-colorpicker-dditem-title-'+MyCalendar.last_dditem+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" style="width:150px;" name="info'+MyCalendar.last_dditem+'" class="admin-dditem-info" id="admin-dditem-info-'+MyCalendar.last_dditem+'" value="" /></td>'+
                                    '<td style="padding:2px;border:none;"><input type="text" class="dditem_timepicker_starttime" id="dditem_timepicker_starttime-'+MyCalendar.last_dditem+'" name="starttime'+MyCalendar.last_dditem+'" style="font-size:13px;width: 80px;"></td>'+
                                    '<td style="padding:2px;border:none;"><input type="text" class="dditem_timepicker_endtime" id="dditem_timepicker_endtime-'+MyCalendar.last_dditem+'" name="endtime'+MyCalendar.last_dditem+'" style="font-size:13px;width: 80px;"></td>'+
                                    '<td style="padding:2px;border:none;"><input type="checkbox" class="dditem_timepicker_nightshift" id="admin-dditem-nightshift-'+MyCalendar.last_dditem+'" name="nightshift'+MyCalendar.last_dditem+'" style="font-size:13px;width: 80px;"></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dditems" id="admin-spectrum-colorpicker-dditem-'+MyCalendar.last_dditem+'" name="dditem_color[]" value="<?smarty $calendar.calendar_color ?>" data-title="" data-number="'+MyCalendar.last_dditem+'"></td>'+
                                '</tr>');
                        
            $('#dditem_timepicker_starttime-'+MyCalendar.last_dditem).timepicker({
                zindex:9999,
                interval: MyCalendar.timePickerMinuteInterval,
                timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
            });
            $('#dditem_timepicker_endtime-'+MyCalendar.last_dditem).timepicker({
                zindex:9999,
                interval: MyCalendar.timePickerMinuteInterval,
                timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
            });

           

            $("#admin-spectrum-colorpicker-dditem-"+MyCalendar.last_dditem).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dditem-"+MyCalendar.last_dditem).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dditem-"+MyCalendar.last_dditem).spectrum('hide');

              //      setStringDDItems();
                }
            });
            $("#admin-spectrum-colorpicker-dditem-"+MyCalendar.last_dditem).val('<?smarty $calendar.calendar_color ?>');
            $("#admin-spectrum-colorpicker-dditem-"+MyCalendar.last_dditem).spectrum('set', '<?smarty $calendar.calendar_color ?>');

        });
            
        $('#add_locationfield').click(function(t) {
            MyCalendar.last_location ++;
            $('#locationtable').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="location'+MyCalendar.last_location+'" data-number="'+MyCalendar.last_location+'" class="admin-location-name" id="admin-location-name-'+MyCalendar.last_location+'" value="" /></td>'+
                                '</tr>');


            $('.admin-location-name').focusout(function(t) {
                MyCalendar.location_string = '';
                $('.admin-location-name').each(function(index,item) {
                    var number = $(item).data('number');
                    MyCalendar.location_string += $('#admin-location-name-'+number).val() + ',';
                });
                $('#calendar_locations').val(MyCalendar.location_string);
            });
        });
     
        $('#add_dropdown_1_option_field').click(function(t) {
            MyCalendar.last_dropdown_1_option ++;
            $('#dropdown_1_table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_1_item" data-number="'+MyCalendar.last_dropdown_1_option+'" class="settings-dropdown_1_label" id="settings-dropdown-1-option-'+MyCalendar.last_dropdown_1_option+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_1" id="admin-spectrum-colorpicker-dropdown_1-'+MyCalendar.last_dropdown_1_option+'" name="dropdown_1_color" value="#3366CC" data-title="" data-number="'+MyCalendar.last_dropdown_1_option+'"></td>'+
                                '</tr>');


            $("#admin-spectrum-colorpicker-dropdown_1-"+MyCalendar.last_dropdown_1_option).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dropdown_1-"+MyCalendar.last_dropdown_1_option).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dropdown_1-"+MyCalendar.last_dropdown_1_option).spectrum('hide');

              //      setStringDDItems();
                }
            });
            $("#admin-spectrum-colorpicker-dropdown_1-"+MyCalendar.last_dropdown_1_option).val('#3366cc');
            $("#admin-spectrum-colorpicker-dropdown_1-"+MyCalendar.last_dropdown_1_option).spectrum('set', '#3366cc');
            
            $('#settings-dropdown-1-option-'+MyCalendar.last_dropdown_1_option).focus();
        });
        
        $('#add_dropdown_2_option_field').click(function(t) {
            MyCalendar.last_dropdown_2_option ++;
            $('#dropdown_2_table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_2_item" data-number="'+MyCalendar.last_dropdown_2_option+'" class="settings-dropdown_2_label" id="settings-dropdown-2-option-'+MyCalendar.last_dropdown_2_option+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_2" id="admin-spectrum-colorpicker-dropdown_2-'+MyCalendar.last_dropdown_2_option+'" name="dropdown_2_color" value="#3366CC" data-title="" data-number="'+MyCalendar.last_dropdown_2_option+'"></td>'+
                                '</tr>');


            $("#admin-spectrum-colorpicker-dropdown_2-"+MyCalendar.last_dropdown_2_option).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dropdown_2-"+MyCalendar.last_dropdown_2_option).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dropdown_2-"+MyCalendar.last_dropdown_2_option).spectrum('hide');

              //      setStringDDItems();
                }
            });
            $("#admin-spectrum-colorpicker-dropdown_2-"+MyCalendar.last_dropdown_2_option).val('#3366cc');
            $("#admin-spectrum-colorpicker-dropdown_2-"+MyCalendar.last_dropdown_2_option).spectrum('set', '#3366cc');
            
            $('#settings-dropdown-2-option-'+MyCalendar.last_dropdown_2_option).focus();
        });
        
        $('#add_dropdown_3_option_field').click(function(t) {
            MyCalendar.last_dropdown_3_option ++;
            $('#dropdown_3_table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_3_item" data-number="'+MyCalendar.last_dropdown_3_option+'" class="settings-dropdown_3_label" id="settings-dropdown-3-option-'+MyCalendar.last_dropdown_3_option+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_3" id="admin-spectrum-colorpicker-dropdown_3-'+MyCalendar.last_dropdown_3_option+'" name="dropdown_3_color" value="#3366CC" data-title="" data-number="'+MyCalendar.last_dropdown_3_option+'"></td>'+
                                '</tr>');

            $("#admin-spectrum-colorpicker-dropdown_3-"+MyCalendar.last_dropdown_3_option).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dropdown_3-"+MyCalendar.last_dropdown_3_option).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dropdown_3-"+MyCalendar.last_dropdown_3_option).spectrum('hide');
                }
            });
            $("#admin-spectrum-colorpicker-dropdown_3-"+MyCalendar.last_dropdown_3_option).val('#3366cc');
            $("#admin-spectrum-colorpicker-dropdown_3-"+MyCalendar.last_dropdown_3_option).spectrum('set', '#3366cc');
            
            $('#settings-dropdown-3-option-'+MyCalendar.last_dropdown_3_option).focus();
        });
        
        $('#add_dropdown_4_option_field').click(function(t) {
            MyCalendar.last_dropdown_4_option ++;
            $('#dropdown_4_table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_4_item" data-number="'+MyCalendar.last_dropdown_4_option+'" class="settings-dropdown_4_label" id="settings-dropdown-4-option-'+MyCalendar.last_dropdown_4_option+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_4" id="admin-spectrum-colorpicker-dropdown_4-'+MyCalendar.last_dropdown_4_option+'" name="dropdown_4_color" value="#3366CC" data-title="" data-number="'+MyCalendar.last_dropdown_4_option+'"></td>'+
                                '</tr>');

            $("#admin-spectrum-colorpicker-dropdown_4-"+MyCalendar.last_dropdown_4_option).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dropdown_4-"+MyCalendar.last_dropdown_4_option).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dropdown_4-"+MyCalendar.last_dropdown_4_option).spectrum('hide');
                }
            });
            $("#admin-spectrum-colorpicker-dropdown_4-"+MyCalendar.last_dropdown_4_option).val('#3366cc');
            $("#admin-spectrum-colorpicker-dropdown_4-"+MyCalendar.last_dropdown_4_option).spectrum('set', '#3366cc');
            
            $('#settings-dropdown-4-option-'+MyCalendar.last_dropdown_4_option).focus();
        });
        
        
        $('#add_dropdown_5_option_field').click(function(t) {
            MyCalendar.last_dropdown_5_option ++;
            $('#dropdown_5_table').append('<tr>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" name="dropdown_5_item" data-number="'+MyCalendar.last_dropdown_5_option+'" class="settings-dropdown_5_label" id="settings-dropdown-5-option-'+MyCalendar.last_dropdown_5_option+'" value="" /></td>'+
                                    '<td style="width:50px;border:none;padding:2px;"><input type="text" class="input-xlarge admin-spectrum-colorpicker-dropdown_5" id="admin-spectrum-colorpicker-dropdown_5-'+MyCalendar.last_dropdown_5_option+'" name="dropdown_5_color" value="#3366CC" data-title="" data-number="'+MyCalendar.last_dropdown_5_option+'"></td>'+
                                '</tr>');

            $("#admin-spectrum-colorpicker-dropdown_5-"+MyCalendar.last_dropdown_5_option).spectrum({
                showPaletteOnly: true,
                showPalette:true,
                color: 'blanchedalmond',
                palette: arr_palette,
                change: function(color) {
                     // #ff0000
                    $("#admin-spectrum-colorpicker-dropdown_5-"+MyCalendar.last_dropdown_5_option).val(color.toHexString());
                    $("#admin-spectrum-colorpicker-dropdown_5-"+MyCalendar.last_dropdown_5_option).spectrum('hide');
                }
            });
            $("#admin-spectrum-colorpicker-dropdown_5-"+MyCalendar.last_dropdown_5_option).val('#3366cc');
            $("#admin-spectrum-colorpicker-dropdown_5-"+MyCalendar.last_dropdown_5_option).spectrum('set', '#3366cc');
            
            $('#settings-dropdown-5-option-'+MyCalendar.last_dropdown_5_option).focus();
        });
        
        $('#save-calendar').click(function() {
            setStringDDItems();
            
        });
        
        $('#save-settings').click(function() {
            setStringCustomDropdowns();
            
        });
        
        //$('#calendar_save_form').submit(function(evt) {
        //    evt.preventDefault();
        //    evt.stopImmediatePropagation();
        //    setStringDDItems();
           // $('#calendar_save_form').submit();
        //});
        
        
      
        
        <?smarty if $calendar.share_type == "public" ?>
            $('#admin_calendar_share_type').val('<?smarty $calendar.share_type ?>');
        <?smarty /if ?>
        
        <?smarty if $calendar.origin == "default" ?>
            $('#admin_calendar_origin').val('<?smarty $calendar.origin ?>');
        <?smarty /if ?>
        
        $('.admin_user_profile_title_label').html(Lang.Popup.LabelSalutation);
        $('.admin_user_profile_phone_label').html(Lang.Popup.EventPhone);
        $('#admin_profile_user_active_label').html(Lang.Popup.LabelActive);
        $('.admin_user_title_label').html(Lang.Popup.LabelTitle);
        $('.admin_user_profile_name_label').html(Lang.Popup.LabelName);
        $('.admin_user_profile_email_label').html(Lang.Popup.LabelEmail);
        $('.admin_user_profile_username_label').html(Lang.Popup.LabelUsername);
        $('.admin_user_profile_birthdate_label').html(Lang.Popup.LabelBirthdate);
        $('#admin_user_profile_country_label').html(Lang.Popup.LabelCountry);
        $('.admin_user_profile_new_password_label').html(Lang.Popup.LabelNewPassword);
        $('.admin_user_profile_new_password2_label').html(Lang.Popup.LabelNewPasswordAgain);
        $('#admin_user_profile_info_label').html(Lang.Calendar.LabelInfo);
        $('#admin_settings_calendars_label').html(Lang.Popup.LabelCalendar);
           

        $('.color_label').html(Lang.Label.Color);
        $(".show_filter_label").html(Lang.Calendar.ShowFilter);
        $('.add_an_item_btn').attr('value', Lang.Button.AddAnItem);
        $('.next_days_visible_label').html(Lang.Label.UsersCanSeeNext);
        $('#settings_calendar_title_label').html(Lang.Calendar.CalendarTitle);
        $('#topbar_cal_logo_or_title_label').html(Lang.Calendar.CalendarLogoOrTitle);
        $('.admin_user_profile_password_label').html(Lang.Popup.LabelPassword);
        $('#quick_add_user_label').html(Lang.Menu.TitleQuickAdduser);
        
        
        
        $('#admin_users_menu').html(Lang.Menu.TitleUsers);
        $('#admin_add_user_menu').html(Lang.Menu.TitleAddUser);
        $('#admin_quick_add_user_menu').html(Lang.Menu.TitleQuickAdduser);
        $('#admin_quick_add_admin_menu').html(Lang.Menu.TitleQuickAddAdmin);
        $('#admin_admins_menu').html(Lang.Menu.TitleAdmins);
        $('#admin_settings_menu').html(Lang.Menu.TitleSettings);
        $('#admin_calendars_menu').html(Lang.Menu.TitleCalendars);
        $('.admin_my_calendars_menu').html(Lang.Menu.TitleMyCalendars);
        $('#admin_hour_calculation_menu').html(Lang.Menu.TitleHourCalculation);
        
        $('#admin_add_group_menu').html(Lang.Button.AddGroup);
        
        $('#usergroup_dditems_info').html(Lang.Calendar.LabelUserGroupInfo);
        $('#custom_dditems_info').html(Lang.Calendar.LabelCustomDDItemInfo);
     
        $('#admin_hour_calculation_menu').html(Lang.Menu.TitleHourCalculation);
        $('#admin_settings_legend').html(Lang.Settings.Legend);
        $('#admin_users_legend').html(Lang.Menu.TitleUsers);
        $('#admin_settings_hour_calculation_legend').html(Lang.Hourcalculation.legend);
        $('#admin_settings_user_hour_calculation_legend').html(Lang.Hourcalculation.legendOfUser);
        $('#admin_settings_info_text').html(Lang.Settings.Infotext);
        $('#admin_settings_language_label').html(Lang.Settings.LabelLanguage);
        $('#admin_settings_defaultview_label').html(Lang.Settings.DefaultView);
        $('#admin_settings_week_view_type_label').html(Lang.Settings.LabelWeekViewType);
        $('#admin_settings_day_view_type_label').html(Lang.Settings.LabelDayViewType);
        $('#admin_settings_other_language_label').html(Lang.Settings.LabelOtherLanguage);
        $('#admin_show_am_pm_checkbox_label').html(Lang.Settings.LabelShowAmPm);
        $('#admin_show_weeknumbers_checkbox_label').html(Lang.Settings.LabelShowWeeknumbers);
        $('#admin_show_notallowed_messages_checkbox_label').html(Lang.Settings.LabelShowNotAllowedMessages);
        $('#admin_settings_mouseover_popup_label').html(Lang.Settings.LabelMouseoverPopup);
        $('#admin_truncate_title_checkbox_label').html(Lang.Settings.LabelTruncateTitle);
        $('#admin_settings_truncate_length_label').html(Lang.Settings.LabelTitleLength);
        $('#admin_settings_edit_dialog_label').html(Lang.Settings.LabelEditDialog);
        $('#admin_settings_two_capitals_label').html(Lang.Settings.LabelTwoCapitals);
        $('#admin_settings_amount_of_characters_label').html(Lang.Settings.LabelAmountOfCharacters);
        $('#admin_settings_colorpicker_type_label').html(Lang.Settings.LabelColorPickerType);
        $('#admin_settings_timepicker_type_label').html(Lang.Settings.LabelTimePickerType);
        $('#admin_show_description_in_edit_dialog_checkbox_label').html(Lang.Settings.LabelShowDescription);
        $('#admin_show_location_in_edit_dialog_checkbox_label').html(Lang.Settings.LabelShowLocation);
        $('#admin_show_phone_in_edit_dialog_checkbox_label').html(Lang.Settings.LabelShowPhone);
        $('#admin_show_url_in_edit_dialog_checkbox_label').html(Lang.Settings.LabelShowUrl);
        $('#admin_show_delete_confirm_dialog_checkbox_label').html(Lang.Settings.LabelShowDeleteConfirmDialog);
        $('#admin_settings_hour_calculation_label').html(Lang.Settings.LabelHourcalculation);
        $('#admin_settings_workday_hours_label').html(Lang.Settings.LabelWorkdayHours);
        $('#admin_settings_default_period_label').html(Lang.Settings.LabelDefaultPeriod);
        $('#admin_settings_amount_of_hours_label').html(Lang.Settings.LabelWorkdayHoursInfo);
        $('#admin_settings_initial_period_label').html(Lang.Settings.LabelDefaultPeriodInfo);
        $('#admin_settings_registration_label').html(Lang.Settings.LabelRegistration);
        $('#admin_settings_registration_info_label').html('USERS_CAN_REGISTER ' + Lang.Settings.LabelRegistrationInfo);
        $('#admin_send_activation_mail_checkbox_label').html(Lang.Settings.LabelSendActivationMail);
        $('#assign_to_users_label').html(Lang.Calendar.LabelAssignToUsers);
        $('#admin_show_teammember_in_edit_dialog_checkbox_label').html(Lang.Calendar.LabelShowTeamMember);
            
    
        $('#menu_logout').text(Lang.Menu.TitleLogout);
        $('#active_label').text(Lang.Calendar.LabelActive);
        $('#yes_label').text(Lang.Label.Yes);
        $('#no_label').text(Lang.Label.No);
        $('#active_period_label').text(Lang.Calendar.LabelActivePeriod);
        $('#alterable_period_label').text(Lang.Calendar.LabelAlterablePeriod);
        $('#in_specific_period_label').text(Lang.Calendar.LabelInSpecificPeriod);
        $('.name_label').text(Lang.Calendar.LabelName);
        $('.days_label').html(Lang.Calendar.LabelDays);
        $('.hours_label').html(Lang.Calendar.LabelHours);
        $('.date_label').html(Lang.Calendar.LabelDate);
        $('.time_label').html(Lang.Calendar.LabelTime);
        $('.calendar_label').html(Lang.Calendar.LabelCalendar);
        $('.username_label').html(Lang.Calendar.LabelUsername);
        $('.email_label').html(Lang.Calendar.LabelEmail);
        $('.registration_date_label').html(Lang.Calendar.LabelRegistrationDate);
        $('.active_label').html(Lang.Calendar.LabelActive);
        $('.count_users_label').html(Lang.Calendar.LabelCountUsers);
        $('.owner_label').html(Lang.Calendar.LabelOwner);
        $('.origin_label').html(Lang.Calendar.LabelOrigin);
        $('.canseedditems_label').html(Lang.Calendar.LabelCanSeeDDItems);
        $('.type_label').html(Lang.Calendar.LabelType);
        $('.add_label').html(Lang.Calendar.LabelAdd);
        $('.edit_label').html(Lang.Calendar.LabelEdit);
        $('.delete_label').html(Lang.Calendar.LabelDelete);
        $('.changecolor_label').html(Lang.Calendar.LabelChangeColor);
        $('.initialshow_label').html(Lang.Calendar.LabelInitialShow);
        $('.view_label').html(Lang.Calendar.LabelView);
		
                                                
        $('#dd_items_label').text(Lang.Calendar.LabelDDItemsCalForm);
        $('#admin_usergroup_dditems_label').text(Lang.Calendar.LabelUsergroupDDItems);
        
        $('#title_label').text(Lang.Calendar.LabelTitle);
        $('#info_label').text(Lang.Calendar.LabelInfo);
        $('#starttime_label').text(Lang.Calendar.LabelStarttime);
        $('#endtime_label').text(Lang.Calendar.LabelEndtime);
        $('#nightshift_label').text(Lang.Calendar.LabelNightShift);
        $('.backgroundcolor_label').text(Lang.Label.BackgroundColor);
        $('.textcolor_label').text(Lang.Label.TextColor);
        $('#add_dditem').val(Lang.Button.AddDDItem);
        $('#admin_can_see_dditems_label').text(Lang.Calendar.LabelCanSeeDDItems);
        $('#admin_share_type_label').text(Lang.Calendar.LabelShareType);
        $('.others_label').text(Lang.Calendar.LabelOthers);
        $('#can_add_label').text(Lang.Calendar.LabelCanAdd);
        $('#can_view_own_assigned_label').text(Lang.Calendar.LabelCanViewOwnAssigned);
        $('#can_edit_label').text(Lang.Calendar.LabelCanEdit);
        $('#can_delete_label').text(Lang.Calendar.LabelCanDelete);
        $('#can_change_color_label').text(Lang.Calendar.LabelCanChangeColor);
        $('#admin_default_calendar_label').text(Lang.Calendar.LabelDefaultCalendar);
        $('#event_location_label').text(Lang.Calendar.LabelEventLocation);
        $('#use_color_for_all_events_label').text(Lang.Calendar.LabelUseColorForAllEvents);
        $('#predefined_locations_label').text(Lang.Calendar.LabelPredefinedLocations);
        $('#add_locationfield').val(Lang.Button.AddLocation); 
        $('#notifications_label').text(Lang.Calendar.LabelNotifications);
        $('#manually_label').text(Lang.Calendar.LabelManually);
        $('#automatic_label').text(Lang.Calendar.LabelAutomatic);
        $('#manually_info_label').text(Lang.Calendar.LabelManuallyInfo);
        $('#automatic_info_label').text(Lang.Calendar.LabelAutomaticInfo);
        $('#calendar_admin_email_label').text(Lang.Calendar.LabelCalendarAdminEmail + ' (#1;#2)');
        $('#when_admin_email_is_empty_info').text(Lang.Calendar.LabelWhenAdminEmailEmptyInfo);
        $('.save').html(Lang.Popup.saveButtonText); 
        $('#add_calendar_label').text(Lang.Calendar.LabelAddCalendar);
        
        $('#admin_pdf_table_look_checkbox_label').html(Lang.Calendar.LabelTableLook);
        $('#admin_pdf_show_time_columns_checkbox_label').html(Lang.Calendar.LabelShowTimeColumns);
        $('#admin_pdf_show_date_on_every_line_checkbox_label').html(Lang.Calendar.LabelShowDateOnEveryLine);
        $('#admin_pdf_show_logo_checkbox_label').html(Lang.Calendar.LabelShowLogo);
        $('#admin_pdf_show_custom_dropdown_values_checkbox_label').html(Lang.Calendar.LabelShowCustomDropdownValues);
        
        $('.print_btn').html(Lang.Button.print);
        $('.calendar_btn').html(Lang.Popup.LabelCalendar);
    
        $('#admin_pdf_fontweight_bold_checkbox_label').html(Lang.Calendar.LabelFontWeightBold);
        $('#admin_pdf_colored_rows_checkbox_label').html(Lang.Calendar.LabelRowColorsGrayWhite);
        $('#admin_pdf_sorting_checkbox_label').html(Lang.Calendar.LabelSorting);
        $('#admin_settings_pdf_export_label').html(Lang.Calendar.LabelPdfExport);
        $('#admin_pdf_pagination_translation').html(Lang.Calendar.LabelPaginationTranslation);
        $('.admin_label_page').html(Lang.Calendar.LabelPage);
        $('.admin_label_of').html(Lang.Calendar.LabelOf);
        $('#admin_pdf_column_names').html(Lang.Calendar.LabelColumnNames);
        $('#admin_label_date_column').html(Lang.Calendar.LabelDateColumn);
        $('#admin_label_start_time_column').html(Lang.Calendar.LabelStartTimeColumn);
        $('#admin_label_end_time_column').html(Lang.Calendar.LabelEndTimeColumn);
        $('#admin_label_event_title_column').html(Lang.Calendar.LabelEventTitleColumn);
        
        $('#add-group-btn').html(Lang.Button.AddGroup);
        $('#add-user-btn').html(Lang.Menu.TitleAdduser);
        $('#quick_add-user-btn').html(Lang.Menu.TitleQuickAdduser);
        $('#dates_refresh_button').html(Lang.Button.Refresh);
        $('#user_dates_refresh_button').html(Lang.Button.Refresh);
        $('#add-availability-btn').html(Lang.Button.AddAvailability);
        
        $('#users_search_button').val(Lang.Button.search);
        
        $('.edit_btn').html(Lang.Popup.editButtonText);
        $('.delete_btn').html(Lang.Popup.deleteButtonText);
        $('.admins_lable').html(Lang.Menu.TitleAdmins);
        $('.users_lable').html(Lang.Menu.TitleUsers);
        $('.groups_lable').html(Lang.Menu.TitleGroups);
        $('.my_groups_lable').html(Lang.Menu.TitleMyGroups);
        $('.availability_label').html(Lang.Menu.TitleAvailability);
        
        $('#add-calendar-btn').html(Lang.Button.addCalendar);
        
        $('.simple_endtime_label').html(Lang.Popup.SimpleEndTimeLabel);
        $('.simple_starttime_label').html(Lang.Popup.SimpleStartTimeLabel );

        
        $('#availability_monday_label').html(Lang.Fullcalendar.dayNames[1]);
        $('#availability_tuesday_label').html(Lang.Fullcalendar.dayNames[2]);

        $('#admin_add_availability_menu').html(Lang.Menu.TitleAddAvailability);
        $('#admin_import_users_menu').html(Lang.Menu.TitleImportUsers);

        $('.menu_profile').text(Lang.Menu.TitleProfile);
        $('.menu_my_calendars').text(Lang.Popup.MycalendarTitle);
        $('.menu_settings').text(Lang.Menu.TitleSettings);
        $('.menu_logout').text(Lang.Menu.TitleLogout);
              

        //initialize the pqSelect widget.
        $("#admin_user_selectbox").pqSelect({
           // multiplePlaceholder: 'Select Regions',
            checkbox: true, //adds checkbox to options  
            width: 500,
            height: 100,
            maxSelect: 0,
            maxDisplay: 100,
            multiplePlaceholder: '<?smarty $smarty.const.AVAILABLE_EMPLOYEES_DROPDOWN_EMPTYTEXT ?>'
            //selectallText: ''
        }).on("change", function(evt) {
            var val = $(this).val();
           // alert(val);
        });


       // $( "#admin_user_selectbox" ).pqSelect( "open" );

	</script>
       
  </body>
</html>