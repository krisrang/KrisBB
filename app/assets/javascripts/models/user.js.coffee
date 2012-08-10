class User extends Backbone.Model
  idAttribute: 'uuid'
  defaults:
    data: {}

  url: =>
    return "/users/" + (if @isNew() then '' else @id)

class Users extends Backbone.Collection
  url: '/users'
  model: User