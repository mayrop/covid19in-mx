Plotly.d3.csv('https://datos.covid19in.mx/series-de-tiempo/agregados/totales.csv', function(err, rows) {
  function unpack(rows, key) {
    return rows.map(function(row) { return row[key]; });
  }

  var trace1 = {
    type: 'scatter',
    mode: 'lines',
    name: 'Casos Positivos',
    x: unpack(rows, 'Fecha'),
    y: unpack(rows, 'Positivos'),
    line: {color: '#17BECF'}
  }

  var trace2 = {
    type: 'scatter',
    mode: 'lines',
    name: 'Defunciones',
    x: unpack(rows, 'Fecha'),
    y: unpack(rows, 'Defunciones_Positivos'),
    line: {color: '#D81B1B'}
  }

  var data = [trace1,trace2];

  var layout = {
    title: 'Casos COVID-19 en Mexico',
    xaxis: {
      autorange: true,
      range: [],
      type: 'date'
    },
    yaxis: {
      autorange: true,
      range: [0, 0],
      type: 'linear'
    },
    legend : {
      orientation: 'h',
      y:-0.15
    }
  };

  Plotly.newPlot('mySeries', data, layout);
})