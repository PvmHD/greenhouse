
//var Calendar = {};
if (MyCalendar === undefined) {
    MyCalendar = {};
}

if (MyCalendar.CloseTabAfterUpdate) {
    // window.close();
}
MyCalendar.defaultEventColor = '#3366CC';

$('#info_txt').html('');

Date.prototype.getDayFull = function () {
    var days_full = [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
    ];
    return days_full[this.getDay()];
};

$(document).ready(function () {
    $.support.touch = 'ontouchend' in document;

    var hour_notation = MyCalendar.showAMPM ? 'h:MM TT' : 'HH:MM';
    var now = new Date();

    var date_notation = 'mmmm d, yyyy';
    var short_date_notation = 'mm/dd/yyyy';
    if (MyCalendar.datePickerDateFormat.indexOf('mm/dd/') >= 0) {
        date_notation = 'mmmm d, yyyy';
        short_date_notation = 'mm/dd/yyyy';
    } else if (MyCalendar.datePickerDateFormat.indexOf('dd/mm/') >= 0) {
        date_notation = 'd mmmm yyyy';
        short_date_notation = 'dd/mm/yyyy';
    }

    var showMessage = function (message, type) {
        if (type === undefined) {
            type = 'warning';
        }
        //$('#cal_message').css('background-color', 'red');
        $('#cal_message').removeClass('warning');
        $('#cal_message').removeClass('error');
        $('#cal_message').removeClass('success');
        $('#cal_message').addClass(type);
        $('#cal_message').html('<span style="font-weight:bold;text-transform:uppercase;">' + type + ': </span>' + message);
        $('#cal_message').show();

        setTimeout(function () {
            $('#cal_message').html('');
            $('#cal_message').hide();
        }, 3000);
    };

    var showMessageChangedEvent = function (message, type) {
        if (type === undefined) {
            type = 'warning';
        }
        if (MyCalendar.countNotifications === undefined) {
            MyCalendar.countNotifications = 0;
        }
        //$('#cal_message').css('background-color', 'red');
        //$('#cal_message_changed_event').removeClass('warning');
        //$('#cal_message_changed_event').removeClass('error');
        // $('#cal_message_changed_event').removeClass('success');
//        $('#cal_message_changed_event_1').addClass(type);
//        $('#cal_message_changed_event_1').data('number', 1);
//       // $('#cal_message_changed_event_message').html('<span style="font-weight:bold;text-transform:uppercase;">' + type + ': </span>' + message);
//        $('#cal_message_changed_event_message_1').html(message);
        $('#cal_message_changed_event_container').show();
        MyCalendar.countNotifications++;

        $('#cal_message_changed_event_container').append('<span id="cal_message_changed_event_' + MyCalendar.countNotifications + '"><br /><br /><span id="" class="' + type + ' cal_message_changed_event"><span class="cal_message_changed_event_message" style="padding-right: 10px;">' + message + '</span><span class="close close_notification" data-number_x="' + MyCalendar.countNotifications + '" data-dismiss="alert" aria-label="close">&times;</span></span></span>');
    };

    if (MyCalendar.currentEventColor === '') {
        MyCalendar.currentEventColor = MyCalendar.defaultEventColor;
    }
    if (MyCalendar.currentCalendars === undefined || MyCalendar.currentCalendars == '') {
        MyCalendar.currentCalendars = MyCalendar.currentCalendar;
    }

    var hideDDArea = function () {
        $('#dragdrop_events').hide();
        $('#usergroup_dragdrop_events').hide();
        $('#booking').hide();
        $('#dateplanner').hide();
    }
    hideDDArea();

    if ((MyCalendar.admin_has_full_control && (MyCalendar.isAdmin || MyCalendar.isSuperAdmin)) || (MyCalendar.isOwner) || MyCalendar.calCanDragDDItems) {
        //$('#dragdrop_events .external-event').css('background-color',MyCalendar.currentCalendarColor);
        //$('#dragdrop_events .external-event').attr('color',MyCalendar.currentCalendarColor);
        $('#dragdrop_events').show();
        $('#usergroup_dragdrop_events').show();
        $('#assign_header').html(Lang.Calendar.LabelAssigning);
        $('.ext_item_' + MyCalendar.currentCalendar).show();
    }

    var applyToObject = function (event, result) {
        event.start = result.start;
        event.end = result.end;
        event._start = result.start;
        event._end = result.end;
        event._id = result.id;
        event.time_start = result.time_start;
        event.time_end = result.time_end;
        event.color = result.color;
        event.allDay = result.allDay;
        event.calendar_id = result.calendar_id;
        event.team_member_id = result.team_member_id;
        event.team_member = result.team_member !== undefined ? result.team_member : '';
        event.assigned_by = result.assigned_by;
        event.assigned_by_name = result.assigned_by_name;
        event.dropdown1_color = result.dropdown1_color;
        event.dropdown2_color = result.dropdown2_color;
        event.dropdown3_color = result.dropdown3_color;
        event.dropdown4_color = result.dropdown4_color;
        event.dropdown5_color = result.dropdown5_color;
        event.dropdown1_option_id = result.dropdown1_option_id === null ? -1 : result.dropdown1_option_id;
        event.dropdown2_option_id = result.dropdown2_option_id === null ? -1 : result.dropdown2_option_id;
        event.dropdown3_option_id = result.dropdown3_option_id === null ? -1 : result.dropdown3_option_id;
        event.dropdown4_option_id = result.dropdown4_option_id === null ? -1 : result.dropdown4_option_id;
        event.dropdown5_option_id = result.dropdown5_option_id === null ? -1 : result.dropdown5_option_id;
        event.add_custom_dropdown1_to_title = result.add_custom_dropdown1_to_title;
        event.add_custom_dropdown2_to_title = result.add_custom_dropdown2_to_title;
        event.add_custom_dropdown3_to_title = result.add_custom_dropdown3_to_title;
        event.add_custom_dropdown4_to_title = result.add_custom_dropdown4_to_title;
        event.add_custom_dropdown5_to_title = result.add_custom_dropdown5_to_title;

        return event;
    };

    if (MyCalendar.editdialogTimepickerType == 'simple') {
        $('#timepicker_starttime').timepicker({
            zindex: 9999,
            interval: MyCalendar.timePickerMinuteInterval,
            timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
        });
        $('#timepicker_endtime').timepicker({
            zindex: 9999,
            interval: MyCalendar.timePickerMinuteInterval,
            timeFormat: MyCalendar.showAMPM ? 'hh:mm p' : 'HH:mm'
        });
    } else {
        $('#timepicker_starttime').timepicker({
            showPeriodLabels: MyCalendar.showAMPM,
            showPeriod: MyCalendar.showAMPM,
            showLeadingZero: true,
            hourText: Lang.Popup.TimepickerHourtext,
            minuteText: Lang.Popup.TimepickerMinutetext,
            showCloseButton: true, // shows an OK button to confirm the edit
            closeButtonText: Lang.Popup.TimepickercloseButtonText, // Text for the confirmation button (ok button)
            showNowButton: true, // Shows the 'now' button
            nowButtonText: Lang.Popup.TimepickernowButtonText,
            hours: {
                starts: MyCalendar.timePickerMinHour, // First displayed hour
                ends: MyCalendar.timePickerMaxHour                  		// Last displayed hour
            },
            minutes: {
                starts: 0, // First displayed minute
                ends: 55, // Last displayed minute
                interval: MyCalendar.timePickerMinuteInterval               // Interval of displayed minutes
            }
        });
        $('#timepicker_endtime').timepicker({
            showPeriodLabels: MyCalendar.showAMPM,
            showPeriod: MyCalendar.showAMPM,
            showLeadingZero: true,
            hourText: Lang.Popup.TimepickerHourtext,
            minuteText: Lang.Popup.TimepickerMinutetext,
            showCloseButton: true, // shows an OK button to confirm the edit
            closeButtonText: Lang.Popup.TimepickercloseButtonText, // Text for the confirmation button (ok button)
            showNowButton: true, // Shows the 'now' button
            nowButtonText: Lang.Popup.TimepickernowButtonText,
            hours: {
                starts: MyCalendar.timePickerMinHour, // First displayed hour
                ends: MyCalendar.timePickerMaxHour                  		// Last displayed hour
            },
            minutes: {
                starts: 0, // First displayed minute
                ends: 55, // Last displayed minute
                interval: MyCalendar.timePickerMinuteInterval               // Interval of displayed minutes
            }
        });
    }

    $("#datepicker_startdate").datepicker({
        dateFormat: MyCalendar.datePickerDateFormat || 'dd/mm/yy',
        firstDay: MyCalendar.FCfirstDay,
        onSelect: function (dateText, inst) {
            var dp_enddate = $("#datepicker_enddate").datepicker('getDate');

            if (MyCalendar.datePickerDateFormat === null || MyCalendar.datePickerDateFormat == 'dd/mm/yy') {
                var arr_startdate = dateText.split('/');
                var dp_startdate = new Date(arr_startdate[1] + '/' + arr_startdate[0] + '/' + arr_startdate[2]);
            } else if (MyCalendar.datePickerDateFormat == 'mm/dd/yy') {
                var dp_startdate = new Date(dateText);
            }

            if (dp_startdate.getTime() > dp_enddate.getTime()) {
                $('#error_message').html(Lang.Alert.DatesNotCorrect);
                //is confusing when dates automatically change	$( "#datepicker_enddate" ).datepicker('setDate', dp_startdate);
                return false;
            } else {
                $('#error_message').html('');
            }

//				if(((dp_enddate.getTime() - dp_startdate.getTime()) / 3600 / 1000 / 24) > 7) {
//                    
//                    $('#interval_container').show();
//                    $('#interval_day_choice_div').show();
//                    
//                    //var n = dp_startdate.getDay();console.log('day'.n);
//
//                    // if monthly recurring
//                    if($('#interval_div').val() == 'M') {
//                        if ($('#monthly_dom').is(':checked')) {
//                            $('#info_txt').html(Lang.Popup.MonthlyOnDay + ' ' + $( "#datepicker_startdate" ).datepicker('getDate').getDate());
//                        } else {
//                            var arr_date = MyCalendar.datePickerDateFormat.split('/');
//
//                            $('#info_txt').html(Lang.Popup.MonthlyOn + ' ' + Lang.Fullcalendar.dayNames[$( "#datepicker_startdate" ).datepicker('getDate').getDay()] + ', ' + Lang.Popup.Starting + ' ' + (arr_date[0] == 'dd' ? $( "#datepicker_startdate" ).datepicker('getDate').format('dd/mm') : $( "#datepicker_startdate" ).datepicker('getDate').format('mm/dd')) );
//                        }
//                    }
//					
//				} else {
//					$('#interval_container').hide();
//                    $('#interval_day_choice_div').hide();
//					$('#interval_week_choice_div').hide();
//					$('#interval_month_choice_div').hide();
//                    $('#interval_year_choice_div').hide();
//					$('#info_txt').html('');
//				}

            return true;
        }
    });

    $("#datepicker_startdate_copy_to").datepicker({
        firstDay: MyCalendar.FCfirstDay,
        dateFormat: MyCalendar.datePickerDateFormat || 'dd/mm/yy'
    });

    $("#datepicker_item_startdate").datepicker({
        firstDay: MyCalendar.FCfirstDay,
        dateFormat: MyCalendar.datePickerDateFormat || 'dd/mm/yy'
    });

    $("#datepicker_item_enddate").datepicker({
        firstDay: MyCalendar.FCfirstDay,
        dateFormat: MyCalendar.datePickerDateFormat || 'dd/mm/yy'
    });

    $("#datepicker_enddate").datepicker({
        dateFormat: MyCalendar.datePickerDateFormat || 'dd/mm/yy',
        firstDay: MyCalendar.FCfirstDay,
        onSelect: function (dateText, inst) {
            var dp_startdate = $("#datepicker_startdate").datepicker('getDate');

            if (MyCalendar.datePickerDateFormat === null || MyCalendar.datePickerDateFormat == 'dd/mm/yy') {
                var arr_enddate = dateText.split('/');
                var dp_enddate = new Date(arr_enddate[1] + '/' + arr_enddate[0] + '/' + arr_enddate[2]);
            } else if (MyCalendar.datePickerDateFormat == 'mm/dd/yy') {
                var dp_enddate = new Date(dateText);
            }

            if (dp_startdate.getTime() > dp_enddate.getTime()) {
                $('#error_message').html(Lang.Alert.DatesNotCorrect);
                //is confusing when dates automatically change		$( "#datepicker_enddate" ).datepicker('setDate', dp_startdate);
                return false;
            } else {
                $('#error_message').html('');
            }

            if (dp_startdate.getTime() == dp_enddate.getTime()) {
                $('#info_txt').html('');
            }

            return true;
        }
    });

    $('#ColorPicker1').empty().addColorPicker({
        clickCallback: function (elem, c) {
            $('#ColorSelectionTarget1').css('background-color', c);
            //MyCalendar.defaultEventColor = elem.attr('color');
            MyCalendar.currentEventColor = elem.attr('color');
        }
    });
    $('#ColorSelectionTarget1').css('background-color', MyCalendar.defaultEventColor);

    $('#searchbox_cal_id').val(MyCalendar.currentCalendars);

    doAjaxGetCal = function (cal_id, bln_set_tick) {
        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=get_cal",
            data: "cal_id=" + cal_id,
            dataType: 'json',
            success: function (result) {
                $('.ext_item').hide();
                //$('#booking').hide();
                //$('#dateplanner').hide();
                hideDDArea();

                MyCalendar.currentCalendarColor = result.calendar_color;
                MyCalendar.currentCalendarTextColor = result.calendar_textcolor;

                if ($('#calendar').fullCalendar('getView').name != 'agendaList') {

                    //var adminCanSeeDDItems = (MyCalendar.onlyAdminCanSeeDDItems || MyCalendar.admin_has_full_control)  && (MyCalendar.isAdmin || MyCalendar.isSuperAdmin);
                    //var ownerCanSeeDDItems = result.isOwner;    

                    if (result.can_drag_dd_items) {
                        //$('#dragdrop_events .external-event').css('background-color',MyCalendar.currentCalendarColor);
                        //$('#dragdrop_events .external-event').attr('color',MyCalendar.currentCalendarColor);

                        $('#dragdrop_events').show();
                        $('#usergroup_dragdrop_events').show();
                        $('.ext_item_' + result.calendar_id).show();
                        $('#assign_header').html(Lang.Calendar.LabelAssigning);
                    }
                }

                if (bln_set_tick) {
                    $('#calgroup' + cal_id).addClass('tick_on');
                }

                MyCalendar.currentCalendar = cal_id;

                MyCalendar.currentCalendarName = result.name;
                MyCalendar.currentCalendarType = result.calendar_type;

                MyCalendar.calCanEdit = result.can_edit;
                MyCalendar.calCanAdd = result.can_add;
                MyCalendar.calCanDragDDItems = result.can_drag_dd_items;
                MyCalendar.calCanChangeColor = result.can_change_color;
                MyCalendar.calCanMail = result.can_mail;
                MyCalendar.onlyViewable = result.only_viewable;

                MyCalendar.showDescriptionField = result.show_description_field;
                MyCalendar.showLocationField = result.show_location_field;
                MyCalendar.showPhoneField = result.show_phone_field;
                MyCalendar.showTeamMemberField = result.show_team_member_field;
                MyCalendar.alldayIsDefault = result.allday_is_default;
                MyCalendar.showUrlField = result.show_url_field;
                MyCalendar.showDropdown1Field = result.show_dropdown_1_field;
                MyCalendar.showDropdown2Field = result.show_dropdown_2_field;
                MyCalendar.showDropdown3Field = result.show_dropdown_3_field;
                MyCalendar.showDropdown4Field = result.show_dropdown_4_field;
                MyCalendar.showDropdown5Field = result.show_dropdown_5_field;
                MyCalendar.calendarnameIsTitle = result.calendarname_is_title;

                //if (MyCalendar.showDropdown1Field === true) {
                if ((MyCalendar.showCustomDropdowns === true && cal_id == 'all') || MyCalendar.showDropdown1Field === true) {
                    $('#custom_dropdown1').show();
                } else {
                    $('#custom_dropdown1').hide();
                }
                //if (MyCalendar.showDropdown2Field === true) {
                if ((MyCalendar.showCustomDropdowns === true && cal_id == 'all') || MyCalendar.showDropdown2Field === true) {
                    $('#custom_dropdown2').show();
                } else {
                    $('#custom_dropdown2').hide();
                }
                if ((MyCalendar.showCustomDropdowns === true && cal_id == 'all') || MyCalendar.showDropdown3Field === true) {
                    $('#custom_dropdown3').show();
                } else {
                    $('#custom_dropdown3').hide();
                }
                if ((MyCalendar.showCustomDropdowns === true && cal_id == 'all') || MyCalendar.showDropdown4Field === true) {
                    $('#custom_dropdown4').show();
                } else {
                    $('#custom_dropdown4').hide();
                }
                if ((MyCalendar.showCustomDropdowns === true && cal_id == 'all') || MyCalendar.showDropdown5Field === true) {
                    $('#custom_dropdown5').show();
                } else {
                    $('#custom_dropdown5').hide();
                }

                if (MyCalendar.showCustomDropdowns) {
                    if (MyCalendar.showDropdown1Field) {
                        $('#custom_dropdown1').show();
                    }
                    if (MyCalendar.showDropdown2Field) {
                        $('#custom_dropdown2').show();
                    }
                    if (MyCalendar.showDropdown3Field) {
                        $('#custom_dropdown3').show();
                    }
                    if (MyCalendar.showDropdown4Field) {
                        $('#custom_dropdown4').show();
                    }
                    if (MyCalendar.showDropdown5Field) {
                        $('#custom_dropdown5').show();
                    }
                }

                MyCalendar.descriptionFieldRequired = result.description_field_required;
                MyCalendar.locationFieldRequired = result.location_field_required;
                MyCalendar.phoneFieldRequired = result.phone_field_required;
                MyCalendar.urlFieldRequired = result.url_field_required;


                if (result.alterable_startdate !== null && result.alterable_startdate !== '') {
                    MyCalendar.calAlterableStartdate = result.alterable_startdate;
                    MyCalendar.calAlterableEnddate = result.alterable_enddate;
                } else {
                    MyCalendar.calAlterableStartdate = '';
                    MyCalendar.calAlterableEnddate = '';
                }

                if (MyCalendar.maskUnalterableDays) {
                    $('#calendar').fullCalendar('render');
                }

                if (result.locations !== '') {
                    MyCalendar.locations = result.locations;
                }

                MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();

                //setTimeout(function() {
                //  if(callback) {
                //      callback();
                //}
                //},1000);      

            }
        });
    };

    MyCalendar.getNewCurrentDropdownOptions = function () {
        if (!MyCalendar.showCustomDropdowns) {
            MyCalendar.currentDropdownOptions = '';
        } else {
            if (MyCalendar.currentDropdown2Options === undefined) {
                MyCalendar.currentDropdown2Options = '';
            }
            if (MyCalendar.currentDropdown1Options === undefined) {
                MyCalendar.currentDropdown1Options = '';
            }

            if (MyCalendar.showDropdown1Field && !MyCalendar.showDropdown2Field) {
                MyCalendar.currentDropdownOptions = MyCalendar.currentDropdown1Options;
            } else if (MyCalendar.showDropdown2Field && !MyCalendar.showDropdown1Field) {
                MyCalendar.currentDropdownOptions = MyCalendar.currentDropdown2Options;
            } else if (MyCalendar.showCustomDropdowns) {
                if (MyCalendar.currentDropdown1Options !== '' && MyCalendar.currentDropdown2Options !== '') {
                    MyCalendar.currentDropdownOptions = MyCalendar.currentDropdown1Options + ',' + MyCalendar.currentDropdown2Options;
                } else if (MyCalendar.currentDropdown1Options == '' || MyCalendar.currentDropdown2Options == '') {
                    MyCalendar.currentDropdownOptions = MyCalendar.currentDropdown1Options + MyCalendar.currentDropdown2Options;
                }
            }
        }

        return MyCalendar.currentDropdownOptions;
    }

    MyCalendar.removeOptionFromFilter = function (drd_number, option_id) {
        if (drd_number == 1) {
            // remove the id from MyCalendar.currentDropdownOptions
            if (MyCalendar.currentDropdown1Options.indexOf(',') > 0) {
                MyCalendar.currentDropdown1Options = ',' + MyCalendar.currentDropdown1Options;
                MyCalendar.currentDropdown1Options = MyCalendar.currentDropdown1Options.replace(',' + option_id, '');
                if (MyCalendar.currentDropdown1Options.charAt(0) == ',') {
                    MyCalendar.currentDropdown1Options = MyCalendar.currentDropdown1Options.substring(1);
                }

            } else {
                if (MyCalendar.currentDropdown1Options == option_id) {
                    MyCalendar.currentDropdown1Options = '';
                }
            }
        }
        if (drd_number == 2) {
            // remove the id from MyCalendar.currentDropdownOptions
            if (MyCalendar.currentDropdown2Options.indexOf(',') > 0) {
                MyCalendar.currentDropdown2Options = ',' + MyCalendar.currentDropdown2Options;
                MyCalendar.currentDropdown2Options = MyCalendar.currentDropdown2Options.replace(',' + option_id, '');
                if (MyCalendar.currentDropdown2Options.charAt(0) == ',') {
                    MyCalendar.currentDropdown2Options = MyCalendar.currentDropdown2Options.substring(1);
                }

            } else {
                if (MyCalendar.currentDropdown2Options == option_id) {
                    MyCalendar.currentDropdown2Options = '';
                }
            }
        }
    }

    MyCalendar.filterByUser = function (old_user_id) {
        //$('#calendar').fullCalendar('removeEventSources');

        //$('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);

        // remove the sources
        $('.tick_on').each(function (index, item) {
            $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + $(item).attr('cal_id') + "&uid=" + old_user_id);
        });

        // add the sources with uid="
        $('.tick_on').each(function (index, item) {
            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + $(item).attr('cal_id') + "&uid=" + MyCalendar.filterUser);

        });
    }

    MyCalendar.openCalendar = function (cal_id, cal_name, origin, feedurl) {



        // if (MyCalendar.currentCalendars.indexOf(',') != -1) {
        // there were several calendars with initial_show
        //$('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start"+(MyCalendar.currentDropdownOptions !== '' ? "&option_id="+MyCalendar.currentDropdownOptions : "")+"&cal_id=" + MyCalendar.currentCalendars);

        $('#calendar').fullCalendar('removeEventSources');

        //MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();

        $('.tick_on').each(function (index, item) {
            $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + $(item).attr('cal_id') + "&uid=" + MyCalendar.filterUser);
            $('#calgroup' + $(item).attr('cal_id')).removeClass('tick_on').addClass('tick_off');
        });
        //}

        // check all calendars if you chose 'all'
        if (cal_id == 'all') {

            $('.tick_off').each(function (index, item) {
                // only add cal_id if not already in the cal_id string
                //if (MyCalendar.currentCalendars.indexOf($(item).attr('cal_id')) == -1) {  // if 10 is already in, 1 won't be added, so that is not what we want. get the doubles out in php
                if (MyCalendar.currentCalendars == '') {
                    MyCalendar.currentCalendars = $(item).attr('cal_id');
                } else {
                    MyCalendar.currentCalendars = MyCalendar.currentCalendars + ',' + $(item).attr('cal_id');
                }
                //}



                //  $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start"+(MyCalendar.currentDropdownOptions !== '' ? "&option_id="+MyCalendar.currentDropdownOptions : "")+"&cal_id=" + $(item).attr('cal_id'));

                $('#calgroup' + $(item).attr('cal_id')).removeClass('tick_off').addClass('tick_on');
            });

            //  MyCalendar.currentCalendars.substring(1);

            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);


            // MyCalendar.currentCalendars = 'all';
            MyCalendar.calCanAdd = false;
            hideDDArea();


        } else {
            $('#calendar').fullCalendar('removeEvents');

            // uncheck all calendars that are currently checked, except when you chose 'all'
            $('.tick_on').each(function (index, item) {

                $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + $(item).attr('cal_id') + "&uid=" + MyCalendar.filterUser);

                //if(cal_id !== 'all') {
                $('#calgroup' + $(item).attr('cal_id')).removeClass('tick_on').addClass('tick_off');
                //}
            });

            $('#calgroup' + cal_id).removeClass('tick_off').addClass('tick_on');

            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + cal_id + "&uid=" + MyCalendar.filterUser);

            MyCalendar.currentCalendars = cal_id;
            MyCalendar.currentCalendar = cal_id;


            //setTimeout(function () {}, 100);
        }

        doAjaxGetCal(cal_id, true);

        $('#searchbox_cal_id').val(MyCalendar.currentCalendars);
    };

    MyCalendar.addCalendar = function (cal_id, cal_name, origin, feedurl) {
        // if we are in agendaview disable addcalendar, otherwise the rendering will be wrong if we switch back to monthview
        if ($('.fc-header-title h2').html() != 'Agenda') {

            MyCalendar.currentCalendars = MyCalendar.currentCalendars.toString();

            MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();

            //var duplicates = '';

            if ($('#calgroup' + cal_id).hasClass('tick_off')) {

                if (MyCalendar.currentCalendar == 'all') {
                    MyCalendar.currentCalendars = '';
                }

                // only add cal_id if not already in the cal_id string
                // if (MyCalendar.currentCalendars.indexOf(cal_id) == -1) {
                if (MyCalendar.currentCalendars == '') {
                    MyCalendar.currentCalendars = cal_id;
                } else {
                    MyCalendar.currentCalendars = MyCalendar.currentCalendars + ',' + cal_id;
                }
                // }
                if (MyCalendar.maskUnalterableDays) {
                    $('#calendar').fullCalendar('render');
                }

                // add to current view
                if (origin == 'google') {
                    $('#calendar').fullCalendar('addEventSource', {url: feedurl, color: '#9A9CFF', textColor: 'white'}); // 1d1d1d

                } else {
                    $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + cal_id + "&uid=" + MyCalendar.filterUser);
                }


                //$('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL+"/command/cal_events.php?action=start&cal_id=" + cal_id );
                $('#calgroup' + cal_id).removeClass('tick_off').addClass('tick_on');



            } else {
                //$('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('removeEventSource', {url: feedurl, color: '#9A9CFF', textColor: 'white'});

                // remove from current view
                $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + cal_id + "&uid=" + MyCalendar.filterUser);
                $('#calgroup' + cal_id).removeClass('tick_on').addClass('tick_off');

                if (MyCalendar.currentCalendars == 'all') {
                    // alle cal_ids opzoeken en achter elkaar plakken, behalve huidige aangeklikte cal_id
                    //MyCalendar.currentCalendars = MyCalendar.activeCalendarsString;
                    MyCalendar.currentCalendars = '';
                    $('.colorchooser').each(function (index, item) {
                        if (MyCalendar.currentCalendars == '') {
                            MyCalendar.currentCalendars = MyCalendar.currentCalendars + $(item).attr('cal_id');
                        } else {
                            MyCalendar.currentCalendars = MyCalendar.currentCalendars + ',' + $(item).attr('cal_id');
                        }
                    });
                }

                //remove cal_id
                MyCalendar.currentCalendars = ',' + MyCalendar.currentCalendars + ',';
                MyCalendar.currentCalendars = MyCalendar.currentCalendars.replace(',' + cal_id + ',', ',');

                // get rid of extra commas
                if (MyCalendar.currentCalendars.substring(0, 1) == ',') {
                    MyCalendar.currentCalendars = MyCalendar.currentCalendars.substring(1);
                }
                if (MyCalendar.currentCalendars.charAt(MyCalendar.currentCalendars.length - 1) == ',') {
                    MyCalendar.currentCalendars = MyCalendar.currentCalendars.slice(-1);
                }


                if (MyCalendar.currentCalendars == ',') {
                    MyCalendar.currentCalendars = '';
                }


                // check how many calendars are selected now, if 1 is selected then open div with drag&drop items
                if ($('.tick_on').length == 1) {
                    doAjaxGetCal($('.tick_on').attr('cal_id'), false);
                }
            }
            $('#searchbox_cal_id').val(MyCalendar.currentCalendars);

        }
        hideDDArea();
    };

    if (MyCalendar.currentCalendars === undefined) {
        MyCalendar.currentCalendars = '';
    }
    if (MyCalendar.currentCalendars == 'all') {
        setTimeout(function () {
            MyCalendar.openCalendar('all');
        }, 100);

    } else if (MyCalendar.currentCalendars.indexOf(',') != -1) {
        hideDDArea();
    } else {
        MyCalendar.openCalendar(MyCalendar.currentCalendars);
    }



    MyCalendar.openCustomOption = function (option_id, option_name, drd_number) {
        // remove current eventsource
        //$('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars);
        $('#calendar').fullCalendar('removeEventSources');

        if (option_id == 'all') {
            // do not remove event source
        } else {
            $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);

        }


