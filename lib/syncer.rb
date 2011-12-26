class Syncer
  include HTTParty

  base_uri 'http://kreucedar.herokuapp.com/'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
  end

  def messages(page=1, options={})
    options.merge!({:basic_auth => @auth})
    self.class.get("/messages.json?page=#{page}", options)
  end
end