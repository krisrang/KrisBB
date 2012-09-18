define ['jquery', 'marionette', 'templates', 'views/message',
        'collections/messages', 'collections/users', 'models/user',
        'vent',],
  ($, Marionette, templates, MessageView, Messages, Users, User, vent) ->
    "use strict";

    messagesCollection = new Messages()

    if window.KrisBBsetup?.messages?
      messagesCollection.reset(window.KrisBBsetup.messages)
    else
      messagesCollection.fetch()

    vent.bind 'pusher:message', (message) ->
      messagesCollection.add([message])

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
      collection: messagesCollection
      tagName: 'ul'
      className: 'unstyled messages bb'

      resizeTimer: null

      onRender: () ->
        window.test = @collection
        window.test2 = Users
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
