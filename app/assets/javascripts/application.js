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
        button_word = "meal";
      }
      else if (select_val == "Foods") {
        url = "/foods/all";
        button_word = "food";
      }
      else if (select_val == "Ingredients") {
        url = "/ingredients/all";
        button_word = "ingredient";
      }
      $.ajax(url)
      .done(function(data) {
        console.log("success");
        console.log(data);
        var replace_html = "<select id=\"dynamic-food-list\">";
        for (var i = 0; i < data.length; i++) {
          replace_html += "<option value=\"" + data[i].name + "\">" + data[i].name + "</option>";
        }
        replace_html += "</select>";
        $("#dynamic-food-list").replaceWith(
          replace_html
        );
        $("#add-to-entry").val(
          "Add " + button_word + " to entry"
        );
      })
      .fail(function() {
        console.log("failure");
      });
    });
  })
  .trigger("change");
});
