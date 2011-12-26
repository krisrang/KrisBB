# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require ./lib/modernizer
#= require ./lib/date
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

  $('a.smilie').live 'click', (e)->
    e.preventDefault()
    key = $(this).attr('data-key')
    $('#messageform textarea').insertAtCaret(key)