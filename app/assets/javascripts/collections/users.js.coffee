define ["backbone", "models/user"], (Backbone, User) ->
  'use strict';

  class Users extends Backbone.Collection
    url: '/users'
    model: User

  return Users
