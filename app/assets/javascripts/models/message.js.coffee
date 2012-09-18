define ["backbone", "relational", "models/user", "collections/users"], 
  (Backbone, Relational, User, Users) ->
    'use strict';

    class Message extends Backbone.RelationalModel
      relations: [{
        type: Backbone.HasOne,
        key: 'user',
        relatedModel: User,
        collectionType: Users
        reverseRelation: {
            key: 'messages'
        }
      }]

      idAttribute: '_id'
      defaults:
        created_at: new Date().toISOString()

      url: ->
        return "/messages/" + (if @isNew() then '' else @id)

    Message.setup()
    return Message
