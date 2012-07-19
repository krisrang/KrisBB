desc "Reprocess all messages to update html"
task :reprocess => :environment do
  Mongoid.unit_of_work(disable: :all) do
    Message.all.each do |m|
      puts "Processing " + m.id.to_s
      m.text = m.text
      m.save
    end
  end
end