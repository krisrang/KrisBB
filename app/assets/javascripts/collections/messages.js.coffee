define ["backbone", "models/message", "setup"], (Backbone, Message, setup) ->
  'use strict';

  MessagesCollection = Backbone.Collection.extend
    url: '/messages'
    model: Message

    comparator: (message) ->
      message.get('created_at')

  collection = new MessagesCollection()
  #collection.fetch()
  if setup? && setup.messages?
    collection.reset(setup.messages)

  return collection
