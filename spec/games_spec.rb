require 'spec_helper'

describe Game do
  it 'initializes an instance of Game and returns the characteristics' do
    game = Game.new({:game_date => '2014-08-06'})
    expect(game).to be_an_instance_of Game
    expect(game.game_date).to eq '2014-08-06'
  end
end