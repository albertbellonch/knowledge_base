$(document).ready(function(){
  // Active Best in Place
  $(".best_in_place").best_in_place();

  // Activate purr
  $(".flash").purr();

  // Activate facebox
  $("a[rel*=facebox]").facebox();

  // Activate datepicker
  $(".date").datepicker($.datepicker.regional['ca']);
});
