'use strict';

class Messages extends Backbone.Collection
  url: '/messages'
  model: KrisBB.Models.Message

  comparator: (message) ->
    message.get('created_at')

window.KrisBB.Collections.Messages = new Messages()
