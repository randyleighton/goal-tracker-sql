require 'pg'

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
  
  def ==(another_player)
    self.name == another_player.name && self.number == another_player.number  
  end  
  
end