define (require) ->
  "use strict";
  return {
    message         : require('tpl!templates/message.tmpl'),
    messages_empty  : require('tpl!templates/messages_empty.tmpl'),
    send            : require('tpl!templates/send.tmpl')
  }
