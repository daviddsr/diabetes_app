$(document).ready(function() {
    $.get('/controls/calendar', function (data) {
            drawControl(data);
        });


    // page is now ready, initialize the calendar...

    function allControls(controls) {
        var arrayControls=[];
        for (i in controls) {
            var level= controls[i].level
            var day= controls[i].day
            var period=controls[i].period
            console.log(controls[i].period)
            arrayControls.push({title:level, start:day, description:"period", textColor: 'black'})
        }
            return arrayControls;
    }



    function drawControl(controls) {
            console.log(controls[0])

            $('#calendar').fullCalendar({
                editable: true,
                aspectRatio: 1,
                contentHeight: 500,
                scrollTime: '24:00:00',
                minTime: '01:00:00',
                maxTime: '24:00:00',
                defaultView: 'agendaWeek',
                header:{left:"prev,next,today",
                center:"title",
                right:"month, agendaWeek, agendaDay"},



                events: allControls(controls),

                eventRender: function(event, element) {

                    var bloodLevel=event.title

                    if(bloodLevel >= 180) {
                        element.css('background-color', 'red');
                    }
                    else if(bloodLevel < 70) {
                        element.css('background-color', 'yellow');
                    }
                },
                eventClick: function(event, element) {


                $('#calendar').fullCalendar('updateEvent', event);

    }
                //
        // put your options and callbacks here
    })

    }

});




$(function () {
                $('#datetimepicker1').datetimepicker();
            });
