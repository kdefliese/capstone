// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).on('ready', function() {
  $("#food-type-select")
  .change(function() {
    $("#food-type-select option:selected").each(function() {
      var select_val = $("#food-type-select option:selected").val();
      var url = "";
      if (select_val == "Meals") {
        url = "/meals/all";
      }
      else if (select_val == "Foods") {
        url = "/foods/all";
      }
      else if (select_val == "Ingredients") {
        url = "/ingredients/all";
      }
      $.ajax(url)
      .done(function(data) {
        console.log("success");
        console.log(data);
      })
      .fail(function() {
        console.log("failure");
      });
    });
  })
  .trigger("change");
});
