define ["backbone", "models/message"], (Backbone, Message) ->
  'use strict';

  return Backbone.Collection.extend
    url: '/messages'
    model: Message
