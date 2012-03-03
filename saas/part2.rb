class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def bad_strategy(strategy)
  result = strategy.downcase =~ /(\b[r]\b|\b[p]\b|\b[s]\b)/
  return result.nil?
end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  # check for errors in strategy
  strategy1 = game[0][1]
  strategy2 = game[1][1]
  
  if bad_strategy(strategy1) || bad_strategy(strategy2)
    raise NoSuchStrategyError
  end
  
  # <=> returns 0 if equal, -1 if lhs is less than, 1 if rhs is smaller
  winner = strategy1.casecmp strategy2
  return game[winner]
end


# game = [ [ "Armando", "a" ], [ "Dave", "b" ] ]
# 
# print rps_game_winner(game)