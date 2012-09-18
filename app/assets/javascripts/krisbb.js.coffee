"use strict";

KrisBB.app = new Backbone.Marionette.Application()

KrisBB.app.addRegions
  messages : '#bb-messages',
  sendbox  : '#bb-sendbox'

KrisBB.app.addInitializer () ->
  KrisBB.app.sendbox.show(new KrisBB.views.send())
  KrisBB.app.messages.show(new KrisBB.views.messages())

KrisBB.app.on "initialize:after", (options) ->
  if (Backbone.history)
    Backbone.history.start pushState: true

pusher = new Pusher(KrisBBsetup.settings.pusher.key)
pusher.connection.bind 'connected', ->
  KrisBB.vent.trigger 'pusher:connected', pusher

channel = pusher.subscribe('main')
channel.bind 'message', (data) ->
  KrisBB.vent.trigger 'pusher:message', JSON.parse(data.message)
channel.bind 'user', (data) ->
  KrisBB.vent.trigger 'pusher:user', JSON.parse(data.user)

Backbone.Marionette.Renderer.render = (template, data) ->
  data.routes = Routes
  return template(data)

new KrisBB.routers.Router
  controller: KrisBB.controllers.Controller

KrisBB.app.start()
