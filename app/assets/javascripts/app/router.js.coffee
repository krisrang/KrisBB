class App.Router extends Backbone.Router
  routes:
    "":                 "messages"

  initialize: ->
    @messages = new App.Collections.Messages()
    #@users = new UsersCollection()

    #@user = new User(window.user)
    #@uploaderView = new UploaderView user: @user, uploader: @uploader, collection: @uploads

    #@uploaderView.render()
    
  messages: ->
    log 'action: messages'