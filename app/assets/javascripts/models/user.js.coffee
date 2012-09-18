define ["backbone", "relational"], (Backbone) ->
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
  return User
