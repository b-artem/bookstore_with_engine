$(document).on 'turbolinks:load', ->
  $('.book-quantity-input-plus').click ->
    event.preventDefault()
    input = $(event.target).parent().siblings('.quantity-input')
    quantity = input.val()
    quantity++
    input.val quantity
    input.trigger 'change'
