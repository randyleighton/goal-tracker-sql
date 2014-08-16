require 'pg'

class Game
  
  attr_reader :game_date
  
  def initialize(attributes)
    @game_date = attributes[:game_date]
  end
  
end