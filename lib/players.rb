class Player
  
  attr_accessor :name, :number, :team
  
  def initialize(attributes)
    @name = attributes[:name]
    @number = attributes[:number].to_i
    @team = attributes[:team]
  end
  
end