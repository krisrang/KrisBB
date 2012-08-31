define ["backbone", "models/message"], (Backbone, Message) ->
  'use strict';

  collection = Backbone.Collection.extend
    url: '/messages'
    model: Message

    comparator: (message) ->
      message.get('created_at')

  model = new collection()
  #model.fetch()
  model.reset(window.KrisBBsetup.messages)

  return model
