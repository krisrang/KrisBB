# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Kreubb::Application.initialize!

if FileTest.exist?(".rbenv-vars")
  begin
    env = File.open(".rbenv-vars", "rb")
    contents = env.read
    # parse content and retrieve variables from file
    lines = contents.gsub("export ", "").split(/\n\r?/).reject{|line| line.blank?}
    lines.each do |line|
      keyValue = line.split("=", 2)
      next unless keyValue.count == 2
      ENV[keyValue.first] = keyValue.last.gsub("'",'').gsub('"','')
    end
    # close file pointer
    env.close
  rescue => e
  end
end if Rails.env.production?
