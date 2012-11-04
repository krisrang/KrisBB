#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require ./lib/jquery.caret
#= require ./lib/autotype
#= require ./lib/modernizr
#= require ./lib/shims
#= require ./lib/timeago
#= require_self

# Avoid `console` errors in browsers that lack a console
if !(window.console && console.log)
  ->
    noop = ->
    methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
      'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
      'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table',
      'time', 'timeEnd', 'timeStamp', 'trace', 'warn']
    length = methods.length
    console = window.console = {}
    while length--
        console[methods[length]] = noop

    return

$ ->
  $('[rel=tooltip]').tooltip()
  $('.timeago').timeago()

  return
