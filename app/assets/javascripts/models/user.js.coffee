define ["backbone"], (Backbone) ->
  'use strict';

  return Backbone.Model.extend
    idAttribute: '_id'
    defaults:
      data: {}

    url: ->
      return "/users/" + (if @isNew() then '' else @id)