//        if (MyCalendar.currentDropdownOptions.indexOf(',') != -1) {
//            // set options tick_off and remove specific eventsources
//            $('.dropdown_' + drd_number + '_tick_on').each(function (index, item) {
//                $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + $(item).attr('option_id') + "&cal_id=" + MyCalendar.currentCalendars);
//                $('#dropdown_group' + $(item).attr('option_id')).removeClass('tick_on').addClass('dropdown_' + drd_number + '_tick_off');
//            });
//        }


        // check all calendars if you chose 'all'
        if (option_id == 'all') {
            $('.dropdown_' + drd_number + '_tick_off').each(function (index, item) {
                //  $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + $(item).attr('option_id') + "&cal_id=" + MyCalendar.currentCalendars);

                $('#dropdown_group' + $(item).attr('option_id')).removeClass('dropdown_' + drd_number + '_tick_off').addClass('dropdown_' + drd_number + '_tick_on');
            });

            // MyCalendar.currentDropdownOptions = drd_number == 1 ? MyCalendar.initialDropdown1Options : MyCalendar.initialDropdown2Options;

            if (drd_number == 1) {
                MyCalendar.currentDropdown1Options = MyCalendar.initialDropdown1Options;
            }
            if (drd_number == 2) {
                MyCalendar.currentDropdown2Options = MyCalendar.initialDropdown2Options;
            }

            MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();

            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);

