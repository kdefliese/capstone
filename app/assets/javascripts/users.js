$(document).on('ready', function() {
  $("#add-food-intolerance").click(function() {
    event.preventDefault();
    $("#food-intolerances").append("<p>" + $("#new-food-intolerance").val() + "</p>");
  });

  $("#add-watch-food").click(function() {
    event.preventDefault();
    $("#food-watches").append("<p>" + $("#new-food-watch").val() + "</p>");
  });

  $("#add-medical-disorder").click(function() {
    event.preventDefault();
    $("#medical-disorders").append("<p>" + $("#new-medical-disorder").val() + "</p>");
  });

});
