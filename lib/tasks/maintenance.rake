desc "Reprocess all messages to update html"
task :reprocess => :environment do
  Message.all.each do |m|
    puts "Processing " + m.id.to_s
    m.text = m.text
    m.save
  end
end