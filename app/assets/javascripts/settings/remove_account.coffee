$(document).on 'turbolinks:load', ->
  $('#remove-account-cb').change ->
    $('#remove-account-btn').prop 'disabled', !$("#remove-account-btn").prop('disabled')
    $('#remove-account-btn').toggleClass 'disabled'
