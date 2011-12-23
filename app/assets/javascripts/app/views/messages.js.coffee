class App.Views.MessagesView extends Backbone.View
  rendered: false
  scrolling: false
  last: false
  views: {}

  events:
    'click .message-pager':   'processScroll'
    'click .cancel-message':  'cancelMessage'
    'click .post-message':    'postMessage'

  initialize: ->
    @el = $('body')
    @list = $('.message-list')
    @loader = $('.message-loader')
    @pager = $('.message-pager')
    @messageModal = $('#message-modal')
    @messageText = $('#messageform textarea')

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
    @loader.hide()
    @pager.show()
    @rendered = true
    @scrolling = false

  add: (model)=>
    if !@views[model.cid]?
      view = new App.Views.MessageView model: model
      @list.append view.render()
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
    message = @collection.create text: text, 
      silent: true
      success: (model)=>
        view = new App.Views.MessageView model: model
        @list.prepend view.render()
        @views[model.cid] = view
        @cancelMessage()

  cancelMessage: =>
    @messageModal.modal('hide')
