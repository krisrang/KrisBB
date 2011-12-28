class App.Views.MessagesView extends Backbone.View
  rendered: false
  scrolling: false
  last: false
  pusher: null
  channel: null
  views: {}
  newMessages: []

  events:
    'click .message-pager':   'processScroll'
    'click .cancel-message':  'cancelMessage'
    'click .post-message':    'postMessage'
    'click .waiting-item':    'processNewMessages'

  initialize: ->
    @el = $('body')
    @list = $('.message-list')
    @loader = $('.message-loader')
    @pager = $('.message-pager')
    @messageModal = $('#message-modal')
    @messageText = $('#messageform textarea')
    @waitingItem = $('.waiting-item')

    @user = @options.user

    @collection.bind 'add', @add
    @collection.bind 'remove', @remove
    @collection.bind 'destroy', @remove
    @collection.bind 'reset', @reset
      
  render: =>
    if !@rendered
      @loader.show()
      @pager.hide()

      @delegateEvents()
      @messageModal.bind 'hide', ()=>
        @messageText.val ""

      @load()
      #$(window).scroll @processScroll

  load: =>
    @collection.each @add
    @setupPusher()

    @loader.hide()
    @pager.show()

    @rendered = true
    @scrolling = false

  add: (model)=>
    if !@views[model.cid]?
      view = new App.Views.MessageView model: model

      if !@rendered or @scrolling
        @list.append view.render()
      else
        @list.prepend view.render()

      @views[model.cid] = view

  remove: (model)=>
    view = @views[model.cid]

    if view?
      delete @views[model.cid]
      view.el.fadeOut 'fast', ()=>
        view.remove()

  reset: (collection)=>
    @loader.show()

    @views = {}
    @list.empty()

    if collection.length > 0
      collection.each @add

    @loader.hide()

  setupPusher: =>
    @pusher = new Pusher '6b7a73dad4f1f3333653'
    @channel = @pusher.subscribe 'messages_channel'
    @channel.bind 'new_message', @processMessage

  processMessage: (message)=>
    msg = new @collection.model(message)

    if message.user_id == @user.id
      @collection.add msg
    else
      @newMessages.push msg
      newText = "#{@newMessages.length} new message"
      newText += "s" if @newMessages.length > 1
      @waitingItem.text newText
      document.title = "(#{@newMessages.length}) KrisBB"
      @waitingItem.show()

  processNewMessages: =>
    @waitingItem.hide()
    @collection.add @newMessages
    @newMessages = []
    document.title = "KrisBB"

  processScroll: =>
    #if ($(window).scrollTop() >= $(document).height() - $(window).height()) and @rendered == true and @scrolling == false
    unless @last
      @scrolling = true
      @pager.hide()
      @loader.show()
      @collection.fetchNextPage complete: (last)=>
        if last
          @last = true
          @pager.addClass "disabled"
        
        @pager.show()
        @loader.hide()
        @scrolling = false

  postMessage: =>
    text = @messageText.val()
    if text? && text.length > 0
      message = @collection.create text: text, socket_id: @pusher.connection.socket_id,
        success: =>
          @cancelMessage()

  cancelMessage: =>
    @messageModal.modal('hide')
