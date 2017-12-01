$(document).on 'turbolinks:load', ->
  $("#read-more").click (event) ->
    event.preventDefault()
    full_description = $('#full_description').val()
    $(this).parent().html full_description
