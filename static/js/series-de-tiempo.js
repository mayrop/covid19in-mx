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
    line: {color: '#D81B1B'}
  }

  var trace2 = {
    type: 'scatter',
    mode: 'lines',
    name: 'Casos Sospechosos',
    x: unpack(rows, 'Fecha'),
    y: unpack(rows, 'Sospechosos'),
    line: {color: '#FFC20A'}
  }  

  var trace3 = {
    type: 'scatter',
    mode: 'lines',
    name: 'Casos Negativos',
    x: unpack(rows, 'Fecha'),
    y: unpack(rows, 'Negativos'),
    line: {color: '#005AB5'}
  }    

  var trace4 = {
    type: 'scatter',
    mode: 'lines',
    name: 'Defunciones',
    x: unpack(rows, 'Fecha'),
    y: unpack(rows, 'Defunciones'),
    line: {color: '#000000'}
  }


  var data = [trace1,trace2,trace3,trace4];

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
    }
  };

  Plotly.newPlot('mySeries', data, layout);
})