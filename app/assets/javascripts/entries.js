$(document).on('ready', function() {

  // adds things to the food entry on the page
  $("#add-from-db").click(function() {
    event.preventDefault();
    var type = $("#food-type-select option:selected").val().slice(0,-1);
    var name = $("#dynamic-food-list-day-page").val();
    if (type === "Meal") {
      $("#table-meals").append(
        "<tr id=\"m" + $("#dynamic-food-list-day-page option:selected")[0].id + "\"><td>" + name + "</td><td><button type=\"button\" class=\"close close-meal\" id=\"m" + $("#dynamic-food-list-day-page option:selected")[0].id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
      );
    }
    else if (type === "Food") {
      $("#table-foods").append(
        "<tr id=\"f" + $("#dynamic-food-list-day-page option:selected")[0].id + "\"><td>" + name + "</td><td><button type=\"button\" class=\"close close-food\" id=\"f" + $("#dynamic-food-list-day-page option:selected")[0].id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
      );
    }
    else if (type === "Ingredient") {
      $("#table-ingredients").append(
        "<tr id=\"i" + $("#dynamic-food-list-day-page option:selected")[0].id + "\"><td>" + name + "</td><td><button type=\"button\" class=\"close close-ingredient\" id=\"i" + $("#dynamic-food-list-day-page option:selected")[0].id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
      );
    }
  });

  // removes meals from meal div on the page
  $("#table-meals").on("click", ".close-meal", function() {
    var id = this.id;
    $("tr").remove("#" + id);
  });

  // removes foods from meal div on the page
  $("#table-foods").on("click", ".close-food", function() {
    var id = this.id;
    $("tr").remove("#" + id);
  });

  // removes ingredients from meal div on the page
  $("#table-ingredients").on("click", ".close-ingredient", function() {
    var id = this.id;
    $("tr").remove("#" + id);
  });

  // autocomplete for food search
  $("#autocomplete").autocomplete({
    minLength: 2,
    source: function(request, response) {
      var term = request.term;
      var url = "/foods/search";
      if ($("#search-type-select").val() === "Barcode") {
        url = "/foods/search_barcode";
      }
      $.getJSON(url, request, function(data) {
        response(data);
      });
    },
    select: function( event, ui ) {
      $("#autocomplete").val(ui.item.label);
      $("#factual-id").val(ui.item.value);
      return false;
    }
  });

  // adds food from search to entry div on the page
  $("#add-from-search").click(function() {
    var factual_id = $("#factual-id").val();
    var url = "/foods/search_specific?factual_id=" + factual_id;
    $.ajax(url)
      .done(function(data) {
        console.log("success");
        // adds the food to the food entry on the page
        $("#table-foods").append(
          "<tr id=\"f" + data.id + "\"><td>" + data.name + "</td><td><button type=\"button\" class=\"close close-food\" id=\"f" + data.id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
        );
      })
      .fail(function() {
        console.log("failure");
      });
    });

  // if checkbox for "save as meal" is checked
  $("#save-meal-checkbox").change(function() {
    if(this.checked) {
      $("#save-meal-name").removeClass("hidden-field");
      $("#save-meal-checkbox").val("save");
    }
    else {
      $("#save-meal-name").addClass("hidden-field");
      $("#save-meal-checkbox").val(false);
    }
});

  // used in creating food entry
  var prepareForSave = function(type) {
    var rows = $(type).children().children();
    var arr = [];
    for (var i = 0; i < rows.length; i++) {
      arr.push(rows[i].id.slice(1));
    }
    return arr;
  };

  // submits food entry and will update it in the db
  $("#update-food-entry").click(function() {
    event.preventDefault();
    // if saving meal, do that first
    if ($("#save-meal-checkbox").val() === "save") {
      var foods = prepareForSave("#table-foods");
      var ingredients = prepareForSave("#table-ingredients");
      $.ajax({
        method: "POST",
        url: "/meals",
        data: { name: $("#meal-name").val(), user_id: $("#user-id").val(), category: $("#category-select").val(), food_ids: foods, ingredient_ids: ingredients }
      })
      .done(function() {
        console.log("post meal success");
          // retrieves last meal created from db
          $.ajax("/meals/last")
            .done(function(data) {
              console.log("last meal success");
              // adds meal ID
              mealVals.push(data.meal.id);
              $("#print-new-entry").data("Meal", mealVals);
              // now make call to create entry in db
              var patchUrl = "/entries/" + $("#entry-id").val();
              $.ajax({
                method: "PATCH",
                url: patchUrl,
                data: {id: $("#entry-id").val(), notes: $("#notes").val(), time: $("#time").val(), user_id: $("#user-id").val(), day_id: $("#day-id").val(), category: $("#category-select").val(), meal_ids: $("#print-new-entry").data("Meal") }
              })
              .done(function() {
                console.log("patch entry success");
                $(".entry-update-success").html("<div class=\"alert alert-success alert-dismissible\" role=\"alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> Entry updated!</div>");
                  })
              .fail(function() {
                console.log("patch entry failure");
              });
            })
            .fail(function() {
              console.log("last meal failure");
            });
          })
      .fail(function() {
        console.log("post meal failure");
      });
    }
    else {
      // now make call to create entry in db
      var foods = prepareForSave("#table-foods");
      var ingredients = prepareForSave("#table-ingredients");
      var meals = prepareForSave("#table-meals");
      var patchUrl = "/entries/" + $("#entry-id").val();
      $.ajax({
        method: "PATCH",
        url: patchUrl,
        data: {id: $("#entry-id").val(), notes: $("#notes").val(), time: $("#time").val(), user_id: $("#user-id").val(), day_id: $("#day-id").val(), category: $("#category-select").val(), meal_ids: meals, food_ids: foods, ingredient_ids: ingredients }
      })
      .done(function() {
        console.log("patch entry success");
            $(".entry-update-success").html("<div class=\"alert alert-success alert-dismissible\" role=\"alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> Entry updated!</div>");
          })
      .fail(function() {
        console.log("patch entry failure");
      });
    }
  });

});
