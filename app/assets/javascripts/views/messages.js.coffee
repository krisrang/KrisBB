define ['marionette', 'templates', 'views/message', 'collections/messages'],
  (Marionette, templates, MessageView, Messages) ->
    "use strict";

    emptyView = Backbone.Marionette.ItemView.extend
      template: templates.messages_empty

    return Marionette.CollectionView.extend
      itemView: MessageView
      emptyView: emptyView
      collection: Messages
