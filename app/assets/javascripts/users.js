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
    $('#container').highcharts({
      title: {
        text: 'Your Symptoms',
        x: -20 //center
      },
      xAxis: {
        categories: ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri',
        'Sat']
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
      series: [{
        name: 'Pain',
        data: [7, 6, 9, 10, 10, 5, 5]
      }, {
        name: 'Gas',
        data: [0, 0, 5, 10, 10, 10]
      }, {
        name: 'Bloating',
        data: [0, 0, 3, 8, 10, 10, 10]
      }, {
        name: 'Migraine',
        data: [3, 4, 5, 8, 10, 10, 10]
      }]
    });
  });



});
