# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@selectAll = ->
  $("#ingredients input:checkbox").each ->
    $(this).prop "checked", true     # ouch thought this was supposed to be attr

  $('#all_tag').prop "checked", true
  $('#none_tag').prop "checked", false

@selectNone = ->
  $("#ingredients input:checkbox").each ->
    $(this).prop "checked", false

  $('#all_tag').prop "checked", false
  $('#none_tag').prop "checked", true
