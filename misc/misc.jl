# As a first example, let’s imagine playing a lottery game.
# The idea is simple — pick six unique numbers between 1 and 50. Each ticket costs, say, £2.
#
#     If you match all six numbers to those drawn, you win a large prize (£1,000,000)
#     If you match five numbers, you win a medium prize (£100,000)
#     If you match four numbers, you win a small prize (£100)
#     If you match three numbers, you win a very small prize (£10)
#
# What would you expect to win if you played this lottery every day for twenty years?
@everywhere using StatsBase

@everywhere function draw()
    sample(1:50, 6, replace = false)
end

@everywhere function game()
    answer = draw()
    ticket = draw()

    matches = 0

    for i = ticket
        if i in answer
            matches += 1
        end
    end

    if matches == 6
        return 1000000
    elseif matches == 5
        return 100000
    elseif matches == 4
        return 100
    elseif matches == 3
        return 10
    end

    return 0
end

max = 10000000

ans = @parallel (+) for i = 1:max
    game() - 2
end

println(ans/max)
