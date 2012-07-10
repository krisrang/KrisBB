class MainApp
  constructor: () ->
    @events = _.extend({}, Backbone.Events)

  start: ->
    #Backbone.history.start()
    @events.trigger 'start', ''
    @processInfo()

  template: (name, context) ->
    JST["app/templates/#{name}"] context

  processInfo: () =>
    @userInfo = window.user
    @settings = window.settings
    @events.trigger 'app-loaded'

  log: (data) =>
    console.log data

@app = new MainApp()

$ ->
  #window.location.href = '#'
  app.start()

#window.Pusher.log = (message)->
#  if (window.console && window.console.log)
#    window.console.log(message)