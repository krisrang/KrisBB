define (require) ->
  "use strict";
  return {
    message : require('tpl!templates/message.tmpl')
    send    : require('tpl!templates/send.tmpl')
  }
