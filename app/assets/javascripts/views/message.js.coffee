define ['jquery', 'marionette', 'templates'], ($, Marionette, templates) ->
  "use strict";

  return Marionette.ItemView.extend
    template: templates.message
    tagName: 'li'

    initialize: () ->
      @bindTo @model, 'change', @render

    attributes: () ->
      {
        id: 'message-' + @model.id
        class: 'user' + @model.get('user').colour
      }

    onRender: () ->
      $('time.timeago', @$el).timeago()
