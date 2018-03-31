# From Keith Wynroe, a battle for the tokens:
#
# You have one token, and I have two tokens. Naturally, we both crave more tokens, so we play a game of skill that unfolds over a number of rounds in which the winner of each round gets to steal one token from the loser. The game itself ends when one of us is out of tokens — that person loses. Suppose that you’re better than me at this game and that you win each round two-thirds of the time and lose one-third of the time.
#
# What is your probability of winning the game?

@everywhere function play_game()
    p1 = 2
    p2 = 1
    play = true
    while play
        prob = rand()
        if prob >= 2/3
            p2 = p2 + 1
            p1 = p1 -1
        else
            p2 = p2 - 1
            p1 = p1 +1
        end
        if p1 == 0 || p2 == 0
            play = false
        end
    end
    if p1 == 0
        return 0
    elseif p2 == 0
        return 1
    end
end

function play_games(times = 10000)
    num = 0
    num = @parallel (+) for i = 1:times
        play_game()
    end
    p1_ratio = num/times
    p2_ratio = 1-p1_ratio
    #println("Player 2 won $p2_ratio times out of $times rounds.")
end

function play_games_single(times = 10000)
    num = 0
    for i = 1:times
        num = num + play_game()
    end
    p1_ratio = num/times
    p2_ratio = 1-p1_ratio
    #println("Player 2 won $p2_ratio times out of $times rounds.")
end

println("=========Multi threaded=========")
tic()
play_games(100000000)
toc()

println("=========Single threaded=========")
tic()
play_games_single(100000000)
toc()
