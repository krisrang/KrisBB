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

    pusher = new Pusher(KrisBBsetup.settings.pusher.key)
    pusher.connection.bind 'connected', ->
      vent.trigger 'pusher:connected', pusher

    channel = pusher.subscribe('main')
    channel.bind 'message', (data) ->
      vent.trigger 'pusher:message', JSON.parse(data.message)
    channel.bind 'user', (data) ->
      vent.trigger 'pusher:user', JSON.parse(data.user)

    return app
