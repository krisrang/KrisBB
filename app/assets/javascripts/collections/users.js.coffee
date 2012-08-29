define ["backbone", "models/user"], (Backbone, User) ->
  'use strict';

  return Backbone.Collection.extend
    url: '/users'
    model: User
