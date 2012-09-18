define ["backbone", "models/message"], (Backbone, Message) ->
  'use strict';

  class MessagesCollection extends Backbone.Collection
    url: '/messages'
    model: Message

    comparator: (message) ->
      message.get('created_at')

  return MessagesCollection
