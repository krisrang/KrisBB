require ['marionette', 'krisbb', 'routes', 'routers/bb', 'controllers/bb', 'common'],
  (Marionette, KrisBB, Routes, Router, Controller) ->
    "use strict";

    Backbone.Marionette.Renderer.render = (template, data) ->
      data.routes = Routes
      return template(data)

    new Router
      controller: Controller

    KrisBB.start window.settings, window.user
