"use strict";

window.KrisBB.Views.Message = Backbone.Marionette.ItemView.extend
  template: JST["templates/message"]
  tagName: 'li'

  events:
    'click .delete-message'     : 'onClickDelete'

  initialize: ->
    @bindTo @model, 'change', @render

  attributes: ->
    {
      id: 'message-' + @model.cid
      class: 'message user' + @model.get('user').get('colour')
    }

  onRender: ->
    $('time.timeago', @$el).timeago()

  onClickDelete: (e) ->
    e.preventDefault()

    if confirm("Are you sure?")
      @model.destroy()


window.KrisBB.Views.EmptyMessage = KrisBB.Views.Message.extend
  template: JST["templates/messages_empty"]
  className: 'user1 empty'
  attributes: {}
