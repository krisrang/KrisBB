class App.Views.MessageView extends Backbone.View
  rendered: false

  events:
    'click .delete-link': 'clickDelete'

  initialize: ->
  
  render: =>
    tplHtml = JST['app/templates/message'](model: @model)
    @$el = @el = $(tplHtml)

    @delegateEvents()

    @el.hover ()=>
      @el.addClass 'hover'
    , ()=>
      @el.removeClass 'hover'
    
    return @el
  
  clickDelete: (e)=>
    e.preventDefault()
    if confirm("Delete message?")
      @model.destroy()
    return false