
    // $(document).ready(function() {
    // console.log("hola")

    // $.getJSON('graphicscontrols', function (controls) {
    //             function printControls(controls)
            


    // function arraySeries(controls) {
    //     var series=[];
    //     for (i in controls) {

    //     }
    // }



    // function printcontrols(controls) {

    function printControls (data) {
    // $(function () {
        $('#container').highcharts({
            chart: {

                width: 1330,
                height: 600
            },
            title: {
                text: 'My diabethes evolution'
            },
            subtitle: {
                text: 'Source: WorldClimate.com'
            },
            xAxis: {
                type: 'datetime',
                dateTimeLabelFormats: {
                    hour: '%H:%M'
                }
            },
            yAxis: {
                min: 0,
                max: 250,
                tickInterval: 50,
                title: {
                    text: 'Blood Sugar Level (d/g)'
                }
            },
            plotOptions:{
            series:{
                pointStart:Date.UTC(2014,11,31,6,0,0,0),
                pointInterval: 3600 * 2000
            }
        },
            series: // data

             [{
                 name: 'Tokyo',
                data: [data[1].level, data[2].level, data[3].level]
            }, 
            {
                 name: 'London',
                 data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
             }]
        });
    }


    $(document).ready(function() {
 $.ajax({
    url: '/graphicscontrols',
    type: 'GET',
    async: true,
    dataType: "json",
    success: function (data) {
        printControls(data);
        console.log(data)
    }
  });
 });  


//       $(document).ready(function() {

//     var options = {
//         chart: {
//             renderTo: 'container',
//             type: 'spline'
//         },
//         title: {
//                 text: 'My diabethes evolution'
//             },
//             subtitle: {
//                 text: 'Source: WorldClimate.com'
//             },
//             xAxis: {
//                 type: 'datetime',
//                 dateTimeLabelFormats: {
//                     hour: '%H:%M'
//                 }
//             },
//             yAxis: {
//                 min: 0,
//                 max: 250,
//                 tickInterval: 50,
//                 title: {
//                     text: 'Blood Sugar Level (d/g)'
//                 }
//             },
//             plotOptions:{
//             series:{
//                 pointStart:Date.UTC(2014,11,31,6,0,0,0),
//                 pointInterval: 3600 * 2000
//                 }
//             },
//             series: [{}]
//     };

//     $.getJSON('graphicscontrols', function(data) {
//         options.series.data = data;
//         var chart = new Highcharts.Chart(options);
//     });

// });