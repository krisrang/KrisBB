define ["vent", "collections/messages"],
  (vent, Messages) ->
    pusher = new Pusher(KrisBBsetup.settings.pusher.key)

    vent.bind 'app:loaded', ->
      channel = pusher.subscribe('main')
      channel.bind 'message', (data) ->
        Messages.add([JSON.parse(data.message)])

    return pusher
