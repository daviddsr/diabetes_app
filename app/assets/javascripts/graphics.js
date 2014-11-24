// var drawCanvasForChart = function(graphicData, options) {
//     var context = document.getElementById("evolution-chart").getContext("2d");
//     var evolutionChart = new Chart(context).Line(graphicData, options);
// };

// var initChart = function(data, options) {
//     var graphicData = {
//         labels: [],
//         datasets: data
//     };


//     graphicData.labels = data.labels;
//     graphicData.datasets[0].data = data.data;
//     drawCanvasForChart(graphicData, options);
// };


// $(document).ready(function() {

//     var options = {


//         ///Boolean - Whether grid lines are shown across the chart
//         scaleShowGridLines : true,

//         //String - Colour of the grid lines
//         scaleGridLineColor : "rgba(0,0,0,.05)",

//         //Number - Width of the grid lines
//         scaleGridLineWidth : 1,

//         scaleBeginAtZero: true,

//         //Boolean - Whether the line is curved between points
//         bezierCurve : true,

//         //Number - Tension of the bezier curve between points
//         bezierCurveTension : 0.4,

//         //Boolean - Whether to show a dot for each point
//         pointDot : true,

//         //Number - Radius of each point dot in pixels
//         pointDotRadius : 4,

//         //Number - Pixel width of point dot stroke
//         pointDotStrokeWidth : 1,

//         //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
//         pointHitDetectionRadius : 20,

//         //Boolean - Whether to show a stroke for datasets
//         datasetStroke : true,

//         //Number - Pixel width of dataset stroke
//         datasetStrokeWidth : 4,

//         //Boolean - Whether to fill the dataset with a colour
//         datasetFill : true,

//         //String - A legend template
//         legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"

//     };


// var drawChart = function() {

//     $.get('/graphicscontrols', function(data) {
//     var graphicData = {
//         labels: [],
//         datasets: data
//     };

//     for (var i=0; i<data.length; i++){
//         graphicData.labels.push(data[i].labels)
//         console.log(data[i].labels)
//     }
//     //graphicData.labels = data.labels;
//     graphicData.datasets[0].data = data.data;
//     console.log(graphicData.datasets)
//     drawCanvasForChart(graphicData, options);
// });
// };
//  drawChart();

// });













// var drawCanvasForChart = function(graphicData, options) {
//     var context = document.getElementById("evolution-chart").getContext("2d");
//     var evolutionChart = new Chart(context).Line(graphicData, options);
// };

// $(document).ready(function() {
//     $.get('/graphicscontrols', function(graphicData, options) {
//         drawCanvasForChart(graphicData, options);
//     });

//     var options = {


//         ///Boolean - Whether grid lines are shown across the chart
//         scaleShowGridLines : true,

//         //String - Colour of the grid lines
//         scaleGridLineColor : "rgba(0,0,0,.05)",

//         //Number - Width of the grid lines
//         scaleGridLineWidth : 1,

//         scaleBeginAtZero: true,

//         //Boolean - Whether the line is curved between points
//         bezierCurve : true,

//         //Number - Tension of the bezier curve between points
//         bezierCurveTension : 0.4,

//         //Boolean - Whether to show a dot for each point
//         pointDot : true,

//         //Number - Radius of each point dot in pixels
//         pointDotRadius : 4,

//         //Number - Pixel width of point dot stroke
//         pointDotStrokeWidth : 1,

//         //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
//         pointHitDetectionRadius : 20,

//         //Boolean - Whether to show a stroke for datasets
//         datasetStroke : true,

//         //Number - Pixel width of dataset stroke
//         datasetStrokeWidth : 4,

//         //Boolean - Whether to fill the dataset with a colour
//         datasetFill : true,

//         //String - A legend template
//         legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"

//     };
//     

// });


$(function () {
    $.get('/graphicscontrols', function(data) {
        console.log(data)
    $('#container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Snow depth at Vikjafjellet, Norway'
        },
        subtitle: {
            text: 'Irregular time data in Highcharts JS'
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
                text: 'Snow depth (m)'
            },
            min: 0
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        },

        series: [data]
    });
});

});

