require ['jquery', 'marionette', 'krisbb', 'common'],
  ($, Marionette, KrisBB) ->
    Backbone.Marionette.TemplateCache.prototype.loadTemplate = (templateId) ->
      template = templateId

      if (!template || template.length == 0)
          msg = "Could not find template: '" + templateId + "'"
          err = new Error(msg)
          err.name = "NoTemplateError"
          throw err

      return template

    $ ->
      KrisBB.start window.settings, window.user
