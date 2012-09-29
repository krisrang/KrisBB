"use strict";

window.KrisBB.Views.Send = Backbone.Marionette.ItemView.extend
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
    KrisBB.Vent.bind 'pusher:connected', (pusher) =>
      @socket = pusher.connection.socket_id

  onShow: ->
    @sendOnEnter = store.get('sendOnEnter')
    @ui.toggle.prop('checked', @sendOnEnter)
    @ui.input.focus()
    @ui.input.autotype
      items: 15
      source: KrisBB.Smilies || []

  onToggleChange: (e) ->
    @sendOnEnter = @ui.toggle.prop('checked')
    store.set('sendOnEnter', @sendOnEnter)

  onInputKeypress: (e) ->
    if @sendOnEnter && e.which == @ENTER_KEY && !e.shiftKey
      e.preventDefault()
      @sendMessage()

  onClickSend: (e) ->
    e.preventDefault()
    @sendMessage()

  sendMessage: ->
    if text = @ui.input.val().trim()
      @ui.input.val('')
      @$el.addClass('sending')
      KrisBB.Collections.Messages.create text: text, socketid: @socket,
        wait: true,
        error: (messages, response) =>
          console.log(response)
          @$el.removeClass('sending')
        success: (messages, response) =>
          @$el.removeClass('sending')
