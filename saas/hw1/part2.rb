class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def bad_strategy(strategy)
  result = strategy.downcase =~ /(\b[r]\b|\b[p]\b|\b[s]\b)/
  return result.nil?
end

# Possible game combinations
# S > P
# P > R
# R > S

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  p1_strategy = game[0][1]
  p2_strategy = game[1][1]
  
  if bad_strategy(p1_strategy) || bad_strategy(p2_strategy)
    raise NoSuchStrategyError
  end

  rps_rules = { ["S","P"] => 0, ["P","S"] => 1, ["P","R"] => 0, ["R","P"] =>1, ["R","S"] => 0, ["S", "R"] => 1}
  
  winner = -1
  if p1_strategy == p2_strategy
    winner = 0
  elsif
    key = [p1_strategy, p2_strategy]
    winner = rps_rules[key]
  end
  
  return game[winner]
end

def rps_tournament_winner(tournament)
  # Base case: the first element in the list is a player (String)
  if tournament[0][0].instance_of? String
    return rps_game_winner(tournament)
  end
  
  winners = []
  tournament.each do |round|
    winner = rps_tournament_winner(round)
    winners.push(winner)
  end
  
  return rps_game_winner(winners)
end

# game = [ ["Armando", "P"], ["Dave", "S"] ]
# p rps_game_winner(game)
# 
# game = [ ["Richard", "R"], ["Michael", "S"] ]
# p rps_game_winner(game)
# 
# game = [ ["Richard", "S"], ["Michael", "S"] ]
# p rps_game_winner(game)
# 
# game = [ ["Richard", "R"], ["Michael", "R"] ]
# p rps_game_winner(game)


# tournament = [
#   [ 
#     [ ["Armando", "P"], ["Dave", "S"] ],
#     [ ["Richard", "R"], ["Michael", "S"] ],
#   ],
#   [ 
#     [ ["Allen", "S"], ["Omer", "P"] ],
#     [ ["David E.", "R"], ["Richard X.", "P"] ]
#   ]
# ]
# 
# p "Tournament winner:", rps_tournament_winner(tournament)