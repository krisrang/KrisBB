class App.Models.Message extends Backbone.Model
  defaults:
    loaded: 0
    created_at: new Date().getTime()
 
  url: =>
    return "/messages/" + (if @isNew() then '' else @id)

class App.Collections.Messages extends Backbone.Collection
  url: '/messages'
  model: App.Models.Message

  comparator: (model)->
    return -parseISO8601(model.get('created_at')).getTime()