$(document).on 'turbolinks:load', ->
  $('#star-rating').raty
    path: '/assets'
    scoreName: 'review[score]'
