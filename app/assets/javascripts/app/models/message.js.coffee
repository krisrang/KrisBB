class App.Models.Message extends Backbone.Model
  #defaults:
  #  loaded: 0
  #  created_at: new Date().getTime()

  created_at: =>
    Date.parse(@get('created_at'))

  updated_at: =>
    Date.parse(@get('updated_at'))
 
  url: =>
    return "/messages/" + (if @isNew() then '' else @id)

class App.Collections.Messages extends Backbone.Collection
  url: '/messages'
  model: App.Models.Message
  page: 1

  fetchNextPage: (options)=>
    params = _.extend
      add:         true
      data: {page: @page+1}
    , options

    params.complete = (xhr)=>
      @page = @page+1
      last = xhr.responseText == "[]"
      options.complete(last)

    @fetch params
