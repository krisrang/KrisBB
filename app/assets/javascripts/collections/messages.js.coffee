define ["backbone", "models/message", "setup"], (Backbone, Message, setup) ->
  'use strict';

  collection = Backbone.Collection.extend
    url: '/messages'
    model: Message

    comparator: (message) ->
      message.get('created_at')

  model = new collection()
  model.reset(setup.messages)

  return model
