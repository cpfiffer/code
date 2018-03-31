function divisors(x)
    answer = Vector{Int64}()
    for i = 1:round(x/2)
        if mod(x, i) == 0
            push!(answer, i)
        end
    end
    return answer
end

function abundant(x::Int64)
    divs = divisors(x)
    if sum(divs) > x return true else return false end
end

function abundant_list(max = 30000)
    answer = Vector{Int64}()
    for i = 1:max
        if abundant(i)
            push!(answer, i)
        end
    end
    return answer
end

function nonabundant()
    list = abundant_list()
    absum = Set([])

    for i = 1:length(list)
        for j = 1:length(list)
            val = list[i] + list[j]
            if !in(val, absum)
                push!(absum, val)
            end
        end
    end

    answer = []

    for i = 1:28123
        if !in(i, absum)
            push!(answer, i)
        end
    end

    return sum(answer)
end
