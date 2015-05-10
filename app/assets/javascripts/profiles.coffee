# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

width = 10;
progress_bar = ->
  $('#user-language-bar').width(width + "%")
  width = (width + 10) % 110

$ ->
  $('[data-toggle="tooltip"]').tooltip()
  jQuery(".best_in_place").best_in_place();
  if($('#user-languages').length)
    progress = setInterval(progress_bar, 500)
    $.ajax("/languages")
    .always(->
      clearInterval(progress))
