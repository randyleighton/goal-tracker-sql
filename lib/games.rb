require 'pg'

class Game
  
  attr_reader :game_date
  
  def initialize(attributes)
    @game_date = attributes[:game_date]
    
  end

  def self.all
    @games = []
    results = DB.exec("SELECT * FROM games;")
    results.each do |result|
      @games << Game.new({game_date: result['game_date']})
    end
    @games
  end
  
  def save
    DB.exec("INSERT INTO games (game_date) VALUES ('#{@game_date}');")
  end

  def ==(another_game)
    self.game_date == another_game.game_date
  end
  
end