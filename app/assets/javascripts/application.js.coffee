#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require ./lib/date
#= require ./lib/modernizer
#= require ./lib/placeholder.shim
#= require ./lib/utils
#= require_self

$ ->
  $('.smilie').tooltip()
  $('.message-contents img, .tutorial img').tooltip live: true, title: 'alt'
  $('.online-bit').tooltip()

  $('.smilies a').live 'click', (e)->
    e.preventDefault()
    key = $(this).attr('data-key')
    $('#messageform textarea').insertAtCaret(key)