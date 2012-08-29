define ["backbone"], (Backbone) ->
  'use strict';

  return Backbone.Model.extend
    idAttribute: 'uuid'
    defaults:
      data: {}

    url: ->
      return "/users/" + (if @isNew() then '' else @id)
