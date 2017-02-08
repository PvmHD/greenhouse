
$(document).ready(function () {

    CustomView.addCalendar = function(cal_id) {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        CustomView.CurrentCalendars = ',' + CustomView.CurrentCalendars + ',';
        
        
        if ($('#calgroup' + cal_id).hasClass('tick_off')) {
            // only add if not yet in string
            if (CustomView.CurrentCalendars.indexOf(','+cal_id+',') == -1) {
               // if(CustomView.CurrentCalendars !== '') {
               //     CustomView.CurrentCalendars = CustomView.CurrentCalendars + ',';
               // }

                CustomView.CurrentCalendars = CustomView.CurrentCalendars + cal_id ;
            }
            $('#calgroup' + cal_id).removeClass('tick_off').addClass('tick_on');


        } else {
            // remove the calendar from current calendars
            CustomView.CurrentCalendars = CustomView.CurrentCalendars.replace(',' + cal_id + ',', ',');

            $('#calgroup' + cal_id).removeClass('tick_on').addClass('tick_off');
        }
        
        // get rid of extra commas
        if (CustomView.CurrentCalendars.substring(0, 1) == ',') {
            CustomView.CurrentCalendars = CustomView.CurrentCalendars.substring(1);
        }
        if (CustomView.CurrentCalendars.charAt(CustomView.CurrentCalendars.length - 1) == ',') {
            CustomView.CurrentCalendars = CustomView.CurrentCalendars.slice(0, -1);
        }
                          
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars+'&from=' + agenda_start + '&to=' + agenda_end;
    };


    CustomView.openCalendar = function(cal_id) {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        if(cal_id == 'all') {
            CustomView.CurrentCalendars = CustomView.AllCalendars;
        } else {
            CustomView.CurrentCalendars = cal_id ;
        }
     
        
                            
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars+'&from=' + agenda_start + '&to=' + agenda_end;
    };
    
    CustomView.getNewCurrentDropdownOptions = function () {
        //if (!CustomView.showCustomDropdowns) {
        //    CustomView.currentDropdownOptions = '';
        //} else {
            if (CustomView.currentDropdown2Options === undefined) {
                CustomView.currentDropdown2Options = '';
            }
            if (CustomView.currentDropdown1Options === undefined) {
                CustomView.currentDropdown1Options = '';
            }

            if (CustomView.currentDropdown1Options !== '' && CustomView.currentDropdown2Options !== '') {
                CustomView.currentDropdownOptions = CustomView.currentDropdown1Options + ',' + CustomView.currentDropdown2Options;
            } else if (CustomView.currentDropdown1Options == '' || CustomView.currentDropdown2Options == '') {
                CustomView.currentDropdownOptions = CustomView.currentDropdown1Options + CustomView.currentDropdown2Options;
            } else {
                
            }
            
        //}

        return CustomView.currentDropdownOptions;
    }
    
    CustomView.removeOptionFromFilter = function (drd_number, option_id) {
        if (drd_number == 1) {
            // remove the id from MyCalendar.currentDropdownOptions
            if (CustomView.currentDropdown1Options.indexOf(',') > 0) {
                CustomView.currentDropdown1Options = ',' + CustomView.currentDropdown1Options + ',';
                CustomView.currentDropdown1Options = CustomView.currentDropdown1Options.replace(',' + option_id + ',', ',');
                if (CustomView.currentDropdown1Options.charAt(0) == ',') {
                    CustomView.currentDropdown1Options = CustomView.currentDropdown1Options.substring(1);
                }
                if (CustomView.currentDropdown1Options.charAt(CustomView.currentDropdown1Options.length - 1) == ',') {
                    CustomView.currentDropdown1Options = CustomView.currentDropdown1Options.slice(0, -1);
                }
            } else {
                if (CustomView.currentDropdown1Options == option_id) {
                    CustomView.currentDropdown1Options = '';
                }
            }
        }
        if (drd_number == 2) {
            // remove the id from MyCalendar.currentDropdownOptions
            if (CustomView.currentDropdown2Options.indexOf(',') > 0) {
                CustomView.currentDropdown2Options = ',' + CustomView.currentDropdown2Options + ',';
                CustomView.currentDropdown2Options = CustomView.currentDropdown2Options.replace(',' + option_id + ',', ',');
                if (CustomView.currentDropdown2Options.charAt(0) == ',') {
                    CustomView.currentDropdown2Options = CustomView.currentDropdown2Options.substring(1);
                }
                if (CustomView.currentDropdown2Options.charAt(CustomView.currentDropdown2Options.length - 1) == ',') {
                    CustomView.currentDropdown2Options = CustomView.currentDropdown2Options.slice(0, -1);
                }
            } else {
                if (CustomView.currentDropdown2Options == option_id) {
                    CustomView.currentDropdown2Options = '';
                }
            }
        }
    }
    
    CustomView.addCustomOption = function (option_id, option_name, drd_number) {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        if ($('#dropdown_group' + option_id).hasClass('dropdown_' + drd_number + '_tick_off')) {
            // it was tick_of, turn it in to tick_on

            if (drd_number == 1) {
                if (CustomView.currentDropdown1Options === '') {
                    CustomView.currentDropdown1Options += option_id;
                } else {
                    CustomView.currentDropdown1Options += ',' + option_id;
                }
            }
            if (drd_number == 2) {
                if (CustomView.currentDropdown2Options === '') {
                    CustomView.currentDropdown2Options += option_id;
                } else {
                    CustomView.currentDropdown2Options += ',' + option_id;
                }
            }
            $('#dropdown_group' + option_id).removeClass('dropdown_' + drd_number + '_tick_off').addClass('dropdown_' + drd_number + '_tick_on');

        } else {
            // it was tick_on, so make it tick_off
            $('#dropdown_group' + option_id).removeClass('dropdown_' + drd_number + '_tick_on').addClass('dropdown_' + drd_number + '_tick_off');

            CustomView.removeOptionFromFilter(drd_number, option_id);
        }

        CustomView.currentDropdownOptions = CustomView.getNewCurrentDropdownOptions();
        
        setTimeout(function() {
            window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars+'&option_id='+ CustomView.currentDropdownOptions +'&from=' + agenda_start + '&to=' + agenda_end;

        },100); 
    };
    
    var addOption = function(option_id, drd_number) {
        if (drd_number == 1) {
            if (CustomView.currentDropdown1Options === '') {
                CustomView.currentDropdown1Options += option_id;
            } else {
                CustomView.currentDropdown1Options = ',' + CustomView.currentDropdown1Options + ',';

                if(CustomView.currentDropdown1Options.indexOf(','+option_id+',') == -1) {
                    CustomView.currentDropdown1Options += option_id;
                }
                if (CustomView.currentDropdown1Options.charAt(CustomView.currentDropdown1Options.length - 1) == ',') {
                    CustomView.currentDropdown1Options = CustomView.currentDropdown1Options.slice(0, -1);
                }
                if (CustomView.currentDropdown1Options.charAt(0) == ',') {
                    CustomView.currentDropdown1Options = CustomView.currentDropdown1Options.substring(1);
                }
            }
        }
        if (drd_number == 2) {
            if (CustomView.currentDropdown2Options === '') {
                CustomView.currentDropdown2Options += option_id;
            } else {
                CustomView.currentDropdown2Options = ',' + CustomView.currentDropdown2Options + ',';

                if(CustomView.currentDropdown2Options.indexOf(','+option_id+',') == -1) {
                    CustomView.currentDropdown2Options += option_id;
                }
                if (CustomView.currentDropdown2Options.charAt(CustomView.currentDropdown2Options.length - 1) == ',') {
                    CustomView.currentDropdown2Options = CustomView.currentDropdown2Options.slice(0, -1);
                }
                if (CustomView.currentDropdown2Options.charAt(0) == ',') {
                    CustomView.currentDropdown2Options = CustomView.currentDropdown2Options.substring(1);
                }

            }
        }
    };
    
    CustomView.openCustomOption = function (option_id, option_name, drd_number) {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();


        if(option_id == 'all') {
            $('.dropdown_' + drd_number + '_tick_off').each(function (index, item) {
                
                $('#dropdown_group' + $(item).attr('option_id')).removeClass('dropdown_' + drd_number + '_tick_off').addClass('dropdown_' + drd_number + '_tick_on');
            
                addOption($(item).attr('option_id'), drd_number);
            });
            
        } else {
            
            $('.dropdown_' + drd_number + '_tick_on').each(function (index, item) {
                if($(item).attr('dropdown') == drd_number) {
                    $('#dropdown_group' + $(item).attr('option_id')).removeClass('dropdown_' + drd_number + '_tick_on').addClass('dropdown_' + drd_number + '_tick_off');
                
                    CustomView.removeOptionFromFilter(drd_number, $(item).attr('option_id'));

                    
                }
                
            });
             
            addOption(option_id, drd_number);
       
            
            
        }
        
        CustomView.currentDropdownOptions = CustomView.getNewCurrentDropdownOptions();
        
        setTimeout(function() {
            window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars+'&option_id='+ CustomView.currentDropdownOptions +'&from=' + agenda_start + '&to=' + agenda_end;

        },100);         
       
    };
    
    $('#listview_back').click(function() {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        var to = $(this).data('to');
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars + '&option_id='+ CustomView.getNewCurrentDropdownOptions() + '&sort='+ CustomView.CurrentSort + '&to=' + to;

    });
    
    $('#listview_forward').click(function() {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        var from = $(this).data('from');
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars + '&option_id='+ CustomView.getNewCurrentDropdownOptions() + '&sort='+ CustomView.CurrentSort + '&from=' + from;

    });
    
    $('#listview_sort_cal').click(function() {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        CustomView.CurrentSort = $(this).data('sort');
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars + '&option_id='+ CustomView.getNewCurrentDropdownOptions() + '&sort='+ CustomView.CurrentSort + '&from=' + agenda_start + '&to=' + agenda_end;

    });
    
    $('#listview_sort_time').click(function() {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        CustomView.CurrentSort = $(this).data('sort');
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars + '&option_id='+ CustomView.getNewCurrentDropdownOptions() + '&sort='+ CustomView.CurrentSort + '&from=' + agenda_start + '&to=' + agenda_end;

    });
    
    
    $('#agenda_refresh_btn').click(function() {
        var agenda_start = $('#agenda_datepicker_startdate').val();
        var agenda_end = $('#agenda_datepicker_enddate').val();

        var sort = CustomView.CurrentSort || 'time';
        window.location = MyCalendar.FULLCAL_URL+'/?action=agenda&cid='+CustomView.CurrentCalendars + '&sort='+ sort + '&from=' + agenda_start + '&to=' + agenda_end;

    });
    
    $('#custom_view_go_to_calendar').click(function() {
       // window.location = MyCalendar.FULLCAL_URL+'/?cid='+CustomView.CurrentCalendars;
        $('#go_to_calendar_cid').val(CustomView.CurrentCalendars);
        $('#go_to_calendar_fa').val(1);
        $('#go_to_calendar_form').submit();
    });
    
    $('#dd').click(function (t) {
        $('#menu_to_profile').text(Lang.Menu.TitleProfile);
        $('#menu_my_calendars').text(Lang.Menu.TitleMyCalendars);
        $('#menu_add_user').text(MyCalendar.isSuperAdmin ? Lang.Menu.TitleAddAdmin : Lang.Menu.TitleAdduser);
        $('#menu_quick_add_user').text(MyCalendar.isSuperAdmin ? Lang.Menu.TitleQuickAddAdmin : Lang.Menu.TitleQuickAdduser);
        $('#menu_logout').text(Lang.Menu.TitleLogout);
        $('#menu_settings').text(Lang.Menu.TitleSettings);
        $('#menu_admin_area').text(Lang.Menu.TitleAdminArea);
    });
    
    var customviewUpdateEvent = function (event, bln_repair_pattern, me) {



        var title = $('#customview_edited_title').val();
        var location = $('#customview_edited_location').val();
        var phone = $('#customview_edited_phone').val();
        var description = $('#customview_edited_description').val();
        //var location = '';
        
//        if (MyCalendar.locations !== undefined && MyCalendar.locations !== '' && MyCalendar.locations[0] !== undefined) {
//            location = $('#location_combo option:selected').val();
//        } else {
//            if ($('#edited_location') !== undefined) {
//                location = $('#edited_location').val();
//            }
//        }
//
//        if ($('#customview_edited_description') !== undefined) {
//            var description = $('#customview_edited_description').val();
//        }
//        if ($('#customview_edited_phone') !== undefined) {
//            var phone = $('#customview_edited_phone').val();
//        }
        
        if (title != null && title != '') {
            event.title = title;
            event.location = location;
            event.description = description;
            event.phone = phone;
            
            
            var calendar_id = -1;
            if ($('#customview_edit_dlg_calendar_selectbox') !== undefined) {
                calendar_id = $('#customview_edit_dlg_calendar_selectbox').val();
            }
            
            var team_member_id = -1;
            if ($('#customview_edit_dlg_user_selectbox') !== undefined) {
                team_member_id = $('#customview_edit_dlg_user_selectbox').val();
            }
            
            
            var data = {
                    event_id: event.event_id,
                    
                    title: event.title,
                    location: event.location,
                    description: event.description,
                    phone: event.phone,
                    
                    cal_id: event.calendar_id, //MyCalendar.currentCalendar
                    calendar_id: calendar_id,
                    team_member_id: team_member_id
                    
                };
             
            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=customview_update',
                data: data,
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        me.dialog("close");

                        window.location = MyCalendar.FULLCAL_URL + '/?action=agenda';


                    } else {
                        if (result.notloggedin) {

                            alert('You are not logged in');
                            window.location = MyCalendar.FULLCAL_URL;
                        } else {
                            //alert(Lang.Alert.ErrorSaving);
                            $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                        }
                    }

                }
            });
            
        }
        

    };
    
    $('.agenda_item').click(function(a) {
        
        var event = {
            event_id: $(this).data('event-id'),
            title: $(this).data('title'),
            location: $(this).data('location'),
            phone: $(this).data('phone'),
            description: $(this).data('description'),
            calendar_id: $(this).data('calendar-id'),
            editable: $(this).data('editable'),
            allowEdit: $(this).data('allowEdit')
        }
        
        // 1. simple_edit dialog, 2. go to monthview and emphasize, 3. goto monthview in new tab, emphasize and open edit dialog
        
        if(MyCalendar.actionOnClickEventInCustomListview == 1) {
            $('#customview_edited_title').val(event.title);
            $('#customview_edited_location').val(event.location);
            $('#customview_edited_phone').val(event.phone);
            $('#customview_edit_dlg_calendar_selectbox').val(event.calendar_id);
            $('#customview_edited_description').val(event.description);
            


            // open edit dialog
            $("#dialog-message-custom-view").dialog({
                modal: true,
                title: (event.rep_event !== undefined ? Lang.Popup.EditRecurringEvent : Lang.Popup.TitleEdit), // + (event.updateThisItem ? ' (this item)' : ' (whole pattern)') : Lang.Popup.TitleEdit),
                //height: 'auto',
                //width: 'auto',
                height: 'auto', //MyCalendar.showLocationField ? 460 : 430,
                width: 690,
                minHeight: 300,
                resizable: MyCalendar.dialogsResizable || false,
                buttons: [
                    {
                        html: Lang.Popup.updateButtonText,
                        id: 'customview_updatebtn',
                       // disabled: !event.editable && !event.allowEdit,
                        click: function () {

                            if(event.title != null && event.title != '') {
                                var me = $(this);

                                bln_correct = customviewUpdateEvent(event, false, me);

                                if (bln_correct) {
                                    // $( this ).dialog( "close" );
                                    $('#error_message').html('');
                                }
                            } else {

                                $('#error_message').html(Lang.Alert.FillInTheRequiredFields);
                            }

                        }
                    },{
                        html: Lang.Popup.closeButtonText,
                        click: function () {
                            $(this).dialog("close");

                        }
                    }]
            });
        } else if(MyCalendar.actionOnClickEventInCustomListview == 2) {
            
            // goto calendar to the correct event
            $.ajax({
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=get_event&event_id=' + $(this).data('event-id'),
                dataType: "json",
                success: function(r) {
                    var start = r.start.split(' ');
                    window.location = MyCalendar.FULLCAL_URL + '/index.php?sd=' + start[0] + '&ft=' + r.event_id + '&fa=1' + (CustomView.CurrentCalendars !== undefined ? '&cid='+CustomView.CurrentCalendars : '');    //'&ft=' + r.title
                }
            });
        
        
        } else if(MyCalendar.actionOnClickEventInCustomListview == 3) {
            
            // goto calendar to the correct event
            $.ajax({
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=get_event&event_id=' + $(this).data('event-id'),
                dataType: "json",
                success: function(r) {
                    var start = r.start.split(' ');
                    window.location = MyCalendar.FULLCAL_URL + '/index.php?sd=' + start[0] + '&ft=' + r.event_id + '&fa=1' + (CustomView.CurrentCalendars !== undefined ? '&cid='+CustomView.CurrentCalendars : '');    //'&ft=' + r.title
                }
            });
        
        } else if(MyCalendar.actionOnClickEventInCustomListview == 4) {
            
            // goto calendar to the correct event
            $.ajax({
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=get_event&event_id=' + $(this).data('event-id'),
                dataType: "json",
                success: function(r) {
                    var start = r.start.split(' ');
                    window.open(MyCalendar.FULLCAL_URL + '/index.php?sd=' + start[0] + '&cl=1&ft=' + r.event_id + '&fa=1' + (CustomView.CurrentCalendars !== undefined ? '&cid='+CustomView.CurrentCalendars : ''));
                    //window.location = MyCalendar.FULLCAL_URL + '/index.php?sd=' + start[0] + '&ft=' + r.event_id + '&fa=1' + (CustomView.CurrentCalendars !== undefined ? '&cid='+CustomView.CurrentCalendars : '');    //'&ft=' + r.title
                }
            });
        }
        
        
        
    });
    
});