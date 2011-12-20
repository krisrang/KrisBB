require 'status_cats'
use StatusCats, except: 200...300

require ::File.expand_path('../config/environment',  __FILE__)
run Kreubb::Application
