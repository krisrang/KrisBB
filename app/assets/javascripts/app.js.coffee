require ['marionette', 'krisbb', 'routers/bb', 'controllers/bb', 'common'],
  (Marionette, KrisBB, Router, Controller) ->
    "use strict";

    Backbone.Marionette.Renderer.render = (template, data) ->
      return template(data)

    new Router
      controller: Controller

    KrisBB.start window.settings, window.user
