$(document).on 'turbolinks:load', ->
  $('.book-quantity-input-minus').click (event) ->
    event.preventDefault()
    input = $(event.target).parent().siblings('.quantity-input')
    quantity = input.val()
    if quantity <= 1
      return false
    else
      quantity--
    input.val quantity
    input.trigger 'change'