// or use this: MyCalendar.initialDropdownOptions

        } else {
            $('#calendar').fullCalendar('removeEvents');

            // uncheck all calendars that are currently checked, except when you chose 'all'
            $('.dropdown_' + drd_number + '_tick_on').each(function (index, item) {

                $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + $(item).attr('option_id') + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);

                MyCalendar.removeOptionFromFilter(drd_number, $(item).attr('option_id'));


                //if(cal_id !== 'all') {
                $('#dropdown_group' + $(item).attr('option_id')).removeClass('dropdown_' + drd_number + '_tick_on').addClass('dropdown_' + drd_number + '_tick_off');
                //}
            });

            $('#dropdown_group' + option_id).removeClass('dropdown_' + drd_number + '_tick_off').addClass('dropdown_' + drd_number + '_tick_on');

            if (drd_number == 1) {
                if (MyCalendar.currentDropdown1Options === '') {
                    MyCalendar.currentDropdown1Options += option_id;
                } else {
                    MyCalendar.currentDropdown1Options += ',' + option_id;
                }
            }
            if (drd_number == 2) {
                if (MyCalendar.currentDropdown2Options === '') {
                    MyCalendar.currentDropdown2Options += option_id;
                } else {
                    MyCalendar.currentDropdown2Options += ',' + option_id;
                }
            }

            MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();

            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);




            setTimeout(function () {}, 100);
        }

    };

    MyCalendar.addCustomOption = function (option_id, option_name, drd_number) {
        $('#calendar').fullCalendar('removeEvents');
        $('#calendar').fullCalendar('removeEventSources');
        //MyCalendar.currentDropdownOptions = '';

        //$('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars);



        // if we are in agendaview disable addcalendar, otherwise the rendering will be wrong if we switch back to monthview
        if ($('.fc-header-title h2').html() != 'Agenda') {

            MyCalendar.currentCalendars = MyCalendar.currentCalendars.toString();
            //MyCalendar.currentDropdown1Options = MyCalendar.currentDropdown1Options.toString();
            //MyCalendar.currentDropdown2Options = MyCalendar.currentDropdown2Options.toString();

            //var duplicates = '';

            if ($('#dropdown_group' + option_id).hasClass('dropdown_' + drd_number + '_tick_off')) {
                // it was tick_of, turn it in to tick_on

//                if (MyCalendar.maskUnalterableDays) {
//                    $('#calendar').fullCalendar('render');
//                }

                //$('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars);

                if (drd_number == 1) {
                    if (MyCalendar.currentDropdown1Options === '') {
                        MyCalendar.currentDropdown1Options += option_id;
                    } else {
                        MyCalendar.currentDropdown1Options += ',' + option_id;
                    }
                }
                if (drd_number == 2) {
                    if (MyCalendar.currentDropdown2Options === '') {
                        MyCalendar.currentDropdown2Options += option_id;
                    } else {
                        MyCalendar.currentDropdown2Options += ',' + option_id;
                    }
                }



                //$('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL+"/command/cal_events.php?action=start&cal_id=" + cal_id );
                $('#dropdown_group' + option_id).removeClass('dropdown_' + drd_number + '_tick_off').addClass('dropdown_' + drd_number + '_tick_on');



            } else {
                // it was tick_on, so make it tick_off

//                // remove from current view
//                $('#calendar').fullCalendar('removeEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + option_id + "&cal_id=" + MyCalendar.currentCalendars);
                $('#dropdown_group' + option_id).removeClass('dropdown_' + drd_number + '_tick_on').addClass('dropdown_' + drd_number + '_tick_off');


                MyCalendar.removeOptionFromFilter(drd_number, option_id);


            }

            MyCalendar.currentDropdownOptions = MyCalendar.getNewCurrentDropdownOptions();



            $('#calendar').fullCalendar('addEventSource', MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start&option_id=" + MyCalendar.currentDropdownOptions + "&cal_id=" + MyCalendar.currentCalendars + "&uid=" + MyCalendar.filterUser);


//            $('.dropdown_' + drd_number + '_tick_on').each(function (index, item) {
//
//                
//            });

            $('#searchbox_cal_id').val(MyCalendar.currentCalendars);

        }
        hideDDArea();
    };

    var calAlert = function () {
        $("#dialog:ui-dialog").dialog("destroy");
        $("#dialog-message").dialog({
            modal: true,
            buttons: {
                Ok: function () {
                    $(this).dialog("close");
                }
            }
        });
    };
    var disableTimeCombos = function () {
        //$('#timepicker_starttime').attr('disabled', 'disabled');
        //$('#timepicker_endtime').attr('disabled', 'disabled');
        $('#timepicker_starttime').hide();
        $('#timepicker_endtime').hide();

    };
    var enableTimeCombos = function () {
        $('#timepicker_starttime').removeAttr('disabled');
        $('#timepicker_endtime').removeAttr('disabled');
        $('#timepicker_starttime').show();
        $('#timepicker_endtime').show();
    };

    var mailEvent = function (me) {
        if (MyCalendar.loggedInUser > 0 && MyCalendar.loggedInUser !== '1000000') {
            var title = $('#edited_title').val();

            if ($('#edited_location') !== undefined) {
                var location = $('#edited_location').val();
            }
            if ($('#edited_description') !== undefined) {
                var description = $('#edited_description').val();
            }
            if ($('#edited_phone') !== undefined) {
                var phone = $('#edited_phone').val();
            }
            if ($('#edited_myurl') !== undefined) {
                var myurl = $('#edited_myurl').val();
            }

            var start = $("#datepicker_startdate").datepicker('getDate');
            var end = $("#datepicker_enddate").datepicker('getDate');

            var starttime = getTimepickerStarttime();
            var endtime = getTimepickerEndtime();

            var str_date_start = start.format('yyyy-mm-dd') + ' ' + starttime;
            var str_date_end = end.format('yyyy-mm-dd') + ' ' + endtime;

            var data = {
                title: title,
                location: location,
                description: description,
                phone: phone,
                myurl: myurl,
                str_date_start: str_date_start,
                str_date_end: str_date_end
            };
            if (MyCalendar.currentCalendar > 0) {
                data.cal_id = MyCalendar.currentCalendar;
            }
            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=mail_event",
                data: data,
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        showMessage(result.msg, 'success');
                        $('#error_message').html(Lang.Alert.DoNotForgetToSave);
                    } else {
                        $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                    }
                }
            });
        } else {
            showMessage('Log in to send the mail', 'warning');
        }
    };

    var showCopyEventDlg = function (event_id, copy_files, edit_dlg) {
        $("#dialog-copy-event").dialog({
            modal: true,
            title: Lang.Popup.copyEventText,
            height: 'auto', //MyCalendar.showLocationField ? 460 : 430,
            width: 300,
            minHeight: 100,
            resizable: false,
            buttons: [
                {
                    html: Lang.Popup.copyText, // email to admin
                    id: 'gocopybtn',
                    //disabled: !MyCalendar.calCanMail,
                    click: function () {
                        var title = $('#edited_title').val();
                        if (title != null && title != '') {
                            var date_new_startdate = $('#datepicker_startdate_copy_to').datepicker('getDate');
                            var new_startdate = date_new_startdate.format('yyyy-mm-dd');
                            copyEvent(event_id, new_startdate, copy_files, $(this), edit_dlg);

                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }

                    }
                }, {
                    html: Lang.Popup.cancelButtonText,
                    click: function () {
                        $(this).dialog("close");
                    }
                }]
        });

        var today = new Date();
        //  $( "#datepicker_startdate_copy_to" ).blur();
        $("#datepicker_startdate_copy_to").datepicker('setDate', today);
        // $( "#datepicker_startdate_copy_to" ).datepicker('hide');
    };

    var exportEventToIcs = function (event_id, edit_dlg) {
        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=export_to_ics',
            data: {event_id: event_id},
            dataType: 'json',
            success: function (result) {
                if (result.success) {
                    window.open("data:text/calendar;charset=utf8," + escape(result.str_ics));
                } else {
                    if (result.notloggedin) {
                        alert('You are not logged in');
                        window.location = MyCalendar.FULLCAL_URL;
                    } else {
                        $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                    }
                }

            }
        });

    };

    var getTimepickerStarttime = function () {
        if (MyCalendar.editdialogTimepickerType == 'simple') {
            return $('#timepicker_starttime').val();
        } else {
            var timepicker_starttime_hours = $('#timepicker_starttime').timepicker('getHour');
            if (timepicker_starttime_hours < 10) {
                timepicker_starttime_hours = '0' + timepicker_starttime_hours;
            }
            var timepicker_starttime_minutes = $('#timepicker_starttime').timepicker('getMinute');
            if (timepicker_starttime_minutes < 10) {
                timepicker_starttime_minutes = '0' + timepicker_starttime_minutes;
            }

            return timepicker_starttime_hours + ':' + timepicker_starttime_minutes + ':00';
        }


    }

    var getTimepickerEndtime = function () {
        if (MyCalendar.editdialogTimepickerType == 'simple') {
            return $('#timepicker_endtime').val();

        } else {
            var timepicker_endtime_hours = $('#timepicker_endtime').timepicker('getHour');
            if (timepicker_endtime_hours < 10) {
                timepicker_endtime_hours = '0' + timepicker_endtime_hours;
            }
            var timepicker_endtime_minutes = $('#timepicker_endtime').timepicker('getMinute');
            if (timepicker_endtime_minutes < 10) {
                timepicker_endtime_minutes = '0' + timepicker_endtime_minutes;
            }

            return timepicker_endtime_hours + ':' + timepicker_endtime_minutes + ':00';
        }


    }

    var addEvent = function (start, end, me) {
        var title = $('#edited_title').val();

        var location = '';

        if (MyCalendar.locations !== undefined && MyCalendar.locations !== '' && MyCalendar.locations[0] !== undefined) {
            location = $('#location_combo option:selected').val();
        } else {
            if ($('#edited_location') !== undefined) {
                location = $('#edited_location').val();
            }
        }
        if ($('#edited_description') !== undefined) {
            var description = $('#edited_description').val();
        }
        if ($('#edited_phone') !== undefined) {
            var phone = $('#edited_phone').val();
        }
        if ($('#edited_myurl') !== undefined) {
            var myurl = $('#edited_myurl').val();
        }

        var team_member_id = -1;
        if ($('#edit_dlg_user_selectbox') !== undefined && MyCalendar.showTeamMemberField) {
            team_member_id = $('#edit_dlg_user_selectbox').val();
        }

        var dropdown1_option_id = -1;
        var dropdown1 = '';
        if ($('#edit_dlg_dropdown1_selectbox') !== undefined && MyCalendar.showDropdown1Field) {
            dropdown1_option_id = $('#edit_dlg_dropdown1_selectbox').val();
            dropdown1 = $('#edit_dlg_dropdown1_selectbox').text();
        }

        var dropdown2_option_id = -1;
        var dropdown2 = '';
        if ($('#edit_dlg_dropdown2_selectbox') !== undefined && MyCalendar.showDropdown2Field) {
            dropdown2_option_id = $('#edit_dlg_dropdown2_selectbox').val();
            dropdown2 = $('#edit_dlg_dropdown2_selectbox').text();
        }

        var dropdown3_option_id = -1;
        var dropdown3 = '';
        if ($('#edit_dlg_dropdown3_selectbox') !== undefined && MyCalendar.showDropdown3Field) {
            dropdown3_option_id = $('#edit_dlg_dropdown3_selectbox').val();
            dropdown3 = $('#edit_dlg_dropdown3_selectbox').text();
        }

        var dropdown4_option_id = -1;
        var dropdown4 = '';
        if ($('#edit_dlg_dropdown4_selectbox') !== undefined && MyCalendar.showDropdown4Field) {
            dropdown4_option_id = $('#edit_dlg_dropdown4_selectbox').val();
            dropdown4 = $('#edit_dlg_dropdown4_selectbox').text();
        }

        var dropdown5_option_id = -1;
        var dropdown5 = '';
        if ($('#edit_dlg_dropdown5_selectbox') !== undefined && MyCalendar.showDropdown5Field) {
            dropdown5_option_id = $('#edit_dlg_dropdown5_selectbox').val();
            dropdown5 = $('#edit_dlg_dropdown5_selectbox').text();
        }

        var color = MyCalendar.currentCalendarColor !== undefined ? MyCalendar.currentCalendarColor : MyCalendar.eventColor;
        if (MyCalendar.calCanChangeColor) {
            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                color = $("#togglePaletteOnly").val();
            } else {
                color = MyCalendar.currentEventColor;
            }
        }

        if (title) {
            var interval = $('#interval_div').val();
            //var interval_day = $('#interval_week_choice_div').val();

            var weekdays = '';
            var monthday = '';
            var yearmonthday = '';
            var yearmonth = '';
            var every_x_days = '';
            var every_x_weeks;

            if (interval == 'D') {
                every_x_days = $('#daily_every_x_days').val();

            } else if (interval == 'W') {
                // put the checked weekdays in a string to send to php
                $('#interval_week_choice_div input:checkbox').each(function (index, item) {
                    if ($(item).is(':checked')) {
                        weekdays += ',' + $(item).val();
                    }
                });

                every_x_weeks = $('#weekly_every_x_weeks').val();

            } else if (interval == 'M') {
                console.log($("input[name='monthday']:checked").val());
//                $('#interval_month_choice_div input:radio["name=monthday"]').each(function (index, item) {
//                    if ($(item).is(':checked')) {
//                        monthday = $(item).val();
//                    }
//                });
                monthday = $("input[name='monthday']:checked").val();
                //$('input:radio[name="monthday"]').filter('[value="'+monthday+'"]').prop('checked', true);
                //  console.log($('#monthly_dom').val());
                //  console.log($('#monthly_dow').val());

            } else if (interval == 'Y') {
                yearmonthday = $('#yearly_dom').val();
                yearmonth = $('#yearly_month').val();
            }

            // is a date selected in the datepickers, then use those dates
            var dp_startdate = $("#datepicker_startdate").datepicker('getDate');
            var dp_enddate = $("#datepicker_enddate").datepicker('getDate');

            if (dp_startdate !== null && dp_enddate !== null) {
                start = dp_startdate;
                end = dp_enddate;
            }

            /*
             
             var startTime = start.getTime();
             var localOffset = (-1) * start.getTimezoneOffset() * 60000;
             start = new Date(startTime + localOffset);
             
             var endTime = end.getTime();
             var localOffset = (-1) * end.getTimezoneOffset() * 60000;
             end = new Date(endTime + localOffset);
             */

            var timepicker_starttime_hours_minutes = getTimepickerStarttime();
            var timepicker_endtime_hours_minutes = getTimepickerEndtime();

            if ($('#allday_checkbox').is(':checked')) {
                var startdate = Date.parse(start) / 1000;
                var enddate = Date.parse(end) / 1000;
                var allDay = 1;

            } else {
                var startdate = Date.parse(start.format('mm/dd/yyyy') + ' ' + timepicker_starttime_hours_minutes) / 1000;
                var enddate = Date.parse(end.format('mm/dd/yyyy') + ' ' + timepicker_endtime_hours_minutes) / 1000;
                var allDay = 0;
            }

            if (MyCalendar.showAMPM) {
                var str_date_start_tmp = start.format('mm/dd/yyyy') + ' ' + timepicker_starttime_hours_minutes;
                var str_date_start = new Date(str_date_start_tmp).format('yyyy-mm-dd HH:MM:00');
                var str_date_end_tmp = end.format('mm/dd/yyyy') + ' ' + timepicker_endtime_hours_minutes;
                var str_date_end = new Date(str_date_end_tmp).format('yyyy-mm-dd HH:MM:00');
            } else {
                var str_date_start = start.format('yyyy-mm-dd') + ' ' + timepicker_starttime_hours_minutes;
                var str_date_end = end.format('yyyy-mm-dd') + ' ' + timepicker_endtime_hours_minutes;
            }

            var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
            startdate = startdate - offsetClientToGMT;
            enddate = enddate - offsetClientToGMT;

            var arr_startdate_time = str_date_start.split(' ');
            var arr_startdate = arr_startdate_time[0].split('-');
            var dp_startdate_time = new Date(arr_startdate[1] + '/' + arr_startdate[2] + '/' + arr_startdate[0] + ' ' + arr_startdate_time[1]);
            var ts_startdate_time = Date.parse(dp_startdate_time) / 1000;

            var arr_enddate_time = str_date_end.split(' ');
            var arr_enddate = arr_enddate_time[0].split('-');
            var dp_enddate_time = new Date(arr_enddate[1] + '/' + arr_enddate[2] + '/' + arr_enddate[0] + ' ' + arr_enddate_time[1]);
            var ts_enddate_time = Date.parse(dp_enddate_time) / 1000;

            if (ts_startdate_time <= ts_enddate_time) {
                // opslaan in db
                var data = {
                    interval: interval,
                    title: title,
                    location: location,
                    description: description,
                    phone: phone,
                    myurl: myurl,
                    allDay: allDay,
                    date_start: startdate,
                    date_end: enddate,
                    str_date_start: str_date_start,
                    str_date_end: str_date_end,
                    time_start: timepicker_starttime_hours_minutes,
                    time_end: timepicker_endtime_hours_minutes,
                    color: color,
                    weekdays: weekdays,
                    monthday: monthday,
                    yearmonthday: yearmonthday,
                    yearmonth: yearmonth,
                    every_x_days: every_x_days,
                    every_x_weeks: every_x_weeks,
                    team_member_id: team_member_id,
                    assign: $('#assign_checkbox') !== undefined && $('#assign_checkbox').is(':checked'),
                    dropdown1_option_id: dropdown1_option_id === null ? -1 : dropdown1_option_id,
                    dropdown2_option_id: dropdown2_option_id === null ? -1 : dropdown2_option_id,
                    dropdown3_option_id: dropdown3_option_id === null ? -1 : dropdown3_option_id,
                    dropdown4_option_id: dropdown4_option_id === null ? -1 : dropdown4_option_id,
                    dropdown5_option_id: dropdown5_option_id === null ? -1 : dropdown5_option_id,
                    dropdown1: dropdown1,
                    dropdown2: dropdown2,
                    dropdown3: dropdown3,
                    dropdown4: dropdown4,
                    dropdown5: dropdown5,
                    recurring: $('#recurring_checkbox').is(':checked')
                };
                if (MyCalendar.currentCalendar > 0) {
                    data.cal_id = MyCalendar.currentCalendar;
                }
                $.ajax({
                    type: "POST",
                    url: MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=add",
                    data: data,
                    dataType: 'json',
                    success: function (result) {
                        if (result.success) {
                            me.dialog("close");
                            if (result.event === undefined || result.event === null || (result.event.repeating_event_id !== null && result.event.repeating_event_id > 0)) {
                                $('#calendar').fullCalendar('refetchEvents');
                            } else {
                                $('#calendar').fullCalendar('renderEvent', result.event);
                            }
                            if (result.event !== undefined) {
                                updateAmountEmployees(result.event.date_start);
                            } else {

                                updateAmountEmployees($('#calendar').fullCalendar('getView').visStart.format('yyyy-mm-dd'));

                            }


                        } else {
                            $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                        }
                    }
                });
            } else {
                $('#error_message').html(Lang.Alert.TimesNotCorrect);
            }
        }
    };

    copyEvent = function (event_id, new_startdate, copy_files, me, edit_dlg) {
        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=copy',
            data: {event_id: event_id, new_startdate: new_startdate, copy_files: copy_files},
            dataType: 'json',
            success: function (result) {
                if (result.success) {
                    $('#calendar').fullCalendar('refetchEvents');   // refetch otherwise we can't control showing recurring events

                    me.dialog("close");
                    edit_dlg.dialog("close");

                } else {
                    if (result.notloggedin) {
                        $('#calendar').fullCalendar('refetchEvents');
                        alert('You are not logged in');
                        window.location = MyCalendar.FULLCAL_URL;
                    } else {
                        //alert(Lang.Alert.ErrorSaving);
                        $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                    }
                }

            }
        });
    };

    var updateEvent = function (event, bln_repair_pattern, me) {



        var title = $('#edited_title').val();

        var location = '';

        if (MyCalendar.locations !== undefined && MyCalendar.locations !== '' && MyCalendar.locations[0] !== undefined) {
            location = $('#location_combo option:selected').val();
        } else {
            if ($('#edited_location') !== undefined) {
                location = $('#edited_location').val();
            }
        }

        if ($('#edited_description') !== undefined) {
            var description = $('#edited_description').val();
        }
        if ($('#edited_phone') !== undefined) {
            var phone = $('#edited_phone').val();
        }
        if ($('#edited_myurl') !== undefined) {
            var myurl = $('#edited_myurl').val();
        }

        if (title != null && title != '') {
            event.title = title;
            event.location = location;
            event.description = description;
            event.phone = phone;
            event.myurl = myurl;

            var interval = $('#interval_div').val();
            //var interval_day = $('#interval_week_choice_div').val();

            var weekdays = '';
            var monthday = '';
            var yearmonthday = '';
            var yearmonth = '';
            var every_x_days = '';
            var every_x_weeks = '';

            if (interval == 'D') {
                every_x_days = $('#daily_every_x_days').val();

            } else if (interval == 'W') {
                // put the checked weekdays in a string to send to php
                $('#interval_week_choice_div input:checkbox').each(function (index, item) {
                    if ($(item).is(':checked')) {
                        weekdays += ',' + $(item).val();
                    }
                });

                every_x_weeks = $('#weekly_every_x_weeks').val();

            } else if (interval == 'M') {
//                $('#interval_month_choice_div input:radio["name=monthday"]').each(function (index, item) {
//                    if ($(item).is(':checked')) {
//                        monthday = $(item).val();
//                    }
//                });

                monthday = $("input[name='monthday']:checked").val();
            } else if (interval == 'Y') {
                yearmonthday = $('#yearly_dom').val();
                yearmonth = $('#yearly_month').val();

            }



            // is a date selected in the datepickers, then use those dates
            var dp_startdate = $("#datepicker_startdate").datepicker('getDate');
            var dp_enddate = $("#datepicker_enddate").datepicker('getDate');

            if (dp_startdate !== null && dp_enddate !== null) {
                event.start = dp_startdate;
                event.end = dp_enddate;
            }

            var timepicker_starttime_hours_minutes = getTimepickerStarttime();
            var timepicker_endtime_hours_minutes = getTimepickerEndtime();

            if ($('#allday_checkbox').is(':checked')) {
                var startdate = Date.parse(event.start) / 1000;
                var enddate = event.end !== null ? Date.parse(event.end) / 1000 : startdate;
                event.allDay = 1;
            } else {
                var startdate = Date.parse(event.start.format('mm/dd/yyyy') + ' ' + timepicker_starttime_hours_minutes) / 1000;
                var enddate = event.end === null ? Date.parse(event.start.format('mm/dd/yyyy') + ' ' + timepicker_endtime_hours_minutes) / 1000 : Date.parse(event.end.format('mm/dd/yyyy') + ' ' + timepicker_endtime_hours_minutes) / 1000;
                event.allDay = 0;
            }

            var color = MyCalendar.defaultEventColor;
            if (MyCalendar.calCanChangeColor || event.canChangeColor) {  // also check on event.canChangeColor in case admin ahd full control and is logged in
                if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                    color = $("#togglePaletteOnly").val();
                } else {
                    color = MyCalendar.currentEventColor !== null ? MyCalendar.currentEventColor : event.color;
                }
                if (color.substring(0, 1) !== '#') {
                    color = event.color;
                }
            } else {
                color = event.color;
            }

            // if it is possible to change calendar_id
            var calendar_id = -1;
            if ($('#edit_dlg_calendar_selectbox') !== undefined) {
                calendar_id = $('#edit_dlg_calendar_selectbox').val();
            }

            var team_member_id = -1;
            if ($('#edit_dlg_user_selectbox') !== undefined) {
                team_member_id = $('#edit_dlg_user_selectbox').val();
            }

            var dropdown1_option_id = -1;
            var dropdown1 = '';
            if (MyCalendar.showDropdown1Field === true && $('#edit_dlg_dropdown1_selectbox') !== undefined) {
                dropdown1_option_id = $('#edit_dlg_dropdown1_selectbox').val();
                dropdown1 = $('#edit_dlg_dropdown1_selectbox').text();
            }

            var dropdown2_option_id = -1;
            var dropdown2 = '';
            if (MyCalendar.showDropdown2Field === true && $('#edit_dlg_dropdown2_selectbox') !== undefined) {
                dropdown2_option_id = $('#edit_dlg_dropdown2_selectbox').val();
                dropdown2 = $('#edit_dlg_dropdown2_selectbox').text();
            }

            var dropdown3_option_id = -1;
            var dropdown3 = '';
            if (MyCalendar.showDropdown3Field === true && $('#edit_dlg_dropdown3_selectbox') !== undefined) {
                dropdown3_option_id = $('#edit_dlg_dropdown3_selectbox').val();
                dropdown3 = $('#edit_dlg_dropdown3_selectbox').text();
            }

            var dropdown4_option_id = -1;
            var dropdown4 = '';
            if (MyCalendar.showDropdown4Field === true && $('#edit_dlg_dropdown4_selectbox') !== undefined) {
                dropdown4_option_id = $('#edit_dlg_dropdown4_selectbox').val();
                dropdown4 = $('#edit_dlg_dropdown4_selectbox').text();
            }

            var dropdown5_option_id = -1;
            var dropdown5 = '';
            if (MyCalendar.showDropdown5Field === true && $('#edit_dlg_dropdown5_selectbox') !== undefined) {
                dropdown5_option_id = $('#edit_dlg_dropdown5_selectbox').val();
                dropdown5 = $('#edit_dlg_dropdown5_selectbox').text();
            }

            var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
            startdate = startdate - offsetClientToGMT;
            enddate = enddate - offsetClientToGMT;

            var str_date_start;
            var str_date_end;
            // var starttime = timepicker_starttime_hours_minutes;
            // var endtime = timepicker_endtime_hours_minutes;

            if (MyCalendar.showAMPM) {
                var str_date_start_tmp = event.start.format('mm/dd/yyyy') + ' ' + timepicker_starttime_hours_minutes;
                str_date_start = new Date(str_date_start_tmp).format('yyyy-mm-dd HH:MM:00');
                var str_date_end_tmp = event.end.format('mm/dd/yyyy') + ' ' + timepicker_endtime_hours_minutes;
                str_date_end = new Date(str_date_end_tmp).format('yyyy-mm-dd HH:MM:00');

            } else {
                str_date_start = event.start.format('yyyy-mm-dd') + ' ' + timepicker_starttime_hours_minutes;
                str_date_end = event.end.format('yyyy-mm-dd') + ' ' + timepicker_endtime_hours_minutes;
            }

            var arr_startdate_time = str_date_start.split(' ');
            var arr_startdate = arr_startdate_time[0].split('-');
            var dp_startdate_time = new Date(arr_startdate[1] + '/' + arr_startdate[2] + '/' + arr_startdate[0] + ' ' + arr_startdate_time[1]);
            var ts_startdate_time = Date.parse(dp_startdate_time) / 1000;

            var arr_enddate_time = str_date_end.split(' ');
            var arr_enddate = arr_enddate_time[0].split('-');
            var dp_enddate_time = new Date(arr_enddate[1] + '/' + arr_enddate[2] + '/' + arr_enddate[0] + ' ' + arr_enddate_time[1]);
            var ts_enddate_time = Date.parse(dp_enddate_time) / 1000;

            if (ts_startdate_time <= ts_enddate_time) {
                // opslaan in db
                //var dataString = 'event_id='+ event.event_id + '&allDay=' + event.allDay  + '&title='+ event.title + '&date_start='+startdate+'&date_end='+enddate+ '&color=' + MyCalendar.defaultEventColor;
                var data = {
                    event_id: event.event_id,
                    rep_event_id: event.rep_event !== undefined ? event.rep_event.rep_event_id : 0,
                    repair_pattern: bln_repair_pattern,
                    allDay: event.allDay,
                    interval: interval,
                    title: event.title,
                    location: event.location,
                    description: event.description,
                    phone: event.phone,
                    myurl: event.myurl,
                    date_start: startdate,
                    date_end: enddate,
                    str_date_start: str_date_start,
                    str_date_end: str_date_end,
                    time_start: timepicker_starttime_hours_minutes,
                    time_end: timepicker_endtime_hours_minutes,
                    color: color !== '' ? color : event.color,
                    weekdays: weekdays,
                    monthday: monthday,
                    yearmonthday: yearmonthday,
                    yearmonth: yearmonth,
                    every_x_days: every_x_days,
                    every_x_weeks: every_x_weeks,
                    cal_id: event.calendar_id, //MyCalendar.currentCalendar
                    calendar_id: calendar_id,
                    team_member_id: team_member_id,
                    dropdown1_option_id: dropdown1_option_id === null ? -1 : dropdown1_option_id,
                    dropdown2_option_id: dropdown2_option_id === null ? -1 : dropdown2_option_id,
                    dropdown3_option_id: dropdown3_option_id === null ? -1 : dropdown3_option_id,
                    dropdown4_option_id: dropdown4_option_id === null ? -1 : dropdown4_option_id,
                    dropdown5_option_id: dropdown5_option_id === null ? -1 : dropdown5_option_id,
                    dropdown1: dropdown1,
                    dropdown2: dropdown2,
                    dropdown3: dropdown3,
                    dropdown4: dropdown4,
                    dropdown5: dropdown5,
                    assign: $('#assign_checkbox') !== undefined && $('#assign_checkbox').is(':checked'),
                    unassign: $('#unassign_checkbox') !== undefined && $('#unassign_checkbox').is(':checked'),
                    recurring: $('#recurring_checkbox').is(':checked'),
                    token: MyCalendar.startEditToken,
                    updateThisItem: event.updateThisItem !== undefined ? event.updateThisItem : false,
                    disconnect: event.disconnect !== undefined ? event.disconnect : false
                };

                $.ajax({
                    type: "POST",
                    url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=update',
                    data: data,
                    dataType: 'json',
                    success: function (result) {
                        if (result.success) {
                            if (result.event !== undefined) {
                                var currentView = $('#calendar').fullCalendar('getView').name;
                                if (result.event.bln_change_cal_id) {
                                    if (event.rep_event !== undefined) {
                                        $('#calendar').fullCalendar('refetchEvents');

                                    } else if (MyCalendar.currentCalendar.indexOf(',') == -1) {
                                        $('#calendar').fullCalendar('removeEvents', result.event.event_id);

                                    } else {
                                        $('#calendar').fullCalendar('refetchEvents');
                                    }

                                } else if (event.rep_event !== undefined || currentView == 'agendaList') {
                                    // repeating events where updated
                                    $('#calendar').fullCalendar('refetchEvents');
                                    // } else if ((result.event.nightshift !== undefined && result.event.nightshift && !event.nightshift) ||
                                    //         result.event.nightshift !== undefined && !result.event.nightshift && event.nightshift) {
                                    // 
                                    //      $('#calendar').fullCalendar('refetchEvents');
                                } else {
                                    event = applyToObject(event, result.event);

                                    // team member
                                    if (result.event.team_member_id > 0) {
                                        event.team_member_id = result.event.team_member_id;
                                        event.team_member = result.event.team_member;
                                    }

                                    // custom dropdown 1
                                    if (result.event.dropdown1 !== undefined && result.event.dropdown1 !== null && result.event.dropdown1 !== '') {
                                        event.dropdown1 = result.event.dropdown1;
                                    }

                                    // custom dropdown 1
                                    if (result.event.dropdown2 !== undefined && result.event.dropdown2 !== null && result.event.dropdown2 !== '') {
                                        event.dropdown2 = result.event.dropdown2;
                                    }
                                    if (result.event.dropdown3 !== undefined && result.event.dropdown3 !== null && result.event.dropdown3 !== '') {
                                        event.dropdown3 = result.event.dropdown3;
                                    }
                                    if (result.event.dropdown4 !== undefined && result.event.dropdown4 !== null && result.event.dropdown4 !== '') {
                                        event.dropdown4 = result.event.dropdown4;
                                    }
                                    if (result.event.dropdown5 !== undefined && result.event.dropdown5 !== null && result.event.dropdown5 !== '') {
                                        event.dropdown5 = result.event.dropdown5;
                                    }
//console.log('update');
                                    $('#calendar').fullCalendar('updateEvent', event);
                                }
                                updateAmountEmployees(result.event.date_start);

                            } else {
                                $('#calendar').fullCalendar('refetchEvents');
                            }

                            me.dialog("close");


                        } else {
                            if (result.notloggedin) {
                                $('#calendar').fullCalendar('refetchEvents');
                                alert('You are not logged in');
                                window.location = MyCalendar.FULLCAL_URL;
                            } else {
                                //alert(Lang.Alert.ErrorSaving);
                                $('#error_message').html(Lang.Alert.Error + ': ' + result.error);
                            }
                        }

                    }
                });
                // return true;
            } else {
                $('#error_message').html(Lang.Alert.TimesNotCorrect);
                return false;
                // 	alert(Lang.Alert.TimesNotCorrect);
            }

        }
    };

    var updateAmountEmployees = function (day) {
        var currentView = $('#calendar').fullCalendar('getView').name;

        if (currentView == 'agendaWeek' && MyCalendar.showAvailableEmployeesRow && MyCalendar.loggedInUser > 0 && MyCalendar.loggedInUser != 1000000) {
            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/index.php?action=get_day_amount_available_employees',
                data: {user_id: MyCalendar.loggedInUser, visStart: day, visEnd: day},
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        //if(result.amount_employees[0] > -1) {

                        $('#header_row2_col_0').html(result.amount_employees[0] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[0] + ' monteur' + (result.amount_employees[0] > 1 ? 's' : '') + ' inzetbaar</span>');
                        $('#header_row2_col_1').html(result.amount_employees[1] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[1] + ' monteur' + (result.amount_employees[1] > 1 ? 's' : '') + ' inzetbaar</span>');
                        $('#header_row2_col_2').html(result.amount_employees[2] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[2] + ' monteur' + (result.amount_employees[2] > 1 ? 's' : '') + ' inzetbaar</span>');
                        $('#header_row2_col_3').html(result.amount_employees[3] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[3] + ' monteur' + (result.amount_employees[3] > 1 ? 's' : '') + ' inzetbaar</span>');
                        $('#header_row2_col_4').html(result.amount_employees[4] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[4] + ' monteur' + (result.amount_employees[4] > 1 ? 's' : '') + ' inzetbaar</span>');
                        //$('#header_row2_col_5').html(result.amount_employees[5] == 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[5] + ' monteurs inzetbaar</span>');
                        //$('#header_row2_col_6').html(result.amount_employees[6] == 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[6] + ' monteurs inzetbaar</span>');
                        //}
                    }
                }
            });

        }
    };

    // drag an item to another day
    var onEventDropEvent = function (event) {
        var currentView = $('#calendar').fullCalendar('getView').name;
        var startdate = Date.parse(event.start) / 1000;

        var str_date_start = new Date(startdate * 1000).format('yyyy-mm-dd HH:MM:00');
        var str_date_end;

        if (event.end === null && (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay')) {
            var enddate = startdate + (2 * 3600);	// 2 hours
            str_date_end = new Date(enddate * 1000).format('yyyy-mm-dd HH:MM:00');

        } else if (event.end === null) {
            var enddate = startdate;
            str_date_end = event.start.format('yyyy-mm-dd HH:MM:00');

        } else {
            var enddate = Date.parse(event.end) / 1000;
            str_date_end = event.end.format('yyyy-mm-dd HH:MM:00');
        }

        var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
        startdate = startdate - offsetClientToGMT;
        enddate = enddate - offsetClientToGMT;

        event.allDay = event.allDay ? 1 : 0;
        // opslaan in db

        var data = {
            event_id: event.id,
            allDay: event.allDay,
            date_start: startdate,
            date_end: enddate,
            title: event.title,
            str_date_start: str_date_start,
            str_date_end: str_date_end,
            color: event.color,
            cal_id: event.calendar_id,
            intern_dd: true
        };

        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=update',
            data: data,
            dataType: 'json',
            success: function (result) {
                if (result.success) {
                    if (result.event !== undefined) {
                        event = applyToObject(event, result.event);
                        $('#calendar').fullCalendar('updateEvent', event);
                    } else {
                        $('#calendar').fullCalendar('refetchEvents');
                    }
                    updateAmountEmployees(result.event.date_start);
                } else {
                    if (result.notloggedin) {
                        $('#calendar').fullCalendar('refetchEvents');
                        alert(Lang.Alert.NotLoggedIn);
                        window.location = MyCalendar.FULLCAL_URL;
                    } else {
                        alert(Lang.Alert.ErrorSaving);
                    }
                }
            }
        });
    };

    var checkAlterable = function (date) {
        if (MyCalendar.calAlterableStartdate === undefined || MyCalendar.calAlterableEnddate === undefined) {
            return true;
        }

        if (MyCalendar.currentCalendars.indexOf(',') >= 0 || MyCalendar.currentCalendars == 'all') {
            // more than 1 calendar selected

            return true;
        } else {
            var arr_startdate = MyCalendar.calAlterableStartdate.split('/');

            if (MyCalendar.datePickerDateFormat === null || MyCalendar.datePickerDateFormat == 'dd/mm/yy') {
                var dp_startdate = new Date(arr_startdate[2] + '/' + arr_startdate[1] + '/' + arr_startdate[0]);
            } else if (MyCalendar.datePickerDateFormat == 'mm/dd/yy') {
                var dp_startdate = new Date(arr_startdate[1] + '/' + arr_startdate[2] + '/' + arr_startdate[0]);
            }

            var arr_enddate = MyCalendar.calAlterableEnddate.split('/');

            if (MyCalendar.datePickerDateFormat === null || MyCalendar.datePickerDateFormat == 'dd/mm/yy') {
                var dp_enddate = new Date(arr_enddate[2] + '/' + arr_enddate[1] + '/' + arr_enddate[0]);
            } else if (MyCalendar.datePickerDateFormat == 'mm/dd/yy') {
                var dp_enddate = new Date(arr_enddate[1] + '/' + arr_enddate[2] + '/' + arr_enddate[0]);
            }

            if (date < dp_startdate || date > dp_enddate) {
                return false;
            } else {
                return true;
            }
        }
    };

    /**
     *	dayclick
     */
    var onSelectEvent = function (start, end, allDay) {
        if (!checkAlterable(start)) {
            showMessage(Lang.Alert.NotAllowedToAddOnThisDate, 'error');
            return false;
        }

        if (MyCalendar.onlyViewable) {
            if (MyCalendar.showNotAllowedMessages) {
                showMessage(Lang.Alert.CalendarOnlyViewable, 'warning');
            }
            return false;
        }

        if (MyCalendar.calCanAdd === undefined || MyCalendar.calCanAdd === false || MyCalendar.currentCalendars.indexOf(',') >= 0) {
            if (MyCalendar.currentCalendars.indexOf(',') == -1 && MyCalendar.currentCalendars !== 'all') {
                if (MyCalendar.showNotAllowedMessages) {
                    showMessage(Lang.Alert.NotAllowedToAdd, 'error');
                }
            } else if (MyCalendar.currentCalendars.indexOf(',') >= 0 || MyCalendar.currentCalendars == 'all') {
                showMessage(Lang.Alert.ChooseCalendarFirst, 'warning');

            }

            return false;
        }

        cleanRequiredFields();

        if (MyCalendar.showTeamMemberField) {
            $('#edit_dlg_user_selectbox').val([]);
            $("#edit_dlg_user_selectbox").pqSelect("refreshData");

        }
        $('#recurring_checkbox').prop('checked', false);

        $('#interval_container').hide();
        $('#interval_day_choice_div').hide();
        $('#interval_week_choice_div').hide();
        $('#interval_month_choice_div').hide();
        $('#interval_year_choice_div').hide();
        $('#info_txt').html('');
        $("select[name='interval']").val('D');

        //$('#interval_week_choice_div').show();
        $("#interval_week_choice_div input[name='day_1']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_2']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_3']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_4']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_5']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_6']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_7']").prop('checked', false);

//			if(dateFormat(Date.parse(start),'dd/mm/yy') == dateFormat(Date.parse(end),'dd/mm/yy')) {
//				// oneday item
//                
//				$('#interval_container').hide();
//				$('#interval_week_choice_div').hide();
//			} else {
//				// when more than 8 days are selected
//				// daterange must be at least 8 days to show interval (repeating) fields
//				$('#interval_week_choice_div').hide();
//				//if(((end.getTime() - start.getTime()) / 3600 / 1000 / 24) > 7) {
//				if(((end.getTime() - start.getTime()) / 3600 / 1000 / 24) > 7) {
//					$('#interval_container').show();
//					//var n = start.getDay();
//				} else {
//					$('#interval_container').hide();
//				}
//			}

        if (MyCalendar.calCanChangeColor) {
            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                $('#editdialog_colorpicker').show();
                $("#togglePaletteOnly").spectrum('set', MyCalendar.currentCalendarColor);
                $("#togglePaletteOnly").val(MyCalendar.currentCalendarColor);

            } else {
                $('#editdialog_simple_colorpicker').show();

            }
        } else {
            // hide colorpicker
            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                $('#editdialog_colorpicker').hide();
            } else {
                $('#editdialog_simple_colorpicker').hide();

            }
        }


        $("#dialog:ui-dialog").dialog("destroy");

        $('#edited_title').val('');
        if (MyCalendar.calendarnameIsTitle && MyCalendar.currentCalendars.indexOf(',') == -1 && MyCalendar.currentCalendarName !== undefined && MyCalendar.currentCalendarName !== '') {
            $('#edited_title').val(MyCalendar.currentCalendarName);
        }

        if ($('#edited_location') !== undefined) {
            $('#edited_location').val('');
        }
        if (MyCalendar.showLocationField) {
            // are there predefined locations set for this calendar, show a combo
            if (MyCalendar.locations !== undefined && MyCalendar.locations !== '' && MyCalendar.locations[0] !== undefined) {
                var str_select = '<select name="share_type" id="location_combo">';
                $.each(MyCalendar.locations, function (k, l) {
                    str_select += '<option value="' + l.name + '" ' + (k == 0 ? 'selected="selected"' : '') + '>' + l.name + '</option>';
                });
                str_select += '</select>';

                $('#location_combo').html(str_select);
                $('#edited_location').hide();
                $('#location_combo').show();
            } else {

                // else a normal textfield
                $('#location_combo').hide();
                $('#edited_location').show();
                $('#edited_location').val();
            }
        }

        if (MyCalendar.showDescriptionField) {
            $('#description_field_div').show();
        }
        if ($('#edited_description') !== undefined) {
            $('#edited_description').val('');
        }


        if (MyCalendar.showPhoneField) {
            $('#edited_phone').show();
            $('#edited_phone').val('');
            $('#edited_phone').removeAttr('disabled');
        }
        if (MyCalendar.showUrlField) {
            $('#edited_myurl').show();
            $('#edited_myurl').val('');
            $('#edited_myurl').removeAttr('disabled');

            $('#go_myurl_btn').attr('href', '#');
        }





        $('#event_id').val('');
        $('#upload_event_id').val('');
        $('#select_file_field').val('');

        $('#error_message').html('');

        $("#datepicker_startdate").datepicker('setDate', start);
        $("#datepicker_enddate").datepicker('setDate', end);

        $('#datepicker_startdate').removeAttr('disabled');
        $('#datepicker_enddate').removeAttr('disabled');

        var curr_hour = start.getHours();
        var curr_min = start.getMinutes();

        if (curr_hour == 0 && curr_min == 0) {

            if (MyCalendar.showAMPM) {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(dateFormat(now, 'hh:00 TT'));
                    $('#timepicker_endtime').val(dateFormat(now, 'hh:00 TT'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', now.format('hh:00 TT'));
                    $('#timepicker_endtime').timepicker('setTime', now.format('hh:00 TT'));
                }

            } else {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(dateFormat(now, 'HH:00'));
                    $('#timepicker_endtime').val(dateFormat(now, 'HH:00'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', now.format('HH:00'));
                    $('#timepicker_endtime').timepicker('setTime', now.format('HH:00'));
                }

            }

        } else {
            if (MyCalendar.showAMPM) {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(dateFormat(start, 'hh:MM TT'));
                    $('#timepicker_endtime').val(dateFormat(end, 'hh:MM TT'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', start.format('hh:MM TT'));
                    $('#timepicker_endtime').timepicker('setTime', end.format('hh:MM TT'));
                }

            } else {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(dateFormat(start, 'HH:MM'));
                    $('#timepicker_endtime').val(dateFormat(end, 'HH:MM'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', start.format('HH:MM'));
                    $('#timepicker_endtime').timepicker('setTime', end.format('HH:MM'));
                }

            }
        }


        var currentView = $('#calendar').fullCalendar('getView').name;


        $('#assign_checkbox').prop('checked', false);
        $('#unassign_checkbox').prop('checked', false);

        $('#assigned_by_user').html('');

        $('#team_member_unassign').hide();
        $('#team_member_assign').hide();

//        if(MyCalendar.showTeamMemberField === false) {
//            $('#team_member_assign').hide();
//            $('#team_member_unassign').hide();
//            $('#assigned_by_user').html('');
//        } else {
//            $('#team_member_unassign').hide();
//            $('#team_member_assign').show();
//        }

        $("#dialog-message").dialog({
            modal: true,
            title: Lang.Popup.TitleAdd,
            //height: 'auto',
            //width: 'auto',
            height: 'auto', //MyCalendar.showLocationField ? 460 : 430,
            width: 730,
            resizable: MyCalendar.dialogsResizable,
            create: function (evt, ui) {
                if (MyCalendar.useHtmlEditor) {
                    // ckeditor
                }
            },
            open: function () {
                if (MyCalendar.showFileUpload) {
                    $('#dialog-message').tabs({
                        selected: 0, // for newer jquery versions use 'active'
                        disabled: [1],
                        create: function (e, ui) {
                            // $('#closeBtn').click(function() {
                            //$('#dialog-movie-info').dialog('close');
                            // });

                        }
                    });
                }
                //$(this).parent().children('.ui-dialog-titlebar').remove();
            },
            buttons: [{
                    html: Lang.Popup.emailText,
                    class: "ui-button-left",
                    id: 'emailbtn',
                    //disabled: !MyCalendar.calCanMail,
                    click: function (a, b) {
                        var title = $('#edited_title')[0].value;
                        if (title != null && title != '') {
                            mailEvent($(this));

                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }
                    }
                }, {
                    html: Lang.Popup.saveButtonText,
                    click: function (a, b) {
                        var bln_success = checkRequiredFields();

                        if (bln_success) {

                            addEvent(start, end, $(this));
                        } else {
                            $('#error_message').html(Lang.Alert.FillInTheRequiredFields);
                        }


                    }
                }, {
                    html: Lang.Popup.closeButtonText,
                    click: function () {
                        $(this).dialog("close");
                    }
                }]
        });
        //$("#edited_title").attr("placeholder", Lang.Popup.EventTitle);
        //$("#edited_description").attr("placeholder", Lang.Popup.EventDescription);



        // FORM LABELS
        $('#wholeday_label_id').html(Lang.Popup.allDayLabel);
        $('#month_label_id').html(Lang.Popup.StartdateLabel);
        $('#time_label_id').html(Lang.Popup.EnddateLabel);
        $('#title_label_id').html(Lang.Popup.EventTitle);
        $('#color_label_id').html(Lang.Popup.EventColor);
        $('#location_label_id').html(Lang.Popup.EventLocation);
        $('#description_label_id').html(Lang.Popup.EventDescription);
        $('#phone_label_id').html(Lang.Popup.EventPhone);
        $('#myurl_label_id').html(Lang.Popup.EventUrl);
        $('#interval_label_id').html(Lang.Popup.EventInterval);
        $('.recurrence_label_id').html(Lang.Popup.EventRecurrence);
        $('#recurrence_monthly_dom_label').html(Lang.Popup.DayOfMonth);
        $('#recurrence_monthly_dow_label').html(Lang.Popup.DayOfWeek);
        $('#recurring_label_id').html(Lang.Popup.LabelRecurring);

        $('#edit_dialog_tab_info').html(Lang.Popup.LabelTabMain);
        $('#edit_dialog_tab_files').html(Lang.Popup.LabelTabFiles);

        $('#login_to_upload').html(Lang.Alert.LogInToUpload);
        $('#copy_to_month_label_id').html(Lang.Popup.copyToText);
        $('.label_every').html(Lang.Popup.Every);
        $('.label_days').html(Lang.Calendar.LabelDays);
        $('.label_weeks').html(Lang.Popup.Weeks);

        if (MyCalendar.calCanMail) {
            $('#emailbtn').show();
        } else {
            $('#emailbtn').hide();
        }

        $('#calendar_id_change_field').hide();

        $('#calendar').fullCalendar('unselect');

        if (MyCalendar.useHtmlEditor) {
            //
        }

        if (MyCalendar.showFileUpload) {
            $('#files_div').html('');
            $('#file_upload_form').show();
            $('#max_ten_files_div').hide();
        }

        show_hide_dialog_fields();


        if ((currentView == 'month' && MyCalendar.alldayIsDefault) || (currentView !== 'month' && allDay)) {
            disableTimeCombos();
            $('#allday_checkbox').prop('checked', true);

        } else {
            $('#allday_checkbox').prop('checked', false);
            enableTimeCombos();
        }

//        if (MyCalendar.showTeamMemberField) {
//            $('#edit_dlg_user_selectbox').show();
//        }
        if ($('#edit_dlg_user_selectbox') !== undefined) {
            $('#edit_dlg_user_selectbox').val('');
        }

//        if (MyCalendar.showDropdown1Field) {
//            $('#edit_dlg_dropdown1_selectbox').show();
//        }
        if ($('#edit_dlg_dropdown1_selectbox') !== undefined) {
            $('#edit_dlg_dropdown1_selectbox').val(-1);
        }

//        if (MyCalendar.showDropdown2Field) {
//            $('#edit_dlg_dropdown2_selectbox').show();
//        }
        if ($('#edit_dlg_dropdown2_selectbox') !== undefined) {
            $('#edit_dlg_dropdown2_selectbox').val(-1);
        }
        if ($('#edit_dlg_dropdown3_selectbox') !== undefined) {
            $('#edit_dlg_dropdown3_selectbox').val(-1);
        }
        if ($('#edit_dlg_dropdown4_selectbox') !== undefined) {
            $('#edit_dlg_dropdown4_selectbox').val(-1);
        }
        if ($('#edit_dlg_dropdown5_selectbox') !== undefined) {
            $('#edit_dlg_dropdown5_selectbox').val(-1);
        }

        // $( "#edit_dlg_user_selectbox" ).pqSelect( "open" ); 
        $("#edit_dlg_dropdown1_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown2_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown3_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown4_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown5_selectbox").selectmenu({
            width: 188
        });
        $('#edit_dlg_calendar_selectbox').selectmenu({
            width: 188
        });

//        if ($('.pq-select-text:has(.ui-icon-triangle-1-s)').length == 0) {
//            $('.pq-select-text').prepend('<span class="ui-selectmenu-icon ui-icon ui-icon-triangle-1-s" style="padding-right:5px;"></span>');
//            $('span.ui-icon-triangle-1-s').css('padding-right', '-5px !important');
//        }

        $("#edit_dlg_dropdown1_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown2_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown3_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown4_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown5_selectbox").selectmenu('refresh', true);

        $("#edit_dlg_calendar_selectbox").selectmenu('refresh', true);
    };

    var show_hide_dialog_fields = function (event) {
        if ((event === undefined && (MyCalendar.showPhoneField === undefined || MyCalendar.showPhoneField)) || (event !== undefined && event.show_phone_field)) {
            $('#phone_field_div').show();
        } else {
            $('#phone_field_div').hide();
        }

        if ((event === undefined && (MyCalendar.showLocationField === undefined || MyCalendar.showLocationField)) || (event !== undefined && event.show_location_field)) {
            $('#location_field_div').show();
        } else {
            $('#location_field_div').hide();
        }

        if ((event === undefined && (MyCalendar.showDescriptionField === undefined || MyCalendar.showDescriptionField)) || (event !== undefined && event.show_description_field)) {
            $('#description_field_div').show();
        } else {
            $('#description_field_div').hide();
        }

        if ((event === undefined && (MyCalendar.showUrlField === undefined || MyCalendar.showUrlField)) || (event !== undefined && event.show_url_field)) {
            $('#url_field_div').show();
        } else {
            $('#url_field_div').hide();
        }

        if ((event === undefined && (MyCalendar.showTeamMemberField === undefined || MyCalendar.showTeamMemberField)) || (event !== undefined && event.show_team_member_field)) {
            $('#user_id_change_field').show();
        } else {
            $('#user_id_change_field').hide();
        }

        if ((event === undefined && (MyCalendar.showDropdown1Field === undefined || MyCalendar.showDropdown1Field)) || (event !== undefined && event.show_dropdown_1_field)) {
            $('#custom_dropdown_1_combo').show();
        } else {
            $('#custom_dropdown_1_combo').hide();
        }

        if ((event === undefined && (MyCalendar.showDropdown2Field === undefined || MyCalendar.showDropdown2Field)) || (event !== undefined && event.show_dropdown_2_field)) {
            $('#custom_dropdown_2_combo').show();
        } else {
            $('#custom_dropdown_2_combo').hide();
        }

        if ((event === undefined && (MyCalendar.showDropdown3Field === undefined || MyCalendar.showDropdown3Field)) || (event !== undefined && event.show_dropdown_3_field)) {
            $('#custom_dropdown_3_combo').show();
        } else {
            $('#custom_dropdown_3_combo').hide();
        }

        if ((event === undefined && (MyCalendar.showDropdown4Field === undefined || MyCalendar.showDropdown4Field)) || (event !== undefined && event.show_dropdown_4_field)) {
            $('#custom_dropdown_4_combo').show();
        } else {
            $('#custom_dropdown_4_combo').hide();
        }

        if ((event === undefined && (MyCalendar.showDropdown5Field === undefined || MyCalendar.showDropdown5Field)) || (event !== undefined && event.show_dropdown_5_field)) {
            $('#custom_dropdown_5_combo').show();
        } else {
            $('#custom_dropdown_5_combo').hide();
        }

        $('#title_label_id').append(' *');

        if (MyCalendar.descriptionFieldRequired) {
            // class required en *
            $('#description_label_id').append(' *');
        } else {

        }
        if (MyCalendar.locationFieldRequired) {
            // class required en *
            $('#location_label_id').append(' *');
        } else {

        }
        if (MyCalendar.phoneFieldRequired) {
            // class required en *
            $('#phone_label_id').append(' *');
        } else {

        }
        if (MyCalendar.urlFieldRequired) {
            // class required en *
            $('#myurl_label_id').append(' *');
        } else {

        }

    }

    var getViewAreaHtml = function (event, mouseover) {
        var startdate = dateFormat(event.start, short_date_notation);
        if (event.end === null) {
            var enddate = startdate;
        } else {
            var enddate = dateFormat(event.end, short_date_notation);
        }

        var view_startdate = startdate + (startdate != enddate ? ' - ' + enddate : '');
        var view_rep_start = dateFormat(event.rep_start, short_date_notation);
        var view_rep_end = dateFormat(event.rep_end, short_date_notation);

        if (event.time_end == event.time_start || event.allDay) {
            view_times = Lang.Popup.allDayLabel || 'allDay';

        } else {
            var view_times = dateFormat(Date.parse(event.start), hour_notation) + ' - ' + dateFormat(Date.parse(event.end), hour_notation);
        }


        var view_area_html = '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.title + '</p>';


        if (event.rep_event !== undefined) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-46-calendar.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + (startdate == enddate ? startdate : startdate + ' - ' + enddate) + '</span></p>';
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-82-refresh.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + view_rep_start + ' - ' + view_rep_end + '</span></p>';
        } else {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-46-calendar.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + view_startdate + '</span></p>';
        }

        view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-55-clock.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + view_times + '</span></p>';

        if (event.rep_event !== undefined) {
            if (event.rep_event.rep_interval === 'D') {
                var every_x_days = event.rep_event.every_x_days || 0;
                var rep_day_text = (every_x_days > 0 ? (every_x_days == 1 ? Lang.Popup.DailyOn : Lang.Popup.Every + ' ' + every_x_days + ' ' + Lang.Calendar.LabelDays.toLowerCase()) : '') + ' ';

                view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><span class="view_area' + (mouseover ? '_mo' : '') + '">' + rep_day_text + '</span></p>';

            } else if (event.rep_event.rep_interval === 'W') {
                //repeating_weekday		example:day_MO,day_WE
                var arr_weekdays = event.rep_event.weekdays.split(',');
                var every_x_weeks = event.rep_event.every_x_weeks || 0;
                var rep_week_text = (every_x_weeks > 0 ? (every_x_weeks == 1 ? Lang.Popup.WeeklyOn : Lang.Popup.Every + ' ' + every_x_weeks + ' ' + Lang.Popup.Weeks + ' ' + Lang.Popup.On) : '') + ' ';
                var counter = 0;

                $.each(arr_weekdays, function (key, value) {
                    if (value !== '') {
                        if (counter > 0) {
                            rep_week_text += ', ';
                        }
                        rep_week_text += Lang.Fullcalendar.dayNames[value == 7 ? 0 : value];
                        counter++;
                    }

                });

                view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><span class="view_area' + (mouseover ? '_mo' : '') + '">' + rep_week_text + '</span></p>';

            } else if (event.rep_event.rep_interval === 'M') {
                if (event.rep_event.monthday === 'dom') {
                    // info_txt
                    rep_month_text = Lang.Popup.MonthlyOnDay + ' ' + event.rep_start_day;

                } else {
                    var arr_startdate = event.rep_start.split('-');
                    var arr_date = MyCalendar.datePickerDateFormat.split('/');
//                    if (MyCalendar.datePickerDateFormat === null || MyCalendar.datePickerDateFormat == 'dd/mm/yy') {
//
//                        var dp_startdate = new Date(arr_startdate[2] + '/' + arr_startdate[1] + '/' + arr_startdate[0]);
//                    } else if (MyCalendar.datePickerDateFormat == 'mm/dd/yy') {
//                        var dp_startdate = new Date(arr_startdate[1] + '/' + arr_startdate[2] + '/' + arr_startdate[0]);
//                    }
                    var dp_startdate = new Date(event.rep_start + ' 12:00:00');

                    var rep_start_dt = dp_startdate.getDay();
                    if (MyCalendar.FCfirstDay == 1) {
                        rep_start_dt++;
                        if (rep_start_dt == 7) {
                            rep_start_dt = 0;
                        }
                    }
                    rep_month_text = Lang.Popup.MonthlyOn + ' ' + Lang.Fullcalendar.dayNames[rep_start_dt] + ', ' + Lang.Popup.Starting + ' ' + (arr_date[0] == 'dd' ? dp_startdate.format('dd/mm') : dp_startdate.format('mm/dd'));

                }
                view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><span class="view_area' + (mouseover ? '_mo' : '') + '">' + rep_month_text + '</span></p>';

            }
        } else {

        }


        // location
        if (event.location !== undefined && event.location !== '' && (!mouseover || (mouseover && (MyCalendar.showLocationField || event.show_location_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" alt="Call" title="Call" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-90-building.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.location + '</span></p>';
        }

// description
        if (event.description !== undefined && event.description !== '') {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.description + '</span></p>';
        }

        // phone
        if (event.phone !== undefined && event.phone !== '' && (!mouseover || (mouseover && (MyCalendar.showPhoneField || event.show_phone_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" alt="" title="" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-443-earphone.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.phone + '</span></p>';
        }

        // myurl
        if (event.myurl !== undefined && event.myurl !== null && event.myurl !== '' && (!mouseover || (mouseover && (MyCalendar.showUrlField || event.show_url_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" alt="" title="" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-341-globe.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.myurl + '</span></p>';
        }

        // team-member
        if (event.team_member_id !== undefined && event.team_member_id !== null && event.team_member_id !== '' && event.team_member_id != -1 && (!mouseover || (mouseover && (MyCalendar.showTeamMemberField || event.show_team_member_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '"><img style="width:14px;" alt="Team-member" title="Team-member" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-4-user.png" /> <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.team_member + '</span></p>';
        }

        // custom dropdown 1
        if (event.dropdown1 !== undefined && event.dropdown1 !== null && event.dropdown1 !== '' && event.dropdown1_option_id > 0 && (!mouseover || (mouseover && (MyCalendar.showDropdown1Field || event.show_dropdown_1_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.dropdown1_label + '  <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.dropdown1 + '</span></p>';
        }

        // custom dropdown 2
        if (event.dropdown2 !== undefined && event.dropdown2 !== null && event.dropdown2 !== '' && event.dropdown2_option_id > 0 && (!mouseover || (mouseover && (MyCalendar.showDropdown2Field || event.show_dropdown_2_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.dropdown2_label + '  <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.dropdown2 + '</span></p>';
        }

        // custom dropdown 3
        if (event.dropdown3 !== undefined && event.dropdown3 !== null && event.dropdown3 !== '' && event.dropdown3_option_id > 0 && (!mouseover || (mouseover && (MyCalendar.showDropdown3Field || event.show_dropdown_3_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.dropdown3_label + ' <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.dropdown3 + '</span></p>';
        }

        // custom dropdown 4
        if (event.dropdown4 !== undefined && event.dropdown4 !== null && event.dropdown4 !== '' && event.dropdown4_option_id > 0 && (!mouseover || (mouseover && (MyCalendar.showDropdown4Field || event.show_dropdown_4_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.dropdown4_label + '  <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.dropdown4 + '</span></p>';
        }

        // custom dropdown 5
        if (event.dropdown5 !== undefined && event.dropdown5 !== null && event.dropdown5 !== '' && event.dropdown5_option_id > 0 && (!mouseover || (mouseover && (MyCalendar.showDropdown5Field || event.show_dropdown_5_field)))) {
            view_area_html += '<p class="view_area_label' + (mouseover ? '_mo' : '') + '">' + event.dropdown5_label + '  <span class="view_area' + (mouseover ? '_mo' : '') + '">' + event.dropdown5 + '</span></p>';
        }

        return view_area_html;
    };

    var onMouseoverEvent = function (me, event) {
        var currentView = $('#calendar').fullCalendar('getView').name;

        var ts_start = Date.parse(event.start) / 1000;
        var ts_end = Date.parse(event.end) / 1000;

        if (MyCalendar.showViewType == 'mouseover') {
            if (((currentView == 'agendaDay' || currentView == 'basicDay' || currentView == 'agendaWeek' || currentView == 'basicWeek') && ts_end - ts_start == 1800) || (MyCalendar.onlyShowMouseoverInMonthview && currentView == 'month') || !MyCalendar.onlyShowMouseoverInMonthview) {

                var view_area_html = getViewAreaHtml(event, true);

                var layer = '<div id="events-layer" class="fc-transparent arrow_box"  style="padding:7px;color:black;position:absolute; width:' + MyCalendar.MouseoverWidth + 'px; height:auto; top:20px; left:40px;border-radius:5px;z-index:1000;">'
                        + '<span style="" id="mouseover' + event.event_id + '">';

                layer += view_area_html;

                layer += '</span></div>';

                me.append(layer);

                $("#mouseover" + event.event_id).hide();
                $("#mouseover" + event.event_id).fadeIn(200);


            }
        }

        if (event.allowEdit && !me.hasClass('fc-agendaList-item') && MyCalendar.showMouseoverDeleteButton) {

            /*
             *	SHOW DELETE ICON, ALSO POSSIBLE TO SHOW AN EDIT ICON HERE
             */
            var layer = '<div id="events-layer2" class="fc-transparent" style="position:absolute; width:100%; height:100%; top:-1px; text-align:right; z-index:100">'
                    + '<a><img src="images/delete.png" title="delete" width="14" id="delbut' + event.id + '" border="0" style="padding-right:5px; padding-top:1px;" /></a>'
                    + '</div>';

            me.append(layer);
            $("#delbut" + event.id).hide();
            $("#delbut" + event.id).fadeIn(200);
            $("#delbut" + event.id).click(function () {
                if (event.id) {
                    // opslaan in db
                    var dataString = 'event_id=' + event.id;
                    $.ajax({
                        type: "POST",
                        url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=del',
                        data: dataString,
                        success: function (html) {
                            updateAmountEmployees(event.date_start);
                        }
                    });
                    $('#calendar').fullCalendar('removeEvents', event.id);
                    return false;
                }
            });
        }
    };

    var deleteEvent = function (me, event, delete_all) {
        var delete_success = false;
        if (event.id) {
            // opslaan in db
            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=del',
                data: {
                    event_id: event.event_id,
                    rep_event_id: event.rep_event !== undefined ? event.repeating_event_id : 0,
                    delete_all: event.rep_event !== undefined && delete_all
                },
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        if (event.rep_event === undefined) {
                            $('#calendar').fullCalendar('removeEvents', event.id);	// goes wrong when 1 item of repeat is deleted
                        } else {
                            $('#calendar').fullCalendar('refetchEvents');
                        }
                        me.dialog("close");
                        $('#error_message').html('');

                        updateAmountEmployees(event.date_start);
                    } else {
                        if (result.notloggedin) {
                            $('#calendar').fullCalendar('refetchEvents');
                            alert(Lang.Alert.NotLoggedIn);
                            window.location = MyCalendar.FULLCAL_URL;
                        } else {
                            alert(Lang.Alert.ErrorSaving);
                        }

                    }
                }
            });
        }
    };

    var checkRequiredFields = function () {
        var title = $('#edited_title').val();
        var description = $('#edited_description').val();
        var phone = $('#edited_phone').val();
        var myurl = $('#edited_myurl').val();
        var location = $('#edited_location').val();

        var errorcount = 0;

        if (title === null || title === '') {
            $('#edited_title').addClass('error_color');
            errorcount++;
        }
        if (MyCalendar.descriptionFieldRequired && $('#edited_description').is(":visible") && (description === null || description === '')) {
            $('#edited_description').addClass('error_color');
            errorcount++;
        }
        if (MyCalendar.locationFieldRequired && $('#edited_location').is(":visible") && (location === null || location === '')) {
            $('#edited_location').addClass('error_color');
            errorcount++;
        }
        if (MyCalendar.phoneFieldRequired && $('#edited_phone').is(":visible") && (phone === null || phone === '')) {
            $('#edited_phone').addClass('error_color');
            errorcount++;
        }
        if (MyCalendar.urlFieldRequired && $('#edited_myurl').is(":visible") && (myurl === null || myurl === '')) {
            $('#edited_myurl').addClass('error_color');
            errorcount++;
        }

        if (errorcount > 0) {
            return false;
        } else {
            return true;
        }
    };

    var cleanRequiredFields = function () {
        if ($('#edited_title')) {
            $('#edited_title').removeClass('error_color');
        }
        if ($('#edited_description')) {
            $('#edited_description').removeClass('error_color');
        }
        if ($('#edited_phone')) {
            $('#edited_phone').removeClass('error_color');
        }
        if ($('#edited_location')) {
            $('#edited_location').removeClass('error_color');
        }
        if ($('#edited_myurl')) {
            $('#edited_myurl').removeClass('error_color');
        }

    };

    var stopEdit = function (event_id) {

        // remove row in current_editing table
        var data = {
            event_id: event_id,
            token: MyCalendar.startEditToken
        };

        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=stop_edit',
            data: data,
            dataType: 'json',
            success: function (result) {
                MyCalendar.startEditToken = '';
//                   if(result.success) {
//
//                   } else {
//                       $('#error_message').html(Lang.Alert.Error + ': ' + Lang.Alert.EventAlreadyOpened);
//
//                   }
            }
        });


    }

    /**
     * clicked on an event
     */
    var onClickEvent = function (event, bln_return_to_custom_listview) {

        if (!event.allowEdit) {  // && MyCalendar.calCanView === false) {
            if (MyCalendar.showNotAllowedMessages) {
                showMessage(Lang.Alert.NotAllowedToEdit, 'error');
            }
            return false;
        }

        if (MyCalendar.onlyViewable) {
            if (MyCalendar.showNotAllowedMessages) {
                showMessage(Lang.Alert.CalendarOnlyViewable, 'info');
            }
            return false;
        }

        cleanRequiredFields();



        if (MyCalendar.saveCurrentEditing) {
            // put row in current_editing table
            var data = {
                event_id: event.event_id
            };

            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=start_edit',
                data: data,
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        MyCalendar.startEditToken = result.token;
                    } else {
                        $('#error_message').html(Lang.Alert.Error + ': ' + Lang.Alert.EventAlreadyOpened);

                        // disable all buttons, except the close button
                        $('#emaileditbtn').button('disable');
                        $('#restorebtn').button('disable');
                        $('#updatebtn').button('disable');
                        $('#deletebtn').button('disable');
                    }
                }
            });

        }

        $('#recurring_checkbox').prop('checked', false);


        $('#event_id').val(event.event_id);
        $('#upload_event_id').val(event.event_id);

        var startdate = event._start;
        if (event._end === null) {
            var enddate = startdate;
        } else {
            var enddate = event._end;
        }



        if (event.rep_start !== undefined) {
            $("#datepicker_startdate").datepicker('setDate', new Date(Date.parse(event.rep_start + ' 12:00:00'))); // or dateFormat(event._start,'dd/mm/yyyy')
            $("#datepicker_enddate").datepicker('setDate', new Date(Date.parse(event.rep_end + ' 12:00:00')));

        } else {
            $("#datepicker_startdate").datepicker('setDate', startdate);//$( "#datepicker_startdate" ).datepicker('setDate', dateFormat(Date.parse(startdate),'dd/mm/yy')); // or dateFormat(event._start,'dd/mm/yyyy')
            $("#datepicker_enddate").datepicker('setDate', enddate);//$( "#datepicker_enddate" ).datepicker('setDate', dateFormat(Date.parse(enddate),'dd/mm/yy'));

        }

//        if (event.rep_start !== undefined) {
//            var ts_rep_start = Date.parse(event.rep_start + 'T12:00:00') / 1000;
//            var ts_rep_end = Date.parse(event.rep_end + 'T12:00:00') / 1000;
//
//            var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
//
//            ts_rep_start = ts_rep_start - offsetClientToGMT;
//            ts_rep_end = ts_rep_end - offsetClientToGMT;
//
//            var calc_startdate = new Date(ts_rep_start * 1000).format(MyCalendar.datePickerDateFormat);
//            var calc_enddate = new Date(ts_rep_end * 1000).format(MyCalendar.datePickerDateFormat);
//
//           // $('#event_edit_dlg_event_start_end').show();
//           // $('#event_edit_dlg_event_start_end_text').show();
//            
//    //TODO        $('#event_edit_dlg_pattern_startdate').show();
//    //TODO        $('#event_edit_dlg_pattern_enddate').show();
//            
//    //        $("#datepicker_pattern_startdate").datepicker('setDate', calc_startdate); // or dateFormat(event._start,'dd/mm/yyyy')
//    //        $("#datepicker_pattern_enddate").datepicker('setDate', calc_enddate);
//
//     console.log(event.rep_start, dateFormat(Date.parse(event.rep_start), MyCalendar.datePickerDateFormat));      
//           // var str_start_end_normal = startdate == enddate ? startdate.format(MyCalendar.datePickerDateFormat) : startdate.format(MyCalendar.datePickerDateFormat) + ' ' + Lang.Popup.Until + ' ' + enddate.format(MyCalendar.datePickerDateFormat);
//           // $('#event_edit_dlg_event_start_end_text').html(str_start_end_normal);
//
//            $("#datepicker_startdate").datepicker('setDate', Date.parse(event.rep_start)); // or dateFormat(event._start,'dd/mm/yyyy')
//            $("#datepicker_enddate").datepicker('setDate', dateFormat(Date.parse(event.rep_end), MyCalendar.datePickerDateFormat));
//
//        } else {
//            $("#datepicker_startdate").datepicker('setDate', startdate);//$( "#datepicker_startdate" ).datepicker('setDate', dateFormat(Date.parse(startdate),'dd/mm/yy')); // or dateFormat(event._start,'dd/mm/yyyy')
//            $("#datepicker_enddate").datepicker('setDate', enddate);//$( "#datepicker_enddate" ).datepicker('setDate', dateFormat(Date.parse(enddate),'dd/mm/yy'));
//
//           // $('#event_edit_dlg_event_start_end').hide();
//           // $('#event_edit_dlg_event_start_end_text').hide();
//           // $('#event_edit_dlg_event_start_end_text').html('');
//            
//    //TODO        $('#event_edit_dlg_pattern_startdate').hide();
//    //TODO        $('#event_edit_dlg_pattern_enddate').hide();
//        }

        if (event.canChangeColor) {
            // show colorpicker
            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                $('#editdialog_colorpicker').show();
                setTimeout(function () {
                    $('#togglePaletteOnly').val(event.color);

                    $("#togglePaletteOnly").spectrum('set', event.color);
                }, 300);

            } else {
                $('#editdialog_simple_colorpicker').show();

            }

        } else {
            // hide colorpicker
            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                $('#editdialog_colorpicker').hide();
            } else {
                $('#editdialog_simple_colorpicker').hide();

            }
        }

        $("#interval_week_choice_div input[name='day_1']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_2']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_3']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_4']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_5']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_6']").prop('checked', false);
        $("#interval_week_choice_div input[name='day_7']").prop('checked', false);

        if (event.rep_event !== undefined) {
            $('#recurring_checkbox').prop('checked', true);

            // this is a repeating event
            startdate = event.repeating_startdate;
            enddate = event.repeating_enddate;
            $('#interval_container').show();

            // set interval
            //$('#interval_div').val(event.repeating_interval);
            $("select[name='interval']").val(event.rep_event.rep_interval);

            $('#interval_day_choice_div').hide();
            $('#interval_week_choice_div').hide();
            $('#interval_month_choice_div').hide();
            $('#interval_year_choice_div').hide();

            if (event.rep_event.rep_interval == 'D') {
                $('#interval_day_choice_div').show();

                var every_x_days = event.rep_event.every_x_days;

                $('#daily_every_x_days').val(every_x_days);

            } else if (event.rep_event.rep_interval == 'W') {
                $('#interval_week_choice_div').show();

                var every_x_weeks = event.rep_event.every_x_weeks;

                $('#weekly_every_x_weeks').val(every_x_weeks);

                //repeating_weekday		example:day_MO,day_WE
                var arr_weekdays = event.rep_event.weekdays.split(',');

                var rep_week_text = Lang.Popup.WeeklyOn + ' ';
                var counter = 0;

                $.each(arr_weekdays, function (key, value) {
                    if (value !== '') {
                        if (counter > 0) {
                            rep_week_text += ', ';
                        }

                        rep_week_text += Lang.Fullcalendar.dayNames[value == 7 ? 0 : value];
                        counter++;

                        $("#interval_week_choice_div input[name='day_" + value + "']").prop('checked', true);
                    }

                });

                $('#info_txt').html(rep_week_text);

            } else if (event.rep_event.rep_interval == 'M') {

                $('#interval_month_choice_div').show();
                var monthday = event.rep_event.monthday;

                //   $("#radio_1").prop("checked", true)
                $('input:radio[name="monthday"]').filter('[value="' + event.rep_event.monthday + '"]').prop('checked', true);

//                $('#interval_month_choice_div input:radio[name="monthday"]').each(function (index, item) {
//                    monthday = $(item).val();
//                    if (monthday == event.rep_event.monthday) {
//                        $(item).prop('checked', true);
//                    }
//                });

                if (event.rep_event.monthday == 'dom') {
                    // info_txt
                    $('#info_txt').html(Lang.Popup.MonthlyOnDay + ' ' + $("#datepicker_startdate").datepicker('getDate').getDate());

                } else {
                    var arr_date = MyCalendar.datePickerDateFormat.split('/');
                    var rep_start_dt = new Date(event.rep_start).getDay();
                    console.log(rep_start_dt);
                    if (MyCalendar.FCfirstDay == 1) {
                        rep_start_dt--;
                        if (rep_start_dt == -1) {
                            rep_start_dt = 6;
                        }
                    }
                    console.log(event);
                    rep_month_text = Lang.Popup.MonthlyOn + ' ' + Lang.Fullcalendar.dayNames[rep_start_dt] + ', ' + Lang.Popup.Starting + ' ' + (arr_date[0] == 'dd' ? $("#datepicker_startdate").datepicker('getDate').format('dd/mm') : $("#datepicker_startdate").datepicker('getDate').format('mm/dd'));
                    $('#info_txt').html(rep_month_text);

                }

            } else if (event.rep_event.rep_interval == 'Y') {
                var yearly_dom = event.rep_event.yearmonthday;
                var yearly_month = Lang.Fullcalendar.monthNames[event.rep_event.yearmonth];
                var ts_endyear_recurring_date = Date.parse(event.rep_event.yearmonth + '/' + yearly_dom + '/' + $("#datepicker_enddate").datepicker('getDate').getFullYear());
                var ts_enddate = $("#datepicker_enddate").datepicker('getDate').getTime();

                var until = event.rep_event.until !== undefined ? event.rep_event.until : '';

//                        if(ts_endyear_recurring_date <= ts_enddate) {
//                            until = $( "#datepicker_enddate" ).datepicker('getDate').getFullYear();
//                        } else {
//                            until = $( "#datepicker_enddate" ).datepicker('getDate').getFullYear() -1;
//                        }

                $('#yearly_dom').val(yearly_dom);
                $('#yearly_month').val(event.rep_event.yearmonth);
                $('#interval_year_choice_div').show();

                $('#info_txt').html(Lang.Popup.YearlyOn + ' ' + yearly_dom + ' ' + yearly_month + ' ' + Lang.Popup.Until + ' ' + until);
            }

            //} else if( event.end != null && ((event.end.getTime() - event.start.getTime()) / 3600 / 1000 / 24) > 7) {
//				} else if( event.recurring) {
//                    $('#recurring_checkbox').prop('checked', true);	
//                    $('#interval_container').show();
//					//var n = start.getDay();

        } else {	//if(dateFormat(Date.parse(startdate),'dd/mm/yy') == dateFormat(Date.parse(enddate),'dd/mm/yy')) {
            // 1 day event, don't show the repeating stuff
            $('#interval_container').hide();
            $('#interval_week_choice_div').hide();
            $('#interval_month_choice_div').hide();
            $('#interval_year_choice_div').hide();
            $('#interval_day_choice_div').hide();
            $('#info_txt').html('');
            $("select[name='interval']").val('D');
        }


        // reset some things
        $("#dialog:ui-dialog").dialog("destroy");

        // setvalues
        $('#edited_title').val(event.title);

        if (event.description !== null && (MyCalendar.showDescriptionField || event.show_description_field)) {
            $('#edited_description').val(event.description);
        } else {
            $('#edited_description').val('');
        }

        $('#assign_checkbox').prop('checked', false);
        $('#unassign_checkbox').prop('checked', false);

        if (MyCalendar.showTeamMemberField === false) {
            $('#team_member_assign').hide();
            $('#team_member_unassign').hide();
            $('#assigned_by_user').html('');
        } else {

            // fill the teammember dropdoenlist with correct users of the usergroup
            //  $('#edit_dlg_user_selectbox').find("option:gt(0)").remove();

//            $.each(event.users, function(key,r) {
//                $('#edit_dlg_user_selectbox')
//                    .append($("<option></option>")
//                    .attr("value",r.user_id)
//                    .text(r.fullname)); 
//            });

            if (event.assigned_by_name !== undefined && event.assigned_by_name !== '') {
                $('#assigned_by_user').html(Lang.Popup.AssignedBy + ': ' + event.assigned_by_name);
                $('#team_member_assign').hide();
                $('#team_member_unassign').show();
            } else {
                $('#assigned_by_user').html('');
                $('#team_member_unassign').hide();
                $('#team_member_assign').show();
            }
        }


        if (event.location !== null && (MyCalendar.showLocationField || event.show_location_field)) {
            // are there predefined locations set for this calendar, show a combo
            if (MyCalendar.locations !== undefined && MyCalendar.locations !== '' && MyCalendar.locations[0] !== undefined) {
                var str_select = '<select name="share_type" id="location_combo">';
                $.each(MyCalendar.locations, function (k, l) {
                    str_select += '<option value="' + l.name + '" ' + (event.location == l.name ? 'selected="selected"' : '') + '>' + l.name + '</option>';
                });
                str_select += '</select>';

                $('#location_combo').html(str_select);
                $('#edited_location').hide();
                $('#location_combo').show();
            } else {

                // else a normal textfield
                $('#location_combo').hide();
                $('#edited_location').show();
                $('#edited_location').val(event.location);
            }


        }


        if (event.phone !== null && (MyCalendar.showPhoneField || event.show_phone_field)) {
            $('#edited_phone').val(event.phone);
            $('#edited_phone').removeAttr('disabled');
        } else {
            $('#edited_phone').val('');
        }

        $('#edited_myurl').val('');

        if (event.myurl !== null && (MyCalendar.showUrlField || event.show_url_field)) {
            $('#edited_myurl').val(event.myurl);
            $('#edited_myurl').removeAttr('disabled');
        }

        $('#error_message').html('');

        if (event.start !== null) {
            var starttime_to_set = null;

            if (MyCalendar.showAMPM) {
                var starttime_to_set = event.start.format('hh:MM TT');
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(starttime_to_set);
                } else {
                    $('#timepicker_starttime').timepicker('setTime', starttime_to_set);
                }

            } else {
                var starttime_to_set = event.start.format('HH:MM');

                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(starttime_to_set);
                } else {
                    $('#timepicker_starttime').timepicker('setTime', starttime_to_set);
                }
            }


        } else {
            if (MyCalendar.showAMPM) {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(now.format('hh:MM TT'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', now.format('hh:MM TT'));
                }

            } else {

                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_starttime').val(now.format('HH:MM'));
                } else {
                    $('#timepicker_starttime').timepicker('setTime', now.format('HH:MM'));
                }
            }
        }

        var startdate = Date.parse(event.start) / 1000;

        if (event.end !== null || (event.end === null && event.time_end !== '')) {
            if (event.end === null) {
                event.end = event.start;

                if (event.time_end !== '') {
                    var enddate = new Date(event.end.format('mm/dd/yyyy') + ' ' + event.time_end);
                    event.end = enddate;
                }



            }

            var endtime_to_set = null;
            if (MyCalendar.showAMPM) {
                endtime_to_set = event.end.format('hh:MM TT');
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_endtime').val(endtime_to_set);
                } else {
                    $('#timepicker_endtime').timepicker('setTime', endtime_to_set);
                }

            } else {
                endtime_to_set = event.end.format('HH:MM');
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_endtime').val(endtime_to_set);
                } else {
                    $('#timepicker_endtime').timepicker('setTime', endtime_to_set);
                }

            }

        } else {
            if (MyCalendar.showAMPM) {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_endtime').val(now.format('hh:MM TT'));
                } else {
                    $('#timepicker_endtime').timepicker('setTime', now.format('hh:MM TT'));
                }

            } else {
                if (MyCalendar.editdialogTimepickerType == 'simple') {
                    $('#timepicker_endtime').val(now.format('HH:MM'));
                } else {
                    $('#timepicker_endtime').timepicker('setTime', now.format('HH:MM'));
                }

            }
        }


        if (event.allDay) {
            $('#allday_checkbox').prop('checked', true);
            disableTimeCombos();
        } else {
            $('#allday_checkbox').prop('checked', false);
            enableTimeCombos();
        }


        $("#dialog-message").dialog({
            modal: true,
            title: (event.rep_event !== undefined ? Lang.Popup.EditRecurringEvent : Lang.Popup.TitleEdit), // + (event.updateThisItem ? ' (this item)' : ' (whole pattern)') : Lang.Popup.TitleEdit),
            //height: 'auto',
            //width: 'auto',
            height: 'auto', //MyCalendar.showLocationField ? 460 : 430,
            width: 730,
            minHeight: 300,
            resizable: MyCalendar.dialogsResizable || false,
            create: function () {
                if (MyCalendar.useHtmlEditor) {
                    // ckeditor
                }

            },
            open: function () {
                if (MyCalendar.showFileUpload) {
                    $('#dialog-message').tabs({
                        selected: 0, // for newer jquery versions use 'active'
                        disabled: [],
                        create: function (e, ui) {
                            // $('#closeBtn').click(function() {
                            //$('#dialog-movie-info').dialog('close');
                            // });

                        }
                    });
                }
                //$(this).parent().children('.ui-dialog-titlebar').remove();
            },
            close: function (ev, ui) {
                if (MyCalendar.saveCurrentEditing) {
                    stopEdit(event.event_id);
                }
                if (bln_return_to_custom_listview !== undefined && bln_return_to_custom_listview) {
                    window.close();
                    //window.location = MyCalendar.FULLCAL_URL + '/?action=agenda';
                }
            },
            buttons: [
                {
                    html: Lang.Popup.copyText, // email to admin
                    //class: "ui-button-left",
                    id: 'copybtn',
                    style: 'float:left;margin-left:10px;',
                    //disabled: !MyCalendar.calCanMail,
                    click: function (a, b) {
                        var title = $('#edited_title').val();
                        var copy_files = $('#copy_files_also').val();

                        if (title != null && title != '') {
                            showCopyEventDlg(event.event_id, copy_files, $(this));

                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }

                    }
                }, {
                    html: Lang.Popup.exportToIcsText,
                    //class: "ui-button-left",
                    style: 'float:left;',
                    id: 'icsbtn',
                    //disabled: !MyCalendar.calCanMail,
                    click: function (a, b) {
                        var title = $('#edited_title').val();

                        if (title != null && title != '') {
                            exportEventToIcs(event.event_id, $(this));

                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }

                    }
                }, {
                    html: Lang.Popup.disconnectText,
                    //class: "ui-button-left",
                    id: 'disconnectbtn',
                    //disabled: !MyCalendar.calCanMail,
                    click: function (a, b) {
                        var bln_success = checkRequiredFields();

                        if (bln_success) {
                            var me = $(this);

                            $("#dialog-recurring-disconnect-prompt").dialog({
                                modal: true,
                                closable: false,
                                title: Lang.Prompt.Disconnect.title,
                                buttons: [{
                                        text: Lang.Label.Yes,
                                        click: function () {
                                            me.dialog("close");
                                            $(this).dialog("close");
                                            event.updateThisItem = true;
                                            event.disconnect = true;
                                            updateEvent(event, false, me);
                                        }}, {
                                        text: Lang.Label.No,
                                        click: function () {
                                            $(this).dialog("close");

                                        }
                                    }]

                            });

                            $('#disconnect_recurring_label_id').html(Lang.Prompt.Disconnect.text);


                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }

                    }
                }, {
                    html: Lang.Popup.emailText, // email to admin
                    //class: "ui-button-left",
                    id: 'emaileditbtn',
                    //disabled: !MyCalendar.calCanMail,
                    click: function (a, b) {
                        var title = $('#edited_title').val();
                        if (title != null && title != '') {
                            mailEvent($(this));

                        } else {
                            $('#error_message').html(Lang.Alert.EventTitleRequired);
                        }
                        if (MyCalendar.saveCurrentEditing) {
                            stopEdit(event.event_id);
                        }
                    }
                }, {
                    text: 'Restore pattern',
                    id: 'restorebtn',
                    disabled: (event.rep_event === undefined || event.rep_event.bln_broken == 0 || event.rep_event.bln_broken == '0'),
                    click: function () {
                        var bln_correct = updateEvent(event, true, $(this));
                        if (bln_correct) {
                            //var restoreButton=$('.ui-dialog-buttonpane button:first');
                            //restoreButton.addClass('ui-state-hidden');
                            $('#restorebtn').hide();
                            $(this).dialog("close");
                            $('#error_message').html('&nbsp;');

                        }

                    }
                }, {
                    html: Lang.Popup.updateButtonText,
                    id: 'updatebtn',
                    disabled: !event.editable && !event.allowEdit,
                    click: function () {

                        var bln_success = checkRequiredFields();

                        if (bln_success) {
                            var me = $(this);

                            if (event.rep_event !== undefined) {
                                var bln_correct;
                                $("#dialog-recurring-update-prompt").dialog({
                                    modal: true,
                                    closable: false,
                                    title: Lang.Popup.EditRecurringEvent, //Lang.Prompt.Update.updateOneOrAllTitle,
                                    buttons: [{
                                            text: Lang.Prompt.Update.thisItemBtn,
                                            click: function () {
                                                $(this).dialog("close");
                                                event.updateThisItem = true;
                                                bln_correct = updateEvent(event, false, me);
                                            }}, {
                                            text: Lang.Prompt.Update.allItemsBtn,
                                            click: function () {
                                                $(this).dialog("close");
                                                event.updateThisItem = false;
                                                bln_correct = updateEvent(event, false, me);
                                            }
                                        }]

                                });

                                $('#update_recurring_label_id').html(Lang.Prompt.Update.chooseOneOrAllText);
                            } else {
                                bln_correct = updateEvent(event, false, me);
                            }

                            //if(title != null && title != '') {

                            if (bln_correct) {
                                // $( this ).dialog( "close" );
                                $('#error_message').html('');

                                if (bln_return_to_custom_listview !== undefined && bln_return_to_custom_listview) {
                                    window.close();
                                    // window.location = MyCalendar.FULLCAL_URL;
                                }
                            }
                        } else {
                            // show 1st tab
                            $('#dialog-message').tabs({active: 0, selected: 0});

                            $('#error_message').html(Lang.Alert.FillInTheRequiredFields);
                        }

                    }
                }, {
                    html: Lang.Popup.deleteButtonText, // + (event.updateThisItem ? ' this item' : 'whole pattern'),
                    id: 'deletebtn',
                    disabled: !event.deletable,
                    click: function () {
                        var me = $(this);
                        if (event.rep_event !== undefined) {

                            $("#dialog-delete-prompt").dialog({
                                modal: true,
                                title: Lang.Prompt.Delete.chooseOneOrAllTitle,
                                buttons: [{
                                        text: Lang.Prompt.Delete.thisItemBtn,
                                        click: function () {
                                            $(this).dialog("close");
                                            deleteEvent(me, event, false);
                                            //me.dialog("close");
                                        }}, {
                                        text: Lang.Prompt.Delete.allItemsBtn,
                                        click: function () {
                                            $(this).dialog("close");
                                            deleteEvent(me, event, true);
                                            //me.dialog("close");
                                        }
                                    }]

                            });
                        } else {
                            if (MyCalendar.showDeleteConfirmDialog) {
                                $("#dialog-delete-prompt").dialog({
                                    modal: true,
                                    title: Lang.Prompt.Delete.ConfirmTitle,
                                    buttons: [{
                                            text: Lang.Prompt.Delete.RemoveBtn,
                                            click: function () {
                                                $(this).dialog("close");
                                                deleteEvent(me, event, false);

                                            }}, {
                                            text: Lang.Prompt.Delete.CancelBtn,
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                            } else {
                                deleteEvent(me, event, false);
                                $(this).dialog("close");

                            }

                        }

                    }
                }, {
                    html: Lang.Popup.closeButtonText,
                    click: function () {
                        $(this).dialog("close");

                    }
                }]
        });



        // FORM LABELS
        $('#wholeday_label_id').html(Lang.Popup.allDayLabel);

        if (event.rep_event !== undefined) {
            $('#delete_one_or_all_label_id').html(Lang.Prompt.Delete.chooseOneOrAllText);

            $('#disconnectbtn').css('font-weight', 'normal');
            $('#disconnectbtn').css('color', 'red');
            $('#disconnectbtn').show();

//            if($('#month_label_id:has(img)').length == 0) {
//                $('#month_label_id').prepend('<img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-82-refresh.png" /> ');
//            }
//            if($('#time_label_id:has(img)').length == 0) { 
//                $('#time_label_id').prepend('<img style="width:14px;" src="' + MyCalendar.FULLCAL_URL + '/images/glyphicons/glyphicons-82-refresh.png" /> ');
//            }
        } else {
            $('#delete_one_or_all_label_id').html(Lang.Prompt.Delete.ConfirmText);

            $('#disconnectbtn').hide();

            $('#month_label_id').html(Lang.Popup.StartdateLabel);
            $('#time_label_id').html(Lang.Popup.EnddateLabel);

        }


        $('#title_label_id').html(Lang.Popup.EventTitle);
        $('#color_label_id').html(Lang.Popup.EventColor);
        $('#location_label_id').html(Lang.Popup.EventLocation);
        $('#phone_label_id').html(Lang.Popup.EventPhone);
        $('#myurl_label_id').html(Lang.Popup.EventUrl);
        $('#description_label_id').html(Lang.Popup.EventDescription);
        $('#interval_label_id').html(Lang.Popup.EventInterval);
        $('.recurrence_label_id').html(Lang.Popup.EventRecurrence);
        $('#recurrence_monthly_dom_label').html(Lang.Popup.DayOfMonth);
        $('#recurrence_monthly_dow_label').html(Lang.Popup.DayOfWeek);
        $('#edit_dialog_tab_info').html(Lang.Popup.LabelTabMain);
        $('#edit_dialog_tab_files').html(Lang.Popup.LabelTabFiles);

        $('#login_to_upload').html(Lang.Alert.LogInToUpload);
        $('#copy_to_month_label_id').html(Lang.Popup.copyToText);
        $('.label_every').html(Lang.Popup.Every);
        $('.label_days').html(Lang.Calendar.LabelDays);
        $('.label_weeks').html(Lang.Popup.Weeks);


        if (event.rep_event === null || event.rep_event === undefined || event.rep_event === 0 || event.rep_event.bln_broken == 0 || event.rep_event.bln_broken == '0') {
            $('#restorebtn').hide();
        } else {
            $('#restorebtn').css('font-weight', 'normal');
            $('#restorebtn').css('color', 'green');

        }

        if (MyCalendar.showUrlField || event.show_url_field) {
            $('#go_myurl_btn').attr('href', '#');

            if (event.myurl !== undefined && event.myurl !== null && event.myurl !== '') {
                $('#go_myurl_btn').show();
                if (event.myurl.indexOf('http://') == -1) {
                    event.myurl = 'http://' + event.myurl;
                }
                $('#go_myurl_btn').attr('target', '_blank');
                $('#go_myurl_btn').attr('href', event.myurl);
            } else {
                $('#go_myurl_btn').hide();
            }
        }

        if (MyCalendar.copyEventPossible) {
            $('#copybtn').show();
        } else {
            $('#copybtn').hide();
        }


        if (MyCalendar.showPhoneField) {
            $('#go_phone_btn').attr('href', '#');

            if (event.phone !== undefined && event.phone !== null && event.phone !== '') {
                $('#go_phone_btn').show();
                var phone_href = 'tel:' + event.phone;
                $('#go_phone_btn').attr('target', '_blank');
                $('#go_phone_btn').attr('href', phone_href);
            } else {
                $('#go_phone_btn').hide();
            }
        }

        if (MyCalendar.useHtmlEditor) {
            //
        }

        //if(MyCalendar.calCanMail) {
        if (event.canMail) {
            $('#emaileditbtn').show();
        } else {
            $('#emaileditbtn').hide();
        }

        if (event.color === '' || event.color === undefined || event.color.substring(0, 1) !== '#') {
            event.color = MyCalendar.currentEventColor;
        }

        if (MyCalendar.calCanChangeColor) {
            //$('#checkbox_use_color_for_all_events').attr( "checked", false );

            if (MyCalendar.editdialogColorpickerType == 'spectrum') {
                $("#togglePaletteOnly").spectrum('set', event.color);
                $("#togglePaletteOnly").val(event.color);
            } else {
                $('#ColorSelectionTarget1').css('background-color', event.color);
                MyCalendar.currentEventColor = event.color;
            }
        }

        if (event.updateThisItem) {
            $('#calendar_id_change_field').hide();
            $('#recurring_div').hide();
        } else {
            $('#calendar_id_change_field').show();
            $('#recurring_div').show();
        }

        $('#calendar_label_id').html(Lang.Popup.LabelCalendar);
        $('#edit_dlg_calendar_selectbox').val(event.calendar_id);

        if (MyCalendar.showTeamMemberField || event.show_team_member_field) {
            $('#user_id_change_field').show();
            if (event.team_member_id !== null) {
                if (event.team_member_id.indexOf(',') == -1) {
                    // $('#edit_dlg_user_selectbox').val(event.team_member_id);
                }


                $('#edit_dlg_user_selectbox').val([]);
                $("#edit_dlg_user_selectbox").pqSelect("refreshData");

                $('#edit_dlg_user_selectbox').val(event.team_member_id.split(','));

                $("#edit_dlg_user_selectbox").pqSelect("refreshData");


                // $('#edit_dlg_user_selectbox').update(); 
            } else {
                $('#edit_dlg_user_selectbox').val(-1);
            }
            if ((MyCalendar.isAdmin || MyCalendar.isOwner || MyCalendar.admin_has_full_control)) {

                if (event.team_member_id.indexOf(',') >= 0) {
                    $('#team_member_assign').hide();
                    $('#team_member_unassign').hide();
                } else {
                    if (event.assigned_by > 0) {
                        $('#team_member_assign').hide();
                    } else {
                        $('#team_member_assign').show();
                    }
                }

            }


            $('#assign_checkbox').prop('checked', false);
        } else {
            $('#user_id_change_field').hide();
            $('#team_member_assign').hide();
        }

        if (MyCalendar.showFileUpload) {
            // get files, otherwise a just added file is not visible
            var data = {
                event_id: event.event_id
            };

            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/index.php?action=get_files',
                data: data,
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        var strFiles = '';
                        $('#select_file_field').val('');

                        $.each(result.files, function (k, row) {
                            strFiles += (row.loggedin_user_can_delete ? '<span class="delete_file_btn" onClick="deleteFile(' + row.event_id + ',' + row.event_file_id + ');return false;" data-event_id="' + row.event_id + '" data-event_file_id="' + row.event_file_id + '" title="Delete file" alt="Delete file" style="padding-right:3px;vertical-align:top;"><img src="' + MyCalendar.FULLCAL_URL + '/images/error.png" /></span>' : '<span style="padding-right:3px;vertical-align:top;"><img src="' + MyCalendar.FULLCAL_URL + '/images/transparent.png" /></span>') + '<a target="_blank" title="Open file" alt="Open file" href="' + MyCalendar.FULLCAL_URL + '/uploads/' + row.filename + '.' + row.file_extension + '">' + row.original_filename + '</a><br />';
                        });

                        $('#files_div').html(strFiles);

                        if (result.files.length >= MyCalendar.maxEventFileUpload) {
                            // hide the upload form
                            $('#file_upload_form').hide();
                            $('#max_ten_files_div').show();
                        } else {
                            $('#file_upload_form').show();
                            $('#max_ten_files_div').hide();
                        }
                    } else {

                    }
                }
            });
        }



        if (event.dropdown1_option_id !== null && event.dropdown1_option_id > 0 && (MyCalendar.showDropdown1Field || event.show_dropdown_1_field)) {
            //  $('#custom_dropdown_1_combo').show();
            $('#edit_dlg_dropdown1_selectbox').val(event.dropdown1_option_id);
        } else {
            //  $('#custom_dropdown_1_combo').hide();
            $('#edit_dlg_dropdown1_selectbox').val(-1);
        }
        if (event.dropdown2_option_id !== null && event.dropdown2_option_id > 0 && (MyCalendar.showDropdown2Field || event.show_dropdown_2_field)) {
            //   $('#custom_dropdown_2_combo').show();
            $('#edit_dlg_dropdown2_selectbox').val(event.dropdown2_option_id);
        } else {
            //  $('#custom_dropdown_2_combo').hide();
            $('#edit_dlg_dropdown2_selectbox').val(-1);
        }
        if (event.dropdown3_option_id !== null && event.dropdown3_option_id > 0 && (MyCalendar.showDropdown3Field || event.show_dropdown_3_field)) {
            $('#edit_dlg_dropdown3_selectbox').val(event.dropdown3_option_id);
        } else {
            $('#edit_dlg_dropdown3_selectbox').val(-1);
        }
        if (event.dropdown4_option_id !== null && event.dropdown4_option_id > 0 && (MyCalendar.showDropdown4Field || event.show_dropdown_4_field)) {
            $('#edit_dlg_dropdown4_selectbox').val(event.dropdown4_option_id);
        } else {
            $('#edit_dlg_dropdown4_selectbox').val(-1);
        }
        if (event.dropdown5_option_id !== null && event.dropdown5_option_id > 0 && (MyCalendar.showDropdown5Field || event.show_dropdown_5_field)) {
            $('#edit_dlg_dropdown5_selectbox').val(event.dropdown5_option_id);
        } else {
            $('#edit_dlg_dropdown5_selectbox').val(-1);
        }

        show_hide_dialog_fields(event);

        //  $( "#edit_dlg_user_selectbox" ).pqSelect( "open" );  
        $("#edit_dlg_dropdown1_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown2_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown3_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown4_selectbox").selectmenu({
            width: 188
        });
        $("#edit_dlg_dropdown5_selectbox").selectmenu({
            width: 188
        });
        $('#edit_dlg_calendar_selectbox').selectmenu({
            width: 188
        });

//        if ($('.pq-select-text:has(.ui-icon-triangle-1-s)').length == 0) {
//            $('.pq-select-text').prepend('<span class="ui-selectmenu-icon ui-icon ui-icon-triangle-1-s" style="padding-right:5px;"></span>');
//            $('span.ui-icon-triangle-1-s').css('padding-right', '-5px !important');
//        }


        $("#edit_dlg_dropdown1_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown2_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown3_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown4_selectbox").selectmenu('refresh', true);
        $("#edit_dlg_dropdown5_selectbox").selectmenu('refresh', true);

        $("#edit_dlg_calendar_selectbox").selectmenu('refresh', true);
    };

    var onResizeEvent = function (event) {
        var startdate = Date.parse(event.start) / 1000;

        var str_date_start = event.start.format('yyyy-mm-dd HH:MM:00');

        var currentView = $('#calendar').fullCalendar('getView').name;

        if (event.end === null && (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay')) {
            var enddate = startdate + (2 * 3600);	// 2 hours
            var str_date_end = new Date(enddate * 1000).format('yyyy-mm-dd HH:MM:00');

        } else if (event.end === null) {
            var enddate = startdate;
            var str_date_end = event.start.format('yyyy-mm-dd HH:MM:00');

        } else {
            var enddate = Date.parse(event.end) / 1000;
            var str_date_end = event.end.format('yyyy-mm-dd HH:MM:00');
        }

        var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
        startdate = startdate - offsetClientToGMT;
        enddate = enddate - offsetClientToGMT;

        var data = {
            event_id: event.event_id,
            date_start: startdate,
            date_end: enddate,
            str_date_start: str_date_start,
            str_date_end: str_date_end,
            cal_id: event.calendar_id
        };

        $.ajax({
            type: "POST",
            url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=resize',
            data: data,
            dataType: 'json',
            success: function (result) {
                if (result.success) {
                    if (result.event !== undefined) {
                        event = applyToObject(event, result.event);
                        $('#calendar').fullCalendar('updateEvent', event);
                    } else {
                        $('#calendar').fullCalendar('refetchEvents');
                    }

                } else {
                    //$('#calendar').fullCalendar('refetchEvents');
                    if (result.notloggedin) {
                        $('#calendar').fullCalendar('refetchEvents');
                        alert(Lang.Alert.NotLoggedIn);
                        window.location = MyCalendar.FULLCAL_URL;
                    } else {
                        alert(Lang.Alert.ErrorSaving);
                    }
                }
            }
        });
    };

    MyCalendar.showTokenForm = function (cal_id) {
        $("#dialog-exchange-token").dialog({
            title: 'Fill in the token for this calendar (Exchange)',
            modal: true,
            width: 400,
            buttons: {
                Ok: function () {
                    //$('#exchange_token_form').submit();

                    $.ajax({
                        type: "POST",
                        url: MyCalendar.FULLCAL_URL + '/?action=save_token',
                        data: {
                            cal_id: MyCalendar.currentCalendar,
                            exchange_token: $('#exchange_token').val()
                        },
                        dataType: 'json',
                        success: function (result) {
                            if (result.success) {
                                if (cal_id !== undefined && cal_id > 0) {
                                    window.location = MyCalendar.FULLCAL_URL + '?cid=' + cal_id;
                                } else {
                                    window.location = MyCalendar.FULLCAL_URL;
                                }
                            }
                        }
                    });
                    $(this).dialog("close");
                }
            }
        });
    };

    /* initialize the external events
     -----------------------------------------------------------------*/

    $('#external-events div.external-event').each(function () {

        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
        // it doesn't need to have a start or end
        var eventObject = {
            title: $.trim($(this).text()), // use the element's text as the event title
            color: $(this).attr('color'),
            textcolor: $(this).attr('textcolor'),
            cal_id: $(this).attr('cal_id'),
            user_id: $(this).attr('user_id'),
            starttime: $(this).attr('starttime'),
            endtime: $(this).attr('endtime'),
            nightshift: $(this).attr('nightshift')
        };

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true, // will cause the event to go back to its
            revertDuration: 0  //  original position after the drag
        });

    });

    /* initialize the calendar
     -----------------------------------------------------------------*/

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            //right: 'list,month,agendaWeek,agendaDay,agendaList'
            right: (MyCalendar.showMonthViewButton ? 'month' : '') + (MyCalendar.showWeekViewButton || MyCalendar.showDayViewButton || MyCalendar.showAgendaViewButton ? ',' : '') +
                    (MyCalendar.showWeekViewButton ? MyCalendar.weekViewType : '') + (MyCalendar.showDayViewButton || MyCalendar.showAgendaViewButton ? ',' : '') +
                    (MyCalendar.showDayViewButton ? MyCalendar.dayViewType : '') + (MyCalendar.showAgendaViewButton ? ',' : '') +
                    (MyCalendar.showAgendaViewButton ? 'agendaList' : '')
        },
        titleFormat: {
            month: 'MMMM yyyy', // September 2009
            week: MyCalendar.datePickerDateFormat == 'mm/dd/yy' ? "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}" : "d { '&#8212;'[ MMM] d} MMM yyyy", // Sep 7 - 13 2009
            agendaList: MyCalendar.datePickerDateFormat == 'mm/dd/yy' ? "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}" : "d { '&#8212;'[ MMM] d} MMM yyyy", // Sep 7 - 13 2009
            day: MyCalendar.datePickerDateFormat == 'mm/dd/yy' ? 'dddd, MMM d, yyyy' : 'dddd, d MMM yyyy'                 // Tuesday, Sep 8, 2009
        },
        columnFormat: {
            month: 'ddd', // Mon
            week: MyCalendar.datePickerDateFormat == 'mm/dd/yy' ? 'ddd M/d' : 'ddd d-M', // Mon 9/7
            day: MyCalendar.datePickerDateFormat == 'mm/dd/yy' ? 'dddd M/d' : 'dddd d-M'  // Monday 9/7
        },
        isRTL: false,
        year: MyCalendar.gotoYear ? MyCalendar.gotoYear : new Date().getFullYear(),
        month: MyCalendar.gotoMonth ? MyCalendar.gotoMonth : new Date().getMonth(),
        date: MyCalendar.gotoDay ? MyCalendar.gotoDay : new Date().getDate(),
        editable: true, // do not change
        //ignoreTimezone: true,
        allDayText: Lang.Popup.allDayLabel,
        selectable: true, // do not change
        weekends: MyCalendar.FCweekends,
        firstDay: MyCalendar.FCfirstDay || 1,
        firstHour: MyCalendar.FCfirstHour || 6,
        minTime: MyCalendar.FCminTime || 0,
        maxTime: MyCalendar.FCmaxTime || 24,
        slotMinutes: MyCalendar.FCslotMinutes || 30,
        snapMinutes: MyCalendar.FCsnapMinutes || 30,
        slotEventOverlap: MyCalendar.FCslotEventOverlap !== undefined ? MyCalendar.FCslotEventOverlap : false,
        timeFormat: MyCalendar.showAMPM ? (MyCalendar.hideMinutesInMonthWeekDayView ? 'h TT{ - h TT} ' : 'h:mm TT{ - h:mm TT} ') : (MyCalendar.hideMinutesInMonthWeekDayView ? 'H { - H} ' : 'H:mm { - H:mm} '),
        axisFormat: MyCalendar.showAMPM ? 'h:mm TT' : 'H:mm',
        monthNames: Lang.Fullcalendar.monthNames,
        monthNamesShort: Lang.Fullcalendar.monthNamesShort,
        dayNames: Lang.Fullcalendar.dayNames,
        dayNamesShort: Lang.Fullcalendar.dayNamesShort,
        buttonText: {
            //prev: '&nbsp;&#9668;&nbsp;',
            //next: '&nbsp;&#9658;&nbsp;',
            prev: '<',
            next: '>',
            prevYear: '&nbsp;&lt;&lt;&nbsp;',
            nextYear: '&nbsp;&gt;&gt;&nbsp;',
            today: Lang.Fullcalendar.buttonText.today,
            month: Lang.Fullcalendar.buttonText.month,
            week: Lang.Fullcalendar.buttonText.week,
            day: Lang.Fullcalendar.buttonText.day,
            agendaList: Lang.Fullcalendar.buttonText.agendaList
        },
        showTitleFirst: MyCalendar.showTitleFirst || false,
        showDescription: MyCalendar.showDescriptionInWDLview || false,
        showLocation: MyCalendar.showLocationInWDLview || false,
        showPhone: MyCalendar.showPhoneInWDLview || false,
        showUrl: MyCalendar.showUrlInWDLview || false,
        showCalendarNameInListView: MyCalendar.showCalendarNameInListView || false,
        daydateInMonthviewFormat: MyCalendar.daydateInMonthviewFormat || '',
        // lazyFetching: false,
        timeline: true,
        droppable: true, // this allows things to be dropped onto the calendar !!!
        drop: function (date, allDay) { // this function is called when something is dropped

            // retrieve the dropped element's stored Event Object
            var originalEventObject = $(this).data('eventObject');


            // we need to copy it, so that multiple events don't have a reference to the same object
            var copiedEventObject = $.extend({}, originalEventObject);

            if ($(this).attr('filtered_usergroup_dditem') == 1) {
                // the DD-item was generated with the dropdownlist, update the object with some new values
                copiedEventObject.title = $.trim($(this).text());
                copiedEventObject.user_id = $(this).attr('user_id');
                //copiedEventObject.textcolor = $(this).attr('textcolor');
            }

            // assign it the date that was reported
            copiedEventObject.start = Date.parse(date) / 1000;
            copiedEventObject.allDay = allDay;

            if (copiedEventObject.title === undefined) {
                return false;
            }
            if (!MyCalendar.calCanDragDDItems) {
                return false;
            }
            if (!checkAlterable(date)) {
                showMessage(Lang.Alert.NotAllowedToAddOnThisDate, 'error');
                return false;
            }

            //todo $('#saving').show();

            var offsetClientToGMT = new Date().getTimezoneOffset() * (MyCalendar.defaultEventDuration == '30' || MyCalendar.defaultEventDuration == '60' || MyCalendar.defaultEventDuration == '120' ? MyCalendar.defaultEventDuration : 60);
            var ts_enddate = copiedEventObject.start - offsetClientToGMT;

            var ts_startdate = Date.parse(date) / 1000;

            var end_date = ts_startdate + (60 * (MyCalendar.defaultEventDuration == '30' || MyCalendar.defaultEventDuration == '60' || MyCalendar.defaultEventDuration == '120' ? MyCalendar.defaultEventDuration : 60));

            var currentView = $('#calendar').fullCalendar('getView').name;

            if (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay') {
                var str_date_start = date.format('yyyy-mm-dd HH:MM:00');
                var str_date_end = new Date(end_date * 1000).format('yyyy-mm-dd HH:MM:00');

            } else {
                if (currentView == 'month') {
                    if (copiedEventObject.starttime !== '') {
                        var str_date_start = date.format('yyyy-mm-dd ' + copiedEventObject.starttime);
                        allDay = false;
                    } else {
                        var str_date_start = date.format('yyyy-mm-dd 00:00:01');
                        allDay = true;
                    }
                    if (copiedEventObject.endtime !== '') {
                        // if (copiedEventObject.nightshift) {
                        //     var str_date_end = new Date((end_date + 86400) * 1000).format('yyyy-mm-dd ' + copiedEventObject.endtime);
                        // } else {
                        var str_date_end = new Date(end_date * 1000).format('yyyy-mm-dd ' + copiedEventObject.endtime);
                        // }

                        allDay = false;
                    } else {
                        var str_date_end = new Date(end_date * 1000).format('yyyy-mm-dd 23:59:59');
                        allDay = true;
                    }
                } else {
                    var str_date_start = date.format('yyyy-mm-dd 00:00:01');
                    var str_date_end = new Date(end_date * 1000).format('yyyy-mm-dd 23:59:59');
                    allDay = true;
                }
            }


            var data = {
                cal_id: copiedEventObject.cal_id,
                user_id: copiedEventObject.user_id, //usergroup dditem
                date_start: ts_startdate,
                date_end: ts_enddate,
                str_date_start: str_date_start,
                str_date_end: str_date_end,
                color: copiedEventObject.color, //MyCalendar.currentCalendarColor
                textcolor: copiedEventObject.textcolor, //MyCalendar.currentCalendarColor
                title: copiedEventObject.title,
                allDay: (allDay ? true : false)

            };

            $.ajax({
                type: "POST",
                url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=add',
                data: data,
                dataType: 'json',
                success: function (result) {
                    if (result.success) {
                        result.event._id = result.event.id;
                        $('#calendar').fullCalendar('renderEvent', result.event);
                        //$('#calendar').fullCalendar('refetchEvents');

                        updateAmountEmployees(result.event.date_start);
                    } else {
                        if (result.notloggedin) {
                            $('#calendar').fullCalendar('refetchEvents');
                            alert(Lang.Alert.NotLoggedIn);
                            window.location = MyCalendar.FULLCAL_URL;
                        } else {
                            if (result.error !== undefined) {
                                if (result.event !== undefined) {
                                    result.event._id = result.event.id;
                                    $('#calendar').fullCalendar('renderEvent', result.event);
                                }
                                alert(result.error);
                            } else {
                                alert(Lang.Alert.ErrorSaving);
                            }

                        }
                    }
                }
            });

            // is the "remove after drop" checkbox checked?
            if ($('#drop-remove').is(':checked')) {
                // if so, remove the element from the "Draggable Events" list
                $(this).remove();
            }

        },
        //events: {
        //	url: MyCalendar.FULLCAL_URL + '/command/cal_events.php?action=start',
        //	success: function(a) {
        //		if(a.notloggedin) {
        //			alert(Lang.Alert.NotLoggedIn);
        //			window.location = MyCalendar.FULLCAL_URL ;
        //		}
        //    }
        //},

        eventSources: [
            //'https://www.google.com/calendar/feeds/paul.wolbers%40gmail.com/private-4d64ac1eb16ed8d90f43ce99b33dce99/basic',
            //'https://www.google.com/calendar/ical/paul.wolbers%40gmail.com/private-4d64ac1eb16ed8d90f43ce99b33dce99/basic.ics', // dan moet er eerst net als gcal.js een ical.js gemaakt worden
            {
                color: '',
                success: function (a) {
                    if (a.success === false) {
                        //alert(a.error);
                        if (a.token_not_found || a.token_not_correct) {
                            MyCalendar.showTokenForm();
                        }
                    }

                },
                url: MyCalendar.FULLCAL_URL + "/command/cal_events.php?action=start" + (MyCalendar.currentDropdownOptions !== '' ? "&option_id=" + MyCalendar.currentDropdownOptions : "") + "&cal_id=" + MyCalendar.currentCalendars + '&uid=',
                cache: false
            }
        ],
        eventDrop: function (event, delta) {
            if (!event.allowEdit) {
                $('#calendar').fullCalendar('refetchEvents');
                if (MyCalendar.showNotAllowedMessages) {
                    showMessage(Lang.Alert.NotAllowedToEdit, 'error');
                }
            } else {
                onEventDropEvent(event);
            }
        },
        selectHelper: true,
        select: function (start, end, allDay) {
            onSelectEvent(start, end, allDay);
        },
        loading: function (bool) {
            if (bool) {
                $('#loading').show();
            } else {
                $('#loading').hide();
            }
        },
        eventMouseover: function (event, jsEvent, view) {
            if (!$.support.touch) {
                onMouseoverEvent($(this), event);
            }

        },
        eventMouseout: function (calEvent, domEvent) {
            $("#events-layer").remove();
            $("#events-layer2").remove();
        },
        eventClick: function (event, element) {
            onClickEvent(event);


        },
        eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
            if (!event.allowEdit) {
                //if(MyCalendar.calCanEdit === undefined || MyCalendar.calCanEdit === false) {
                if (MyCalendar.showNotAllowedMessages) {
                    showMessage(Lang.Alert.NotAllowedToEdit, 'error');
                }

                revertFunc();
            } else {
                onResizeEvent(event);
            }

        },
        allDayDefault: false,
        defaultView: MyCalendar.defaultView,
        weekNumbers: MyCalendar.showWeeknumbers,
        eventRender: function (event, element) {



//$(this).parent().parent().click();
            //  if(event.allowEdit) {

            //    } 
            if (MyCalendar.touchfriendly_drag_events) {
                if ($.support.touch) {	// && !$(element).hasClass('fc-event-draggable')
                    $(element).draggable();
                }
            }

            var item_title = element.find('span.fc-event-title').text();


            var currentView = $('#calendar').fullCalendar('getView').name;

            if (currentView == 'month') {
                var truncate_length = MyCalendar.truncateLength && MyCalendar.truncateLength > 0 ? MyCalendar.truncateLength : 50;

                var truncated_text = MyCalendar.truncateTitle && item_title.length > truncate_length ? item_title.substr(0, truncate_length) + '...' : item_title;

            } else {
                var truncated_text = item_title;
            }

            if (currentView == 'month' || MyCalendar.showCustomDropdownValuesInWDLview) {
                // custom dropdown 1
                if (event.add_custom_dropdown1_to_title && event.dropdown1 !== undefined && event.dropdown1 !== null && event.dropdown1 !== '') {
                    truncated_text += ' <span style="border-radius:3px;padding:1px;white-space:nowrap;background-color:' + event.dropdown1_color + ';">' + event.dropdown1 + '</span>';
                }

                // custom dropdown 2
                if (event.add_custom_dropdown2_to_title && event.dropdown2 !== undefined && event.dropdown2 !== null && event.dropdown2 !== '') {
                    truncated_text += ' <span style="border-radius:3px;padding:1px;white-space: nowrap;background-color:' + event.dropdown2_color + ';">' + event.dropdown2 + '</span>';
                }

                if (event.add_custom_dropdown3_to_title && event.dropdown3 !== undefined && event.dropdown3 !== null && event.dropdown3 !== '') {
                    truncated_text += ' <span style="border-radius:3px;padding:1px;white-space: nowrap;background-color:' + event.dropdown3_color + ';">' + event.dropdown3 + '</span>';
                }
                if (event.add_custom_dropdown4_to_title && event.dropdown4 !== undefined && event.dropdown4 !== null && event.dropdown4 !== '') {
                    truncated_text += ' <span style="border-radius:3px;padding:1px;white-space: nowrap;background-color:' + event.dropdown4_color + ';">' + event.dropdown4 + '</span>';
                }
                if (event.add_custom_dropdown5_to_title && event.dropdown5 !== undefined && event.dropdown5 !== null && event.dropdown5 !== '') {
                    truncated_text += ' <span style="border-radius:3px;padding:1px;white-space: nowrap;background-color:' + event.dropdown5_color + ';">' + event.dropdown5 + '</span>';
                }

            }

            // team member
            if (event.team_member_id !== undefined && event.team_member_id !== null && event.team_member !== '') {
                truncated_text += ' ' + event.team_member;
            }


            if (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay') {


                var more_info = '';

                if (event.allDay) {
                    if (MyCalendar.showDescriptionInWDLview && event.description !== '') {
                        more_info += event.description;
                    }
                    if (MyCalendar.showLocationInWDLview && event.location !== '') {
                        more_info += ' ' + event.location;
                    }
                    if (MyCalendar.showPhoneInWDLview && event.phone !== '') {
                        more_info += ' ' + event.phone;
                    }
                    if (MyCalendar.showUrlInWDLview && event.myurl !== '') {
                        more_info += ' <a class="myurl" href="' + event.myurl + '" target="_blank">' + event.myurl + '</a>';
                    }
                    if (more_info !== '') {
                        element.find('span.fc-event-description').html(more_info);
                    }
                } else {
                    if (MyCalendar.showDescriptionInWDLview && event.description !== '') {
                        more_info += event.description;
                    }
                    if (MyCalendar.showLocationInWDLview && event.location !== '') {
                        more_info += '<br />' + event.location;
                    }
                    if (MyCalendar.showPhoneInWDLview && event.phone !== '') {
                        more_info += '<br />' + event.phone;
                    }
                    if (MyCalendar.showUrlInWDLview && event.myurl !== '') {
                        more_info += '<br /><a class="myurl" href="' + event.myurl + '" target="_blank">' + event.myurl + '</a>';
                    }
                    if (more_info !== '') {
                        element.find('div.fc-event-description').html(more_info);
                    }
                }

            }

            var truncated_html = '';

            if (event.assigned_to_me) {
                element.find('span.fc-event-title').text(truncated_text + ' *');
            } else {
                if (event.repeating_event_id > 0 && MyCalendar.showRecurringEventIcon) {
                    if (MyCalendar.showTitleFirst) {
                        truncated_html = '<span style="float:left;padding-left:2px;" class="icon-refresh ' + (MyCalendar.RefreshIconWhite ? ' icon-white' : '') + '"></span>' + truncated_text;
                    } else {
                        truncated_html = truncated_text + '<span style="float:right;padding-right:2px;" class="icon-refresh ' + (MyCalendar.RefreshIconWhite ? ' icon-white' : '') + '"></span>';
                    }


                } else if (event.assigned_by > 0 && MyCalendar.showAssignedByIcon) {
                    if (MyCalendar.showTitleFirst) {
                        truncated_html = truncated_text + '<span style="float:left;padding-left:2px;" class="icon-flag ' + (MyCalendar.AssignedIconWhite ? ' icon-white' : '') + '"></span>';
                    } else {
                        truncated_html = truncated_text + '<span style="float:right;padding-right:2px;" class="icon-flag ' + (MyCalendar.AssignedIconWhite ? ' icon-white' : '') + '"></span>';
                    }
                    //element.find('span.fc-event-title').html(truncated_html);

                } else {
                    // element.find('span.fc-event-title').text(truncated_text);
                    truncated_html = truncated_text;
                }


                if (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay') {
                    element.find('div.fc-event-title').html(truncated_html);
                } else {
                    element.find('span.fc-event-title').html(truncated_html);
                }

            }


            var arr_time_start = event.time_start.split(':');
            var arr_time_end = event.time_end.split(':');

            var starttime = arr_time_start[0].replace(/^[0]+/g, "");
            var endtime = arr_time_end[0].replace(/^[0]+/g, "");

            // if(!event.allDay && parseInt(starttime) > parseInt(endtime)) {
            //  element.css('position','relative');
            //  element.css('width','60px !important');
            //  element.css('left',(parseInt(element.css('left')) + 80) + 'px');

            //}

            //if(event.nightshift) {
            if (!event.allDay && parseInt(starttime) > parseInt(endtime)) {


                if (truncated_html !== '') {
                    truncated_text = truncated_html;
                }
                if (MyCalendar.showTitleFirst) {
                    truncated_html = truncated_text + '<span style="float:left;padding-left:2px;"><img style="height:12px;padding-top:2px;"  src="' + MyCalendar.FULLCAL_URL + '/images/moon.png" /></span>';
                } else {
                    truncated_html = truncated_text + '<span style="float:right;padding-right:2px;"><img style="height:12px;padding-top:2px;"  src="' + MyCalendar.FULLCAL_URL + '/images/moon.png" /></span>';
                    // <img src="'+MyCalendar.FULLCAL_URL + '/images/boss.png'+ '" alt="'+Lang.Popup.Assigned+'" title="'+Lang.Popup.Assigned+'" style="float: right;width:15px;padding-right:2px;vertical-align:middle;"/>' + '✔ ✗ '
                }
                if (currentView == 'agendaWeek' || currentView == 'agendaDay' || currentView == 'basicWeek' || currentView == 'basicDay') {
                    element.find('div.fc-event-title').html(truncated_html);
                } else {
                    element.find('span.fc-event-title').html(truncated_html);
                }
            }
//glyphicons-51-link
//glyphicons-54-alarm                 

            // allow html in title
            // element.find('span.fc-event-title').html(element.find('span.fc-event-title').text());

            if (event.textColor == 'red' && event.borderColor == 'red') {
                if (MyCalendar.actionOnClickEventInCustomListview == 3 || MyCalendar.actionOnClickEventInCustomListview == 4) {
                    onClickEvent(event, true);
                }

            }

        },
        dayRender: function (date, cell) {
            if (MyCalendar.maskUnalterableDays) {
                if (!checkAlterable(date)) {
                    $(cell).addClass('disabled');
                }
            }
            if (MyCalendar.touchfriendly_select_daycells) {
                cell.addTouch();
            }
        },
        viewRender: function (view, b) {
            if (view.name == 'agendaWeek' && MyCalendar.showAvailableEmployeesRow && MyCalendar.loggedInUser > 0 && MyCalendar.loggedInUser != 1000000) {
                // updateAmountEmployees(view.name, view.visStart.format('yyyy-mm-dd'));
                $.ajax({
                    type: "POST",
                    url: MyCalendar.FULLCAL_URL + '/index.php?action=get_amount_available_employees',
                    data: {user_id: MyCalendar.loggedInUser, visStart: view.visStart.format('yyyy-mm-dd'), visEnd: view.visEnd.format('yyyy-mm-dd')},
                    dataType: 'json',
                    success: function (result) {
                        if (result.success) {
                            //if(result.amount_employees[0] > -1) {
                            $('#header_row2_col_0').html(result.amount_employees[0] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[0] + ' monteur' + (result.amount_employees[0] > 1 ? 's' : '') + ' inzetbaar</span>');
                            $('#header_row2_col_1').html(result.amount_employees[1] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[1] + ' monteur' + (result.amount_employees[1] > 1 ? 's' : '') + ' inzetbaar</span>');
                            $('#header_row2_col_2').html(result.amount_employees[2] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[2] + ' monteur' + (result.amount_employees[2] > 1 ? 's' : '') + ' inzetbaar</span>');
                            $('#header_row2_col_3').html(result.amount_employees[3] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[3] + ' monteur' + (result.amount_employees[3] > 1 ? 's' : '') + ' inzetbaar</span>');
                            $('#header_row2_col_4').html(result.amount_employees[4] <= 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[4] + ' monteur' + (result.amount_employees[4] > 1 ? 's' : '') + ' inzetbaar</span>');
                            //$('#header_row2_col_5').html(result.amount_employees[5] == 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[5] + ' monteurs inzetbaar</span>');
                            //$('#header_row2_col_6').html(result.amount_employees[6] == 0 ? '<span style="color:red;">Alle monteurs ingepland</span>' : '<span style="color:#0EB70E;">' + result.amount_employees[6] + ' monteurs inzetbaar</span>');
                            // }
                        }
                    }
                });
            }
            if ($('.pq-select-text:has(.ui-icon-triangle-1-s)').length == 0) {
                $('.pq-select-text').prepend('<span class="ui-selectmenu-icon ui-icon ui-icon-triangle-1-s" style="padding-right:1px;margin-top:3px;"></span>');
               // $('span.ui-icon-triangle-1-s').css('padding-right', '-5px !important');
               // $('span.ui-icon-triangle-1-s').css('padding-top', '3px !important');
            }
        }
    });


    if (MyCalendar.showCustomListViewButton) {
        $('.fc-header-right').append('<a id="go_to_custom_listview_btn" class="fc-button fc-button-period fc-state-default fc-corner-right fc-corner-left" unselectable="on" style="-moz-user-select: none;margin-left:5px;text-decoration:none;">' + Lang.Calendar.ButtonCustomList + '</span>');
    }

    if (MyCalendar.CurrentRefresh !== undefined) {
        clearInterval(MyCalendar.CurrentRefresh);
    }

    $(".close_notification").live("click", function (a, b, c) {
        // can't use click handler because the spans are created dynamically
        // on newer version of jQuery use .on()
        $('#cal_message_changed_event_' + $(this).data('number_x')).remove();
    });

    if (MyCalendar.loggedInUser > 0 && MyCalendar.loggedInUser !== 1000000) {
        if (MyCalendar.checkForNotificationsEvery === undefined) {
            MyCalendar.checkForNotificationsEvery = 60000;
        }
        if ((MyCalendar.adminsGetNotificationPopups && MyCalendar.isAdmin)
                || (MyCalendar.usersGetNotificationPopups && MyCalendar.isUser)) {

            MyCalendar.CurrentRefresh = setInterval(function () {

                $.ajax({
                    type: "POST",
                    url: MyCalendar.FULLCAL_URL + '/index.php?action=get_changed_events',
                    data: {user_id: MyCalendar.loggedInUser},
                    dataType: 'json',
                    success: function (result) {
                        if (result.success) {

                            showMessageChangedEvent('(<i>' + result.rows.info + '</i>) ' + (result.rows.fullname !== null ? result.rows.fullname : 'Unknown user') + ': ' + (result.rows.title.length > 50 ? result.rows.title.substr(0, 50) + '...' : result.rows.title), 'notice2');
                            //showMessageChangedEvent(result.title, 'notice');

                        } else {

                        }
                    }
                });

            }, MyCalendar.checkForNotificationsEvery);  // not less than 5000 ! - 10000 is every 10 sec.
        }

    }


});