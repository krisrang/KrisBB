class App.Views.MessageView extends Backbone.View
  rendered: false
  tpl: JST['app/templates/message']

  initialize: ->
  
  render: =>
    @el = $(@tpl(model: @model))

    @delegateEvents()
    
    return @el