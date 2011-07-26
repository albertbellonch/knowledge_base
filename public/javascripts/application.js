$(document).ready(function(){
  // Activate purr
  $(".flash").purr();

  // Activate facebox
  $("a[rel*=facebox]").facebox();

  // Activate datepicker
  $(".date").datepicker($.datepicker.regional['ca']);

  /* Relative time conversion using jquery timeago */
  $("span.relative_time").timeago();

  // Add elastic to specific textareas
  $("textarea.elastic").elastic();

  // Activate hightlight
  hljs.tabReplace = "  ";
  hljs.initHighlightingOnLoad();
});
