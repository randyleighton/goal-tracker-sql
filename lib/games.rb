require 'pg'

class Game
  
  attr_reader :game_date, :id
  
  def initialize(attributes)
    @game_date = attributes[:game_date]
    @id = attributes[:id].to_i    
  end

  def self.all
    @games = []
    results = DB.exec("SELECT * FROM games;")
    results.each do |result|
      @games << Game.new({id: result['id'].to_i, game_date: result['game_date']})
    end
    @games
  end
  
  def save
    result = DB.exec("INSERT INTO games (game_date) VALUES ('#{@game_date}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.find(search_id)
    result = DB.exec("SELECT * FROM games WHERE id = #{search_id};")[0]
    Game.new({id: result['id'].to_i, game_date: result['game_date']})
  end
  
  def ==(another_game)
    self.game_date == another_game.game_date
  end
  
end