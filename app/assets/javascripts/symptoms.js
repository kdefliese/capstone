$(document).on('ready', function() {

  $("#edit-symptom").click(function() {
    event.preventDefault();
    $("#symptom-end-time").defaultValue = "";
    var patchUrl = "/symptoms/" + $("#symptom-id").val();
    $.ajax({
      method: "PATCH",
      url: patchUrl,
      data: { name: $("#symptom-select").val(), severity: $("#symptom-severity").val(), start_time: $("#symptom-start-time").val(), end_time: $("#symptom-end-time").val(), notes: $("#symptom-notes").val(), user_id: $("#user-id").val(), day_id: $("#day-id").val() }
    })
    .done(function() {
      console.log("post symptom success");
      $(".updated-symptom-success").html("<div class=\"alert alert-success alert-dismissible\" role=\"alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" + $("#symptom-select").val() + " updated!</div>");
        })
    .fail(function() {
      console.log("post symptom failure");
    });
  });

});
