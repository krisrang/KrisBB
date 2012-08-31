define ["backbone", "models/message"], (Backbone, Message) ->
  'use strict';

  MessagesCollection = Backbone.Collection.extend
    url: '/messages'
    model: Message

    comparator: (message) ->
      message.get('created_at')

  collection = new MessagesCollection()

  if window.KrisBBsetup? && window.KrisBBsetup.messages?
    collection.reset(window.KrisBBsetup.messages)
  else
    collection.fetch()

  return collection
