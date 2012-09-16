define ['marionette', 'templates', 'collections/messages', 'store', 'channel'],
  (Marionette, templates, Messages, Store, Pusher) ->
    "use strict";

    return class SendView extends Marionette.ItemView
      template: templates.send
      className: 'send-message span12'
      sendOnEnter: false
      ENTER_KEY: 13

      ui:
        input   : '#message_text'
        toggle  : '#send-message-enter'

      events:
        'keypress #message_text'    : 'onInputKeypress'
        'change #send-message-enter': 'onToggleChange'
        'click .message-submit'     : 'onClickSend'

      onShow: ->
        @sendOnEnter = Store.get('sendOnEnter')
        @ui.toggle.prop('checked', @sendOnEnter)

      onToggleChange: (e) ->
        @sendOnEnter = @ui.toggle.prop('checked')
        Store.set('sendOnEnter', @sendOnEnter)

      onInputKeypress: (e) ->
        if @sendOnEnter && e.which == @ENTER_KEY && !e.shiftKey
          @sendMessage()

      onClickSend: (e) ->
        @sendMessage()

      sendMessage: ->
        if text = @ui.input.val().trim()
          Messages.create text: text, socketid: Pusher.connection.socket_id,
            wait: true,
            success: (col, response) =>
              @ui.input.val('')
