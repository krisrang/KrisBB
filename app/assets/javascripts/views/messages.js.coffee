"use strict";

if window.KrisBBsetup?.messages?
  KrisBB.collections.Messages.reset(window.KrisBBsetup.messages)
else
  KrisBB.collections.Messages.fetch()

KrisBB.vent.bind 'pusher:message', (message) ->
  KrisBB.collections.Messages.add([message])

KrisBB.vent.bind 'pusher:user', (user) ->
  model = KrisBB.models.User.findOrCreate(user["_id"])
  if model?
    model.set user

window.KrisBB.views.messages = Backbone.Marionette.CollectionView.extend
  itemView: KrisBB.views.message
  emptyView: KrisBB.views.emptyMessage
  collection: KrisBB.collections.Messages
  tagName: 'ul'
  className: 'unstyled messages bb'

  resizeTimer: null

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
