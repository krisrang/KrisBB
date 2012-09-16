define ["backbone", "models/message", 'vent'], (Backbone, Message, vent) ->
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

  vent.bind 'pusher:message', (message) ->
    collection.add([message])

  return collection
