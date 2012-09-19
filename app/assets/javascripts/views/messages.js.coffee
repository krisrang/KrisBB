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

    if KrisBB.bootstrap?
      @collection.reset(KrisBB.bootstrap)
    else
      @collection.fetch()

  onRender: () ->
    @scrollToBottom()

    $(window).resize () =>
      @scrollToBottom()

  onItemAdded: () ->
    setTimeout(@doScrollBottom, 0) # No idea why this is necessary

  scrollToBottom: () ->
    clearTimeout(@resizeTimer)
    @resizeTimer = setTimeout(@doScrollBottom, 100)

  doScrollBottom: ->
    $(window).scrollTop $('body')[0].scrollHeight
