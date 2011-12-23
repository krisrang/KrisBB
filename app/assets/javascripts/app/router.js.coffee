class App.Router extends Backbone.Router
  routes:
    "":                 "messages"

  initialize: ->
    @collection = new App.Collections.Messages window.messages
    @user = new App.Models.User window.user
    @view = new App.Views.MessagesView user: @user, collection: @collection
    
  messages: ->
    log 'action: messages'
    @view.render()