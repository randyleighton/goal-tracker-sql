require 'spec_helper'

describe Game do
  it 'initializes an instance of Game and returns the characteristics' do
    game = Game.new({:game_date => '2014-08-06'})
    expect(game).to be_an_instance_of Game
    expect(game.game_date).to eq '2014-08-06'
  end
  
  it 'starts with an empty array' do
    expect(Game.all).to eq []
  end
  
  it 'adds games to the database table' do
    game = Game.new({:game_date => '2014-08-06'})
    game.save
    expect(Game.all).to eq [game]
  end
  
  it 'makes similar objects the same' do
    game1 = Game.new({:game_date => '2014-08-06'})
    game2 = Game.new({:game_date => '2014-08-06'})
    expect(game1).to eq game2
  end
  
  it 'finds a game' do
    game1 = Game.new({:game_date => '2014-08-06'})
    game1.save
    expect(Game.find(game1.id)).to eq game1
  end  
  
end