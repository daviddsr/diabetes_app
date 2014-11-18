

$(document).ready(function() {

    // page is now ready, initialize the calendar...
    var a= new Date
    var b = a.getDate()
    var c = a.getMonth()
    var d = a.getFullYear()

    $('#calendar').fullCalendar({
    	scrollTime: '07:00:00',
    	minTime: '07:00:00',
    	maxTime: '22:00:00',
    	defaultView: 'agendaWeek',
    	header:{left:"prev,next,today",
    			center:"title",
    			right:"month, agendaWeek, agendaDay"},
    	events:[{title:"All Day Event",
    			 start: new Date(d,c,1)}]

        // put your options and callbacks here
    })

});
