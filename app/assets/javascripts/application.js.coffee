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
#= require_self

window.log = ->
  log.history = log.history || []
  log.history.push(arguments)
  if this.console
    arguments.callee = arguments.callee.caller
    newarr = [].slice.call(arguments)
    if console.log? then log.apply.call(console.log, console, newarr) else console.log.apply(console, newarr)

parseISO8601 = (date)->
  if date.getTime
      return date
  else if typeof date == "string"
    return Date.parse(date)
  else if typeof date == "number"
    return new Date(date)

$ ->
  $('#searchform input').focus ->
    $('#searchform').addClass 'expand'

  $('#searchform input').blur ->
    $('#searchform').removeClass 'expand'