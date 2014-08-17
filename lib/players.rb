class Player
  
  attr_accessor :name, :number, :team
  
  def initialize(attributes)
    @name = attributes[:name]
    @number = attributes[:number].to_i
    @team = attributes[:team]
  end
  
  def self.all
    @players = []
    results = DB.exec("SELECT * FROM players;")
    results.each do |result|
      @players << Player.new({name: result['name'], number: result['number'], team: result['team']})
    end
    @players
  end
  
  def save
    DB.exec("INSERT INTO players (name, number, team) VALUES ('#{@name}','#{@number}','#{@team}');")
  end
  
  def ==(another_player)
    self.name == another_player.name && self.number == another_player.number  
  end  
  
end