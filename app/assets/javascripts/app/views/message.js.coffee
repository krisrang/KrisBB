class App.Views.MessageView extends Backbone.View
  rendered: false
  tpl: JST['app/templates/message']

  events:
    'click .delete-link': 'clickDelete'

  initialize: ->
  
  render: =>
    @el = $(@tpl(model: @model))

    @delegateEvents()

    @el.hover ()=>
      @el.addClass 'hover'
    , ()=>
      @el.removeClass 'hover'
    
    return @el
  
  clickDelete: (e)=>
    e.preventDefault()
    @model.destroy()
    return false