class User extends Backbone.Model
  idAttribute: 'uuid'
  defaults:
    data: {}

  url: =>
    return "/users/" + (if @isNew() then '' else @id)

class Users extends Backbone.Collection
  url: '/users'
  model: User

class UsersModule
  constructor: () ->
    @el = "#sidebar"
    @collection = new Users()
    @addHandlers()

  addHandlers: () ->
    @collection.bind 'add',     @added
    @collection.bind 'remove',  @removed

    app.events.on 'app-loaded', @loaded
    app.events.on 'connect',    @connect
    app.events.on 'join',       @joined
    app.events.on 'leave',      @left

  loaded: () =>
    app.log "Loading UsersModule"
    @render()

    @currentUser = new User data: app.userInfo, uuid: 'local'
    @collection.add @currentUser

  render: () =>
    @$el = $ @el

  connect: () =>
    @$el.addClass('connected')
    @title = $ '.usercount', @$el
    @list = $ '.users', @$el
    @updateList()

  added: (user) =>
    @updateCount()
    @list.append app.template('user', model: user)

  removed: (user) =>
    @updateCount()
    $('#user-' + user.get('data').id, @list).remove()

  joined: (user) =>
    @collection.add new User(user)

  left: (user) =>
    @collection.remove user.uuid

  updateCount: () =>
    @title.text "Users (" + @collection.length + ")"

  updateList: () =>
    @updateCount()

    userlist = ""
    @collection.each (item) =>
      userlist += app.template 'user', model: item

    @list.html userlist


new UsersModule()