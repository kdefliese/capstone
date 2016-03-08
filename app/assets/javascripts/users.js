
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

  // point click function used inside the highcharts function below
  var pointClick = function(pointDate) {
    var options = {};
    options.timeZone = 'UTC';
    options.timeZoneName = 'short';
    var a = new Date(pointDate);
    a = a.toLocaleString('en-US', options);
    console.log(a);
    // need to determine what ID to use for the date that you clicked on
    var id = 10;
    url = "/days/" + id + "/summary";
    $.ajax(url)
    .done(function(data) {
      console.log("success");
      console.log(data);
      // remove content for any other days that you previously clicked on
      $("#day-data").empty();
      // now add content for the day that you clicked on
      for (var i = 0; i < data.entries.length; i++) {
        $("#day-data").append(
          "<div class=\"entry\" id=\"" + data.entries[i].entry.id + "\">" + data.entries[i].entry.category + "<br />" + data.entries[i].entry.time + "<br />" + data.entries[i].entry.notes + "</div>"
        );
        for (var j = 0; j < data.entries[i].entry.meals.length; j++) {
          $("#" + data.entries[i].entry.id).append(
            "<div class=\"meal\">" + data.entries[i].entry.meals[j].name + "</div>"
          );
        }
      }

    })
    .fail(function() {
      console.log("failure");
    });
  };

  // creates highcharts graph
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
          type: 'datetime'
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
            for (var j = 0; j < data[i][1].length; j++) {
              var dateStr = data[i][1][j][0];
              newDate = Date.UTC(Number(dateStr.slice(6,10)),(Number(dateStr.slice(0,2) - 1)), Number(dateStr.slice(3,5)));
              data[i][1][j][0] = newDate;
            }
            // need to add the day ID to each data point
            // for (var k = 0; k < data[i][1].length; k++) {
            //   var id = data[i][1][k][2];
            //   data[i]
            // }
            // data needs to look like {
            //    x: ,
            //    y: ,
            //    id: 17
            // }
          chart.addSeries({
            name: data[i][0],
            data: data[i][1],
            cursor: 'pointer',
            point: {
              events: {
                click: function () {
                  console.log(this);
                  pointClick(this.x);
                }
              }
            }
          });
        }
    });

  });




});
