$(document).ready(function(){
  // Activate purr
  $(".flash").purr();

  // Activate facebox
  $("a[rel*=facebox]").facebox();

  // Activate datepicker
  $(".date").datepicker($.datepicker.regional['ca']);
});
