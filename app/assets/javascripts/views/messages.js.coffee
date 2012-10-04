"use strict";

window.KrisBB.Views.Messages = Backbone.Marionette.CollectionView.extend
  itemView: KrisBB.Views.Message
  emptyView: KrisBB.Views.EmptyMessage
  collection: KrisBB.Collections.Messages
  tagName: 'ul'
  className: 'unstyled messages bb'

  resizeTimer: null

  initialize: ->
    KrisBB.Vent.bind 'pusher:message', (message) =>
      @collection.add([message])
      @notify message

    KrisBB.Vent.bind 'pusher:delete', (id) =>
      model = @collection.get(id)
      if model?
        @collection.remove(model)

    if KrisBB.bootstrap?
      @collection.reset(KrisBB.bootstrap)
    else
      @collection.fetch()

  onRender: () ->
    @scrollToBottom()

    $(window).resize () =>
      @scrollToBottom()

  onItemAdded: (item) ->
    setTimeout(@doScrollBottom, 0) # No idea why this is necessary

  scrollToBottom: () ->
    clearTimeout(@resizeTimer)
    @resizeTimer = setTimeout(@doScrollBottom, 100)

  doScrollBottom: ->
    $(window).scrollTop $('body')[0].scrollHeight

  notify: (message) ->
    if !!window.webkitNotifications && 
      window.webkitNotifications.checkPermission() == 0 &&
      !document.hasFocus()
      
        icon = message.user.avatar.thumb.url
        title = "New message"
        body = $('<div>'+message.text+'</div>').text()
        popup = window.webkitNotifications.createNotification(icon, title, body);
        popup.show()
        
        popup.onclick = () ->
          window.focus()
          @cancel()

        setTimeout () ->
          popup.cancel()
        , 10000

        return true
