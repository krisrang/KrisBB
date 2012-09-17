define ["backbone", "relational"], (Backbone) ->
  'use strict';

  return Backbone.RelationalModel.extend
    idAttribute: '_id'

    deleted: ->
      @get('deleted')

    url: ->
      return "/users/" + (if @isNew() then '' else @id)
