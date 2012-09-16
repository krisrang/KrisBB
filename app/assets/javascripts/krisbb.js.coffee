define ["backbone", "marionette", "vent", "views/send", "views/messages"],
  (Backbone, Marionette, vent, Send, MessagesView) ->
    app = new Marionette.Application()

    app.addRegions
      messages : '#bb-messages',
      sendbox  : '#bb-sendbox'

    # configuration, setting up regions, etc ...
    app.addInitializer () ->
      app.sendbox.show(new Send())
      app.messages.show(new MessagesView())

    app.on "initialize:after", (options) ->
      if (Backbone.history)
        Backbone.history.start pushState: true

      vent.trigger('app:loaded')

    return app
