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

  // adds foods from db to the meal entry div on the page
  $("#add-from-db").click(function() {
    event.preventDefault();
    var type = $("#food-type-select option:selected").val();
    var name = $("#dynamic-food-list").val();
    $("#print-new-meal").append(
      "<p>" + type + ": " + name + "</p>"
    );
    if (type === "Foods") {
      foodVals.push($("#dynamic-food-list option:selected")[0].id);
      $("#print-new-meal").data(type, foodVals);
    }
    else if (type === "Ingredients") {
      ingredientVals.push($("#dynamic-food-list option:selected")[0].id);
      $("#print-new-meal").data(type, ingredientVals);
    }
  });

  // autocomplete for food search
  var cache = {};
  $("#autocomplete").autocomplete({
    minLength: 2,
    source: function(request, response) {
      var term = request.term;
      $.getJSON("/foods/search", request, function(data) {
        response(data);
      });
    },
    select: function( event, ui ) {
      $("#autocomplete").val(ui.item.label);
      $("#factual-id").val(ui.item.value);
      return false;
    }
  });

  // adds food from search to meal div on the page
  $("#add-from-search").click(function() {
    var factual_id = $("#factual-id").val();
    var url = "/foods/search_specific?factual_id=" + factual_id;
    $.ajax(url)
      .done(function(data) {
        console.log("success");
        // adds the food to the food entry on the page
        $("#print-new-meal").append(
          "<p> Foods: " + data.name + "</p>"
        );
        foodVals.push(data.id);
        $("#print-new-meal").data("Foods", foodVals);
      })
      .fail(function() {
        console.log("failure");
      });
    });

    // submits meal and will update it in the db
    $("#create-meal").click(function() {
      $.ajax({
        method: "POST",
        url: "/meals",
        data: { name: $("#name").val(), user_id: $("#user-id").val(), category: $("#category-select").val(), food_ids: $("#print-new-meal").data("Foods"), ingredient_ids: $("#print-new-meal").data("Ingredients") }
      })
      .done(function() {
        console.log("post meal success");
          // make another call to get the most recent entry and add it to the page
          $.ajax("/meals/last")
            .done(function(data) {
              console.log("last meal success");
              // var foods = "";
              // var ingredients = "";
              // for (var j = 0; j < data.foods.length; j++) {
              //     foods += "<div class=\"food\">" + data.foods[j].name + "</div>";
              // }
              // for (var k = 0; k < data.ingredients.length; k++) {
              //     ingredients += "<div class=\"ingredient\">" + data.ingredients[k].name + "</div>";
              // }
              // var category = data.entry.category.toUpperCase();
              // $("#added-entries").append(
              //   "<div class=\"entry\" id=\"" + data.entry_time + "\">" + category + "<br />" + data.entry_time + "<br />" + data.entry.notes + "<br /> <a class=\"btn btn-danger\" data-confirm=\"Are you sure?\" rel=\"nofollow\" data-method=\"delete\" href=\"/entries/" + data.entry.id + "\">Remove entry</a><a class=\"edit-entry\" rel=\"nofollow\" data-method=\"patch\" href=\"/entries/" + data.entry.id + "\">Edit entry</a>" + meals + "<br />" + foods + "<br />" + ingredients + "<br />" + "</div>"
              // );
              $("#print-new-meal").empty();
              $("#print-new-meal").removeData();
              document.getElementById("meal-entry-form").reset();
              foodVals = [];
              ingredientVals = [];
            })
            .fail(function() {
              console.log("last meal failure");
            });
          })
      .fail(function() {
        console.log("post meal failure");
      });
    });

});
