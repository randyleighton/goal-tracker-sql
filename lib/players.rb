require 'pg'
require 'pry'

class Player
  
  attr_accessor :name, :number, :team, :id
  
  def initialize(attributes)
    @name = attributes[:name]
    @number = attributes[:number].to_i
    @team = attributes[:team]
    @id = attributes[:id].to_i
  end
  
  def self.all
    @players = []
    results = DB.exec("SELECT * FROM players;")
    results.each do |result|
      @players << Player.new({id: result['id'].to_i, name: result['name'], number: result['number'], team: result['team']})
    end
    @players
  end
  
  def self.find(search_id)
    result = DB.exec("SELECT * FROM players WHERE id = #{search_id};")[0]
    Player.new({id: result['id'].to_i, name: result['name'], number: result['number'].to_i, team: result['team']})
  end
 
  def save
    result = DB.exec("INSERT INTO players (name, number, team) VALUES ('#{@name}','#{@number}','#{@team}') RETURNING id;")
    @id = result.first['id'].to_i
  end
  
  def add_goal(game_id)
    DB.exec("INSERT INTO goals (game_id, player_id) VALUES (#{game_id}, #{@id});")
  end

  def get_goals
    @goals = []
    results = DB.exec("SELECT games.* FROM players JOIN goals ON (goals.player_id = players.id)
                       JOIN games ON (goals.game_id = games.id) WHERE players.id = #{@id}")
    results.each do |result|
      @goals << Game.new({:id =>result['id'].to_i, :game_date=> result['game_date'],})
    end
    @goals
  end
  
  def ==(another_player)
    self.name == another_player.name && self.number == another_player.number  
  end  
  
end