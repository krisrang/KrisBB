class App.Models.User extends Backbone.Model
  #defaults:
  #  created_at: new Date().getTime()
  #  last_activity_at: new Date().getTime()

  admin: =>
    @get("admin")

  url: =>
    return "/users/" + (if @isNew() then '' else @id)

class App.Collections.Users extends Backbone.Collection
  url: '/users'
  model: App.Models.User

  comparator: (model)->
    return -parseISO8601(model.get('created_at')).getTime()