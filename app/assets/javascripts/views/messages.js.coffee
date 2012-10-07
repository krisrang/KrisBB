"use strict";

window.KrisBB.Views.Messages = Backbone.Marionette.CollectionView.extend
  itemView: KrisBB.Views.Message
  emptyView: KrisBB.Views.EmptyMessage
  collection: KrisBB.Collections.Messages
  tagName: 'ul'
  className: 'unstyled messages bb'
  scrolledToBottom: false

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
    $(window).scroll () =>
      @onScroll()

    $(window).resize () =>
      @onResize()

    $ =>
      setTimeout(() =>
        @scrollToBottom()
      , 50)

  onItemAdded: (item) ->
    setTimeout(() =>
      @scrollToBottom()
    , 0)

  scrollToBottom: () ->
    @scrollTo(0, @getPageHeight() + @getWindowHeight() + 200)
    @scrolledToBottom = true

  scrollTo: (left, top) ->
    window.scrollTo(left, top)

  onScroll: (event) ->
    @scrolledToBottom = @isScrolledToBottom()

  onResize: (event) ->
    if @scrolledToBottom && !@isScrolledToBottom()
      @scrollToBottom()

  isScrolledToBottom: () ->
    return @getScrollOffset() + @getWindowHeight() >=
      @getPageHeight()

  getPageHeight: () ->
    return Math.max(document.documentElement.offsetHeight,
      document.body.scrollHeight)

  getWindowHeight: () ->
    return window.innerHeight || document.body.clientHeight

  getScrollOffset: () ->
    return Math.max(document.documentElement.scrollTop,
      document.body.scrollTop)

  notify: (message) ->
    if !!window.webkitNotifications && 
      webkitNotifications.checkPermission() == 0 &&
      !document.hasFocus()
      
        icon = message.user.avatar.thumb.url
        title = "New message"
        body = $('<div>'+message.text+'</div>').text()
        popup = webkitNotifications.createNotification(icon, title, body)
        popup.show()
        
        popup.onclick = () ->
          window.focus()
          @cancel()

        setTimeout () ->
          popup.cancel()
        , 10000

        return true

