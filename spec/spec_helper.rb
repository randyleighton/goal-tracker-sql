require 'rspec'
require 'pg'

require 'games'
require 'players'

DB = PG.connect({:dbname => 'goal_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM games *;")
    DB.exec("DELETE FROM goals *;")
    DB.exec("DELETE FROM players *;")
  end
end