$(function () {
  var options = {
    title: {
      text: 'Paging Success Rate',
      x: -20
    },

    xAxis: {
      categories: []
    },

    yAxis: {
      title: {
        text: 'Paging Success Rate'
      },
      plotLines: [{
        value: 90,
        width: 3,
        dashStyle : 'shortdash',
        color: 'green'
      }]
    },

    plotOptions: {
      line: {
        dataLabels: {
          enabled: true
        },
        enableMouseTracking: false
      }
    },

    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
    },

    series: [{}]

  }

  $.getJSON('/data/psr.json', function(data) {
    var win = _.last(data, 7);
    options.xAxis.categories = _.pluck(win, 'date');
    options.series[0].name = 'PSR';
    options.series[0].data = _.pluck(win, 'value');
    $('#container').highcharts(options);
  });
});

