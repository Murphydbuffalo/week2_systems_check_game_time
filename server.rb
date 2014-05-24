require "CSV"
# require "sinatra"
# require "pry"

def get_games_csv
  games = []
  CSV.foreach("data.csv", headers: true, header_converters: :symbol) do |row|
    games << row.to_hash  
  end
  games
end
# [ {home_team: Pats, away_team: Broncos, home_score: 7, away_score: 3}, ]

def list_teams(games_played)
  teams = Hash.new(0)
  games_played.each do |game| 
    teams[game[:home_team]] = {wins: 0, losses: 0, ties: 0} 
    teams[game[:away_team]] = {wins: 0, losses: 0, ties: 0} 
  end
  teams
end

def tally_wins(games_played, teams)
  games_played.each do |game| 
    if game[:home_score] > game[:away_score]
      teams[game[:home_team]][:wins] += 1
      teams[game[:away_team]][:losses] += 1
    elsif game[:home_score] < game[:away_score]
      teams[game[:away_team]][:wins] += 1
      teams[game[:home_team]][:losses] += 1
    else
      teams[game[:home_team]][:ties] += 1
      teams[game[:away_team]][:ties] += 1
    end
  end
  teams
end

p tally_wins(get_games_csv, list_teams(get_games_csv))

# gets "/leaderboard" do
  
#   erb :index
# end

# gets "/" do
#   redirect "/leaderboard"
# end

# gets "/teams" do
#   redirect "/leaderboard"
# end

# gets "/teams/:team_name" do
#   redirect "/leaderboard"
# end

