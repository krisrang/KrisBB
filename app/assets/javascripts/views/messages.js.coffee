define ['jquery', 'marionette', 'templates', 'views/message',
        'collections/messages', 'collections/users', 'models/user',
        'vent',],
  ($, Marionette, templates, MessageView, Messages, Users, User, vent) ->
    "use strict";

    if window.KrisBBsetup?.messages?
      Messages.reset(window.KrisBBsetup.messages)
    else
      Messages.fetch()

    vent.bind 'pusher:message', (message) ->
      Messages.add([message])

    vent.bind 'pusher:user', (user) ->
      model = User.findOrCreate(user["_id"])
      if model?
        model.set user

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
