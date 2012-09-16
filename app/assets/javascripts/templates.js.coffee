define (require) ->
  "use strict";
  return {
    messages_empty  : require('tpl!templates/messages_empty.tmpl')
    message         : require('tpl!templates/message.tmpl')
    send            : require('tpl!templates/send.tmpl')
  }
