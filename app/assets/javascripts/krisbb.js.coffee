define ["backbone", "marionette", "vent", "views/send"], (Backbone, Marionette, vent, Send) ->
  # set up the app instance
  app = new Marionette.Application()

  app.addRegions
    messages : '#bb-messages',
    sendbox  : '#bb-sendbox'

  # configuration, setting up regions, etc ...
  app.addInitializer () ->
    app.sendbox.show(new Send())

  app.on "initialize:after", (options) ->
    if (Backbone.history)
      Backbone.history.start pushState: true

  return app
