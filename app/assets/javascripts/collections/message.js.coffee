'use strict';

class Messages extends Backbone.Collection
  url: '/messages'
  model: KrisBB.models.Message

  comparator: (message) ->
    message.get('created_at')

window.KrisBB.collections.Messages = new Messages()
