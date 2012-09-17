define ["backbone", "relational", "models/user"], (Backbone, Relational, User) ->
  'use strict';

  return Backbone.RelationalModel.extend
    relations: [{
        type: Backbone.HasOne,
        key: 'user',
        relatedModel: User,
        collectionType: 'UserCollection'
    }]

    idAttribute: '_id'
    defaults:
      created_at: new Date().toISOString()

    url: ->
      return "/messages/" + (if @isNew() then '' else @id)
