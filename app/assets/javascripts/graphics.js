


$(function () {
    $.get('/graphicscontrols', function(data) {
        console.log(data)
    $('#container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'My diabethes evolution'
        },
        subtitle: {
            text: 'Compare your glucose levels'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                minute: '%H:%M',
                hour: '%H:%M',
            },
            title: {
                text: 'Date'
            }
        },
        yAxis: {
            title: {
                text: 'Glucose level (mg/dl)'
            },
            min: 0
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        },

        series: data
    });
});

});

