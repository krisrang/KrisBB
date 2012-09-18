"use strict";

window.KrisBB.views.send = Backbone.Marionette.ItemView.extend
  template: JST["templates/send"]
  className: 'send-message span12'
  sendOnEnter: false
  ENTER_KEY: 13
  socket: 0

  ui:
    input   : '#message_text'
    toggle  : '#send-message-enter'

  events:
    'keypress #message_text'    : 'onInputKeypress'
    'change #send-message-enter': 'onToggleChange'
    'click .message-submit'     : 'onClickSend'

  initialize: ->
    KrisBB.vent.bind 'pusher:connected', (pusher) ->
      @socket = pusher.connection.socket_id

  onShow: ->
    @sendOnEnter = store.get('sendOnEnter')
    @ui.toggle.prop('checked', @sendOnEnter)

  onToggleChange: (e) ->
    @sendOnEnter = @ui.toggle.prop('checked')
    store.set('sendOnEnter', @sendOnEnter)

  onInputKeypress: (e) ->
    if @sendOnEnter && e.which == @ENTER_KEY && !e.shiftKey
      @sendMessage()

  onClickSend: (e) ->
    @sendMessage()

  sendMessage: ->
    if text = @ui.input.val().trim()
      KrisBB.collections.Messages.create text: text, socketid: @socket,
        wait: true,
        success: (col, response) =>
          @ui.input.val('')
