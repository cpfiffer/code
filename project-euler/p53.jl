@everywhere function combos(n::Int64, r::Int64 = 10)
    n = BigInt(n)
    r = BigInt(r)
    y = factorial(n) / (factorial(r) * factorial(n-r))
    #println(y > 1000000)
    return y > 1000000 ? 1 : 0
end

num = @parallel (+) for i = 1:100
    combos(i)
end

println(num)
