require 'pg'
require './lib/games.rb'
require './lib/players.rb'

DB = PG.connect({:dbname => 'goal_tracker'})

# if DB puts "Connected to #{:dbname} Tracker Database"
# end

def  main_menu
  system("clear")
  choice = nil
  until choice  == 'x'
    puts "[== Main Menu==]"
    puts "(1) Add a game to the database"
    puts "(2) Add a player to the database"
    puts "    You must create players and Games to add or view goals"
    puts "(3) Add a goal to a player"
    puts "(4) View goals by Player (already added to player)"  
    puts "(5) View Game Dates"
    puts "(6) View Players"

    puts "(x) EXIT\n\n"
    choice = gets.chomp
    case choice
    when '1'
      add_game
    when '2'
      add_player
    when '3'
      add_goal
    when '4'
      view_goals
    when '5'
      view_games
    when '6'
      view_players
    when 'x'
      puts "keep watching soccer!"
    else 
      puts "Incorrect choice."
    end
  end
end

def add_player
  print "\n\nEnter a player's last name: "
  name_inp = gets.chomp
  print "\nEnter the player's number: "
  number_inp = gets.chomp.to_i
  print "\nEnter the player's team name: "  
  team_inp = gets.chomp
  Player.new({name: name_inp, number: number_inp, team: team_inp}).save
  current_p = Player.all.last
  puts "Player added. ##{current_p.number} #{current_p.name} - #{current_p.team}"
end

def add_game
  puts "\n\nEnter the date of the game in this format xxxx-xx-xx ie. 2014-08-17"
  choice = gets.chomp
  Game.new({game_date: choice}).save
  puts "Game added. #{Game.all.last.game_date}\n\n"
end


def view_players
  system("clear")
  puts "Players:"
  puts "(id) Name - Jersey# - Team Name"
  puts "---- --------------------------"
  Player.all.each do |player|
    puts "(#{player.id}) #{player.name} - #{player.number} - #{player.team}"
  end
end

def view_games
  system("clear")
  puts "Games:"
  puts "(id) Date"
  puts "---- --------"
  Game.all.each do |game|
    puts "(#{game.id}) #{game.game_date}"
  end 
end

def add_goal
  system("clear")
  view_players
  puts "choose a player id (#) to add a goal:"  
  player_inp = gets.chomp.to_i
  view_games
  puts "\n\nChoose the (#) of the game the player scored in: "
  game_inp = gets.chomp.to_i
  current_player = Player.find(player_inp)
  current_game = Game.find(game_inp)
  current_player.add_goal(current_game.id)
  puts "Players goal added to the record."  
  puts ""
end

def view_goals
  system("clear")
  view_players
  puts "choose a player id (#) to view their games with goals: "  
  player_inp = gets.chomp.to_i
  current_player = Player.find(player_inp)
  current_player.get_goals.each do |goals|
    puts "Game Date Goal scored: #{goals.game_date}"
  end
  puts "\n\n"
end




main_menu