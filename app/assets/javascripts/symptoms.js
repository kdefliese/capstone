$(document).on('ready', function() {
  
  $("#submit-symptom").click(function() {
    event.preventDefault();
    $("#symptom-end-time").defaultValue = "";
    $.ajax({
      method: "POST",
      url: "/symptoms",
      data: { name: $("#symptom-select").val(), severity: $("#symptom-severity").val(), start_time: $("#symptom-start-time").val(), end_time: $("#symptom-end-time").val(), notes: $("#symptom-notes").val(), user_id: $("#user-id").val(), day_id: $("#day-id").val() }
    })
    .done(function() {
      console.log("post symptom success");
        // make another call to get the most recent symptom and add it to the page
        $.ajax("/symptoms/last")
          .done(function(data) {
            console.log("last symptom success");
            // document.getElementById("symptom-entry-form").reset();
            location.reload();
          })
          .fail(function() {
            console.log("last symptom failure");
          });
        })
    .fail(function() {
      console.log("post symptom failure");
    });
  });

});
