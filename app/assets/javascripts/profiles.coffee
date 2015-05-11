# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  github_id = $('#user').data('user')
  base_user_route = "/users/" + github_id

  $('[data-toggle="tooltip"]').tooltip()
  jQuery(".best_in_place").best_in_place()

  if($('#user-languages').length)
    $.ajax(base_user_route + "/languages")
    $.ajax(base_user_route + "/repositories")
