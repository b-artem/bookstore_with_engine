$(document).on 'turbolinks:load', ->
  $("#state-filter li a").click ->
    text = $(this).text()
    setTimeout (->
      $('span#text').text text
    ), 300
