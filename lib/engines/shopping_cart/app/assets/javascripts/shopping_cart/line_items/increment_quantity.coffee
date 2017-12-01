$(document).on 'turbolinks:load', ->
  $('.quantity-input-plus').click ->
    event.preventDefault()
    input = $(event.target).parent().siblings('.quantity-input')
    quantity = input.val()
    quantity++
    input.val quantity
    input.trigger 'change'
