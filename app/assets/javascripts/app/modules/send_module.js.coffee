class SendMessageModule
  constructor: () ->
    @el = "#send-message"
    @addHandlers()

  addHandlers: () ->
    app.events.on 'app-loaded',   @loaded

  loaded: () =>
    app.log "Loading SendMessageModule"
    @render()

  render: () =>
    @$el = $(@el)
    @textarea = $('textarea', @$el)
    $('#push-message').click @send

  send: (e) =>
    e.preventDefault()
    message = @textarea.val()
    app.events.trigger 'send-message', message

new SendMessageModule()