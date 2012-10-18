"use strict";

KrisBB.App = new Backbone.Marionette.Application()

# Regions
KrisBB.App.addRegions
  messages : '#bb-messages'
  sendbox  : '#bb-sendbox'
  userbar  : '#bb-userbar'

# Initializers for views and history
KrisBB.App.addInitializer () ->
  KrisBB.App.sendbox.show(new KrisBB.Views.Send())
  KrisBB.App.messages.show(new KrisBB.Views.Messages())
  KrisBB.App.userbar.show(new KrisBB.Views.Userbar())

KrisBB.App.on "initialize:after", (options) ->
  if (Backbone.history)
    Backbone.history.start pushState: true

# Pusher setup
pusher = new Pusher(KrisBB.Settings.pusher.key)
Pusher.channel_auth_endpoint = KrisBB.Settings.pusher.endpoint;

pusher.connection.bind 'connected', ->
  KrisBB.Vent.trigger 'pusher:connected', pusher

  channel = pusher.subscribe('private-main')
  channel.bind 'message', (data) ->
    KrisBB.Vent.trigger 'pusher:message', JSON.parse(data.message)
  channel.bind 'delete', (data) ->
    KrisBB.Vent.trigger 'pusher:delete', data.id
  channel.bind 'user', (data) ->
    KrisBB.Vent.trigger 'pusher:user', JSON.parse(data.user)

  presenceChannel = pusher.subscribe('presence-main')
  presenceChannel.bind 'pusher:subscription_succeeded', () ->
    KrisBB.Vent.trigger 'pusher:presence_subscribed', presenceChannel
  presenceChannel.bind 'pusher:member_added', (member) ->
    KrisBB.Vent.trigger 'pusher:joined', member, presenceChannel
  presenceChannel.bind 'pusher:member_removed', (member) ->
    KrisBB.Vent.trigger 'pusher:left', member, presenceChannel

# Render eco templates
Backbone.Marionette.Renderer.render = (template, data) ->
  data.routes = Routes
  data.currentUser = KrisBB.User
  return template(data)

# Start app
new KrisBB.Routers.Router
  controller: KrisBB.Controllers.Controller

KrisBB.App.start()
