#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require ./lib/date
#= require ./lib/modernizer
#= require ./lib/placeholder.shim
#= require ./lib/utils
#= require_self

$ ->
  $('#searchform input').focus ->
    $('#searchform').addClass 'expand'

  $('#searchform input').blur ->
    $('#searchform').removeClass 'expand'

  $('.smilies a').tooltip()
  $('.message-contents img, .tutorial img').tooltip live: true, title: 'alt'
  $('.online-bit').tooltip()

  $('a.smilie').live 'click', (e)->
    e.preventDefault()
    key = $(this).attr('data-key')
    $('#messageform textarea').insertAtCaret(key)