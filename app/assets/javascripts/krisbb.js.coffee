#= require ./lib/json2
#= require ./lib/underscore
#= require ./lib/backbone
#= require ./lib/modernizer
#= require_self
#= require_tree ./app/

window.App =
  Models: {}
  Collections: {}
  Views: {}

$ ->
  window.KrisBB = new App.Router()
  Backbone.history.start() #pushState: true