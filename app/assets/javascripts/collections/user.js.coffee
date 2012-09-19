'use strict';

class Users extends Backbone.Collection
  url: '/users'
  model: KrisBB.Models.User

  initialize: ->
    KrisBB.Vent.bind 'pusher:user', (user) =>
      record = @findOrCreate(user["_id"])
      if record?
        record.set user

window.KrisBB.Collections.Users = new Users()
