"use strict";

window.KrisBB.views.message = Backbone.Marionette.ItemView.extend
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

window.KrisBB.views.emptyMessage = KrisBB.views.message.extend
  template: JST["messages_empty"]
  className: 'user1'
  attributes: {}
