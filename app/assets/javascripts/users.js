var Play;
$(document).on('ready', function() {

  $("#add-food-intolerance").click(function() {
    event.preventDefault();
    $("#food-intolerances").append("<p class=\"food-intolerance\">" + $("#new-food-intolerance").val() + "</p>");
  });

  $("#add-watch-food").click(function() {
    event.preventDefault();
    $("#food-watches").append("<p>" + $("#new-food-watch").val() + "</p>");
  });

  $("#add-medical-disorder").click(function() {
    event.preventDefault();
    $("#medical-disorders").append("<p>" + $("#new-medical-disorder").val() + "</p>");
  });

  // when they click the update user button
  $(".submit").click(function() {
    event.preventDefault();
    var intolerances = [];
    var watching = [];
    var medical = [];
    $(".food-intolerance").each(function() {
      intolerances.push($(this).text());
    });
    $(".food-watch").each(function() {
      watching.push($(this).text());
    });
    $(".medical").each(function() {
      medical.push($(this).text());
    });
    var int = JSON.stringify(intolerances);
    var wat = JSON.stringify(watching);
    var med = JSON.stringify(medical);
    var patchUrl = "/users/" + $("#user-id").val();
    $.ajax({
      method: "PATCH",
      url: patchUrl,
      data: { email: $("#user_email").val(), phone: $("#user_phone").val(), name: $("#user_name").val(), image: $("#user_image").val(), notifications_preference: $("#user_notifications_preference").val(), known_intolerances: intolerances }
      // watching: JSON.stringify(intolerances), medical_disorders: JSON.stringify(intolerances)
    })
    .done(function() {
      console.log("user update success");
    })
    .fail(function() {
      console.log("user update failure");
    });
  });


  $(function () {

    var options = {
        chart: {
            renderTo: 'container',
            type: 'line'
        },
        title: {
          text: 'Your Symptoms',
          x: -20 //center
        },
        xAxis: {
          categories: ['Mar 1','Mar 2','Mar 3','Mar 4','Mar 5','Mar 6']
        },
        yAxis: {
          title: {
            text: 'Severity'
          },
          plotLines: [{
            value: 0,
            width: 1,
            color: '#808080'
          }]
        },
        tooltip: {

        },
        legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'middle',
          borderWidth: 0
        },
        series: []
    };

    $.getJSON('/getstats', function(data) {
      console.log(data);
        var chart = new Highcharts.Chart(options);
        for (var i = 0; i < data.length; i++) {
          chart.addSeries({
            name: data[i][0],
            data: data[i][1],
            // pointStart: Date.UTC(2016, 2, 1),
            // pointInterval: 24 * 3600 * 1000 // one day
          });
        }
        console.log(chart.series);
    });

  });




});
