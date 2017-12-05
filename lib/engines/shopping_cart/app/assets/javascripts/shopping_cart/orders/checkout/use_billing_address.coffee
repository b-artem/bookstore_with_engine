$(document).on 'turbolinks:load', ->
  checked = $('#use_billing_address').data('checked')
  $('#use_billing_address').prop 'checked', checked
  $('#shipping-address-form').prop 'hidden', checked

  $("#use_billing_address").change ->
    checked = $(this).prop('checked')
    $('#shipping-address-form').prop 'hidden', checked
