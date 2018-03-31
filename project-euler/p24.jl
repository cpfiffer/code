using Combinatorics

vals = [0,1,2,3,4,5,6,7,8,9]

z = collect(permutations(vals, 10))

function vecnum(x::Array{Int64, 1})
    answer = 0
    len = length(x)

    for i = 1:len
        index = len - i + 1
        answer += x[index] * (10^(i-1))
    end

    return answer
end

vecnum(z[100000])

vecs = sort(map(vecnum, z))

vecs[1000000]
