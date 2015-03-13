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



    $.ajax({
               type: "GET",
               contentType: "application/json; charset=utf-8",
               url: '/graphics/data',
               dataType: 'json',
               success: function (data) {
                   draw(data);
               },
               error: function (result) {
                   error();
               }
           });
     
    function draw(data) {
        var color = d3.scale.category20b();
        var width = 420,
            barHeight = 20;
     
        var x = d3.scale.linear()
            .range([0, width])
            .domain([0, d3.max(data)]);
     
        var chart = d3.select("#graph")
            .attr("width", width)
            .attr("height", barHeight * data.length);
     
        var bar = chart.selectAll("g")
            .data(data)
            .enter().append("g")
            .attr("transform", function (d, i) {
                      return "translate(0," + i * barHeight + ")";
                  });
     
        bar.append("rect")
            .attr("width", x)
            .attr("height", barHeight - 1)
            .style("fill", function (d) {
                       return color(d)
                   })
     
        bar.append("text")
            .attr("x", function (d) {
                      return x(d) - 10;
                  })
            .attr("y", barHeight / 2)
            .attr("dy", ".35em")
            .style("fill", "white")
            .text(function (d) {
                      return d;
                  });
    }
     
    function error() {
        console.log("error")
    }
});

