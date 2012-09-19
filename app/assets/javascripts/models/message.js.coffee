'use strict';

class Message extends Backbone.RelationalModel
  relations: [{
    type: Backbone.HasOne,
    key: 'user',
    relatedModel: KrisBB.models.User,
    collectionType: KrisBB.collections.Users,
    reverseRelation: {
        key: 'messages',
        includeInJSON: false
    }
  }]

  idAttribute: '_id'
  defaults:
    created_at: new Date().toISOString()

  url: ->
    return "/messages/" + (if @isNew() then '' else @id)

Message.setup()
window.KrisBB.models.Message = Message
