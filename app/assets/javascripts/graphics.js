


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
            min: 0,
        
        plotBands: [{ // Light air
                from: 80,
                to: 120,
                color: 'rgba(68, 170, 213, 0.1)',
                label: {
                    text: 'Controls objective',
                    style: {
                        color: '#606060'
                    }
                }
            }]
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        },

        series: data
    });
});

});

