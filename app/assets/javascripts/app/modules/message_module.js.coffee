class Message extends Backbone.Model
  #defaults:
  #  loaded: 0
  #  created_at: new Date().getTime()

  url: =>
    return "/messages/" + (if @isNew() then '' else @id)

class Messages extends Backbone.Collection
  url: '/messages'
  model: Message

class MessagesModule
  resizeTimer: null

  constructor: () ->
    @el = ".messages"
    @collection = new Messages()
    @addHandlers()

  addHandlers: () ->
    app.events.on 'app-loaded',   @loaded
    app.events.on 'send-message', @sendMessage
    app.events.on 'message',      @message

  loaded: () =>
    app.log "Loading MessagesModule"
    @render()

  render: () =>
    @$el = $(@el)
    @scrollBottom()

    $(window).resize () =>
      clearTimeout(@resizeTimer)
      @resizeTimer = setTimeout(@scrollBottom, 100)

  scrollBottom: () =>
    @$el.scrollTop @$el[0].scrollHeight

  sendMessage: (message) =>
    @collection.create text: message

  message: (message) =>
    msg = app.template 'message'


new MessagesModule()