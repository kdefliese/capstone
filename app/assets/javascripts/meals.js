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

  // adds foods/ingredients from db to the tables on the page
  $("#add-from-db").click(function() {
    event.preventDefault();
    var type = $("#food-type-select option:selected").val().slice(0,-1);
    var name = $("#dynamic-food-list").val();
    if (type === "Food") {
      $("#table-foods").append(
        "<tr id=\"f" + $("#dynamic-food-list option:selected")[0].id + "\"><td>" + name + "</td><td><button type=\"button\" class=\"close close-food\" id=\"f" + $("#dynamic-food-list option:selected")[0].id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
      );
    }
    else if (type === "Ingredient") {
      $("#table-ingredients").append(
        "<tr id=\"i" + $("#dynamic-food-list option:selected")[0].id + "\"><td>" + name + "</td><td><button type=\"button\" class=\"close close-ingredient\" id=\"i" + $("#dynamic-food-list option:selected")[0].id +  "\"aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></td></tr>"
      );
    }
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

  // adds food from search to meal tables on the page
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

    // used in meal creation and meal editing, since they share the same table structure
    var prepareForSave = function(type) {
      var rows = $(type).children().children();
      var arr = [];
      for (var i = 0; i < rows.length; i++) {
        arr.push(rows[i].id.slice(1));
      }
      return arr;
    };

    // submits meal and will create it in the db
    $("#create-meal").click(function() {
      event.preventDefault();
      var foods = prepareForSave("#table-foods");
      var ingredients = prepareForSave("#table-ingredients");
      $.ajax({
        method: "POST",
        url: "/meals",
        data: { name: $("#name").val(), user_id: $("#user-id").val(), category: $("#category-select").val(), food_ids: foods, ingredient_ids: ingredients }
      })
      .done(function() {
        console.log("post meal success");
          $(".new-meal-success").html("<div class=\"alert alert-success alert-dismissible\" role=\"alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" + $("#name").val() + " added!</div>");
        })
      .fail(function() {
        console.log("post meal failure");
      });
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

    // updates meal in the database after meal is edited
    $("#update-meal").click(function(event) {
      event.preventDefault();
      var foods = prepareForSave("#table-foods");
      var ingredients = prepareForSave("#table-ingredients");
      var patchUrl = "/meals/" + $("#meal-id").val();
      $.ajax({
        method: "PATCH",
        url: patchUrl,
        data: { id: $("#meal-id").val(), name: $("#name").val(), user_id: $("#user-id").val(), category: $("#category-select").val(), food_ids: foods, ingredient_ids: ingredients }
      })
      .done(function() {
        console.log("patch meal success");
        $(".new-meal-success").html("<div class=\"alert alert-success alert-dismissible\" role=\"alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" + $("#name").val() + " updated!</div>");
          })
      .fail(function() {
        console.log("patch meal failure");
      });
    });

});
