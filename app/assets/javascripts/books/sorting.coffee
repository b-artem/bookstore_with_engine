$(document).on 'turbolinks:load', ->

  $("#sort-by li a").click ->
    text = $(this).text()
    setTimeout (->
      $("span#text").text text
    ), 500

  $("#sort-by-xs li a").click ->
    text = $(this).text()
    setTimeout (->
      $("span#text-xs").text text
    ), 500
