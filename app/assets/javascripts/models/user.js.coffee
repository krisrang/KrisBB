'use strict';

class User extends  Backbone.RelationalModel
  idAttribute: '_id'

  constructor: ->
    super
    @bind 'change', @onChange

  onChange: ->
    @get('messages').map (message) ->
      message.trigger('change')

  deleted: ->
    @get('deleted')

  url: ->
    return "/users/" + (if @isNew() then '' else @id)

User.setup()

KrisBB.Vent.bind 'pusher:user', (user) =>
  record = User.findOrCreate(user["_id"])
  if record?
    record.set user

window.KrisBB.Models.User = User
