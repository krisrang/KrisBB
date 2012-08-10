define ["jquery", "underscore", "marionette"], ($, _, Marionette) ->
  # set up the app instance
  KrisBB = new Marionette.Application()

  # configuration, setting up regions, etc ...
  KrisBB.bind "initialize:after", (options) ->
  if Backbone.history
    Backbone.history.start()

  return KrisBB