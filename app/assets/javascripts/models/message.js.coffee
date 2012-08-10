class Message extends Backbone.Model
  #defaults:
  #  loaded: 0
  #  created_at: new Date().getTime()

  url: =>
    return "/messages/" + (if @isNew() then '' else @id)

class Messages extends Backbone.Collection
  url: '/messages'
  model: Message