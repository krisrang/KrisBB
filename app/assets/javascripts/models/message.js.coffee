define ["backbone"], (Backbone) ->
  'use strict';

  return Backbone.Model.extend
    idAttribute: '_id'
    defaults:
      created_at: new Date().getTime()

    url: ->
      return "/messages/" + (if @isNew() then '' else @id)
