define ['marionette', 'templates'], (Marionette, templates) ->
  "use strict";

  return Marionette.ItemView.extend
    template: templates.send

    ui:
      input   : '#message_text'
      toggle  : '#send-message-enter'

    events:
      'keypress #message_text'    : 'onInputKeypress'
      'change #send-message-enter': 'onToggleChange'

    onToggleChange: (e) ->
      console.log(this.ui.toggle.prop('checked'))

    onInputKeypress: (e) ->
      ENTER_KEY = 13
      text = this.ui.input.val().trim()

      if e.which == ENTER_KEY && text
        console.log(text)

        this.ui.input.val('')
