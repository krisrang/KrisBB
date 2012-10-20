namespace :messages do
  desc "Reprocess all messages to update html"
  task reprocess: :environment do
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
  task upgrade: :environment do
    Mongoid.unit_of_work(disable: :all) do
      User.all.each do |user|
        user.save
      end
    end
  end
end

namespace :cache do
  desc "Clear Rails cache"
  task clear: :environment do
    Rails.cache.clear
  end
end
