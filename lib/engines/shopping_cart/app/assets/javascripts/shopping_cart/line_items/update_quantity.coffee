$(document).on 'turbolinks:load', ->
  $('.quantity-input').change ->
    $(this).parent().children("input[type='submit']").click()
