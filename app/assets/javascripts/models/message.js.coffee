'use strict';

class Message extends Backbone.RelationalModel
  relations: [{
    type: Backbone.HasOne,
    key: 'user',
    relatedModel: KrisBB.Models.User,
    collectionType: KrisBB.Collections.Users,
    reverseRelation: {
        key: 'messages',
        includeInJSON: false
    }
  }]

  idAttribute: '_id'

  url: ->
    return "/messages/" + (if @isNew() then '' else @id)

Message.setup()
window.KrisBB.Models.Message = Message
