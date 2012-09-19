"use strict";

window.KrisBB.Views.Message = Backbone.Marionette.ItemView.extend
  template: JST["templates/message"]
  tagName: 'li'

  initialize: ->
    @bindTo @model, 'change', @render

  attributes: ->
    {
      id: 'message-' + @model.cid
      class: 'message user' + @model.get('user').get('colour')
    }

  onRender: ->
    $('time.timeago', @$el).timeago()

window.KrisBB.Views.EmptyMessage = KrisBB.Views.Message.extend
  template: JST["templates/messages_empty"]
  className: 'user1'
  attributes: {}
