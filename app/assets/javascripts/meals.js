var foodVals = [];
var ingredientVals = [];

$(document).on('ready', function() {

  // updates foods/ingredients dropdown based on first dropdown selection
  $("#food-type-select").change(function() {
    $("#food-type-select option:selected").each(function() {
      var select_val = $("#food-type-select option:selected").val();
      var url = "";
      if (select_val === "Foods") {
        url = "/foods/all";
        button_word = "food";
      }
      else if (select_val === "Ingredients") {
        url = "/ingredients/all";
        button_word = "ingredient";
      }
      $.ajax(url)
      .done(function(data) {
        console.log("success");
        var replace_html = "<select id=\"dynamic-food-list\" class=\"form-control\">";
        for (var i = 0; i < data.length; i++) {
          replace_html += "<option value=\"" + data[i].name + "\" id=\"" + data[i].id + "\">" + data[i].name + "</option>";
        }
        replace_html += "</select>";
        $("#dynamic-food-list").replaceWith(
          replace_html
        );
        $("#add-to-entry").val(
          "Add " + button_word + " to meal"
        );
      })
      .fail(function() {
        console.log("failure");
      });
    });
  });

  // adds things to the meal entry on the page
  $("#add-from-db").click(function() {
    event.preventDefault();
    var type = $("#food-type-select option:selected").val();
    var name = $("#dynamic-food-list").val();
    $("#print-new-meal").append(
      "<p>" + type + ": " + name + "</p>"
    );
    if (type === "Foods") {
      foodVals.push($("#dynamic-food-list option:selected")[0].id);
      $("#print-new-entry").data(type, foodVals);
    }
    else if (type === "Ingredients") {
      ingredientVals.push($("#dynamic-food-list option:selected")[0].id);
      $("#print-new-entry").data(type, ingredientVals);
    }
  });


});
