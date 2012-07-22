namespace :messages do
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
end

namespace :users do
  desc "Make sure all users have necessary generated values"
  task :upgrade => :environment do
    Mongoid.unit_of_work(disable: :all) do
      User.all.each do |m|
        user.upgrade_user
      end
    end
  end
end