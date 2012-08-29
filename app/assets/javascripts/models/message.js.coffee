define ["backbone"], (Backbone) ->
  'use strict';

  return Backbone.Model.extend
    idAttribute: 'uuid'
    #defaults:
    #  loaded: 0
    #  created_at: new Date().getTime()

    url: ->
      return "/messages/" + (if @isNew() then '' else @id)
