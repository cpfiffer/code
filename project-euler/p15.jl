function lattice(x, y)
    graph = ones(Array{Int64}(x,y))

    for i = 1:x
        for j = 1:y
            if i == 1 || j == 1
                # Skip it.
            else
                node1 = 0
                node2 = 0

                try node1 = graph[i - 1, j] end
                try node2 = graph[i, j - 1] end

                graph[i,j] = node1 + node2
            end
        end
    end

    return graph[end, end]
end

@time lattice(21,21)


# P 16

function sum_digits(x)
    total = 0
    for i = 1:length(x)
        total += parse(Int64, x[i])
    end
    return total
end

sum_digits(string(BigInt(2) ^ 1000))
