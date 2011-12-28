#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require ./lib/modernizer
#= require ./lib/placeholder.shim
#= require ./lib/utils
#= require_self

$ ->
  $('#searchform input').focus ->
    $('#searchform').addClass 'expand'

  $('#searchform input').blur ->
    $('#searchform').removeClass 'expand'

  $('.smilies a').twipsy()
  $('.message-contents img, .tutorial img').twipsy live: true, title: 'alt'
  $('.online-bit').twipsy()

  $('a.smilie').live 'click', (e)->
    e.preventDefault()
    key = $(this).attr('data-key')
    $('#messageform textarea').insertAtCaret(key)