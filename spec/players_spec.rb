require 'spec_helper'

describe Player do
  it 'initializes an instance of Player and returns the characteristics' do
    player = Player.new({name: 'Ramsey', number: 16, team: 'Arsenal'})
    expect(player).to be_an_instance_of Player
    expect(player.name).to eq 'Ramsey'
    expect(player.team).to eq 'Arsenal'
    expect(player.number).to eq 16
  end

  it 'starts with an empty array' do
    expect(Player.all).to eq []
  end
  
  it 'adds players to the table' do
    player = Player.new({name: 'Ramsey', number: 16, team: 'Arsenal'})
    player.save
    expect(Player.all).to eq [player]
  end   
  it 'makes similar objects the same' do
    player1 = Player.new({name: 'Gerard', number: 8, team: 'Liverpool'})
    player2 = Player.new({name: 'Gerard', number: 8, team: 'Liverpool'})
    player1.save
    player2.save
    expect(player1).to eq player2
  end

end