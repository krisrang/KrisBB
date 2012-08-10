class SocketModule
  constructor: () ->
    @addHandlers()

  addHandlers: () ->
    app.events.on 'app-loaded',     @connect
    #app.events.on 'send-message',  @sendMessage

  connect: () =>
    #app.socket = @socket = io.connect 'http://pubsub.pubnub.com', pubnub_setup
    #@addSocketHandlers()

  #sendMessage: (message) =>
  #  @socket.emit 'message',
  #    contents: message,
  #    user: app.userInfo

  addSocketHandlers: () =>
    @socket.on 'connect',     @connected
    @socket.on 'join',        @joined
    @socket.on 'leave',       @left
    @socket.on 'message',     @message
    @socket.on 'disconnect',  @disconnect

  connected: () =>
    app.log "Connected to pubnub"
    app.events.trigger 'connect', @usersInfo()

  usersInfo: () ->
    users: @socket.get_user_list(),
    count: @socket.get_user_count()

  joined: (user) =>
    app.log "Joined: "
    app.log user
    app.events.trigger 'join', user

  left: (user) =>
    app.log "Left: "
    app.log user
    app.events.trigger 'leave', user

  message: (message) =>
    app.log "message"
    app.events.trigger 'message', message


new SocketModule()