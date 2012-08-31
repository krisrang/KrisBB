define ['jquery', 'marionette', 'templates', 'views/message', 'collections/messages'],
  ($, Marionette, templates, MessageView, Messages) ->
    "use strict";

    emptyView = MessageView.extend
      template: templates.messages_empty
      className: 'user1'
      attributes: {}

    Marionette.CollectionView.extend
      itemView: MessageView
      emptyView: emptyView
      collection: Messages
      tagName: 'ul'
      className: 'unstyled messages bb'

      resizeTimer: null

      onRender: () ->
        @scrollToBottom()

        $(window).resize () =>
          @scrollToBottom()

      onItemAdded: () ->
        @scrollToBottom()

      scrollToBottom: () ->
        clearTimeout(@resizeTimer)
        @resizeTimer = setTimeout(() ->
          $(window).scrollTop $('body')[0].scrollHeight
        , 100)
