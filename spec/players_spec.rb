require 'spec_helper'

describe Player do
  it 'initializes an instance of Player and returns the characteristics' do
    player = Player.new({name: 'Ramsey', number: 16, team: 'Arsenal'})
    expect(player).to be_an_instance_of Player
    expect(player.name).to eq 'Ramsey'
    expect(player.team).to eq 'Arsenal'
    expect(player.number).to eq 16
  end

end