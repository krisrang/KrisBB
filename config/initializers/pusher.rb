if Settings.public.pusher.app_id
  Pusher.app_id = Settings.public.pusher.app_id
  Pusher.key    = Settings.public.pusher.key
  Pusher.secret = Settings.pusher.secret
end
