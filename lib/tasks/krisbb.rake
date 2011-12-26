namespace :bb do
  desc "Abort old cancelled multipart uploads"
  task :import => :environment do
    sync = Syncer.new "dvsbstd", "8chr05sa9"
    page = 1
    finished = false
    messages = []

    while !finished
      result = sync.messages page

      if result.length > 0
        messages += result
        page += 1
      else
        finished = true
      end
    end

    dvs = User.first
    brc = User.last

    messages.each do |m|
      message = Message.new
      message.user = m["user_id"] == 1 ? dvs : brc
      message.created_at = m["created_at"]
      message.updated_at = m["updated_at"]
      message.text = m["text"]

      p message
      message.save
    end
  end
end