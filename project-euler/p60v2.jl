module P60v2
using Primes
using Combinatorics

function canconcatall(x)::Bool
    perm = permutations(x, 2)

    for i = perm
        if canconcat(i)
            ###
        else
            return false
        end
    end
    return true
end

function canconcat(x)::Bool
    num1 = x[1]
    num2 = x[2]

    @time con1 = parse(string(num1, num2))::Int64
    con2 = parse(string(num2, num1))::Int64

    if isprime(con1) && isprime(con2)
        return true
    else
        return false
    end
end

function getpairs!(plist, sets)
    for i = plist
        for j = plist
            if i != j && canconcatall([i,j])
                update!(sets, [i,j])
            end
        end
    end
end

function update!(sets::Dict{Int64, Set{Int64}}, nums)
    num1 = nums[1]
    num2 = nums[2]

    key = num1
    val = num2

    if haskey(sets, key)
        if val in sets[key]
            # Do nothing
        else
            push!(sets[key], val)
        end
    else
        sets[key] = Set{Int64}()
        push!(sets[key], val)
    end
end

function answer(maxnum = 10000)
    plist = primes(maxnum)
    sets = Dict{Int64, Set{Int64}}()
    println("Time to generate pairs:")
    @time getpairs!(plist, sets)
    println("Time to find solution:")
    @time seedchain(sets)
    return sets
end

function seedchain(sets::Dict{Int64, Set{Int64}})
    best = 999999999999
    @parallel for num1 = keys(sets)
        set1 = sets[num1]
        for num2 = set1
            set2 = ∩(sets[num2], set1)
            for num3 = set2
                set3 = ∩(sets[num3], set2)
                for num4 = set3
                    set4 = ∩(sets[num4], set3)
                    for num5 = set4
                        sums = num1 + num2 + num3 + num4 + num5
                        println("$num1 $num2 $num3 $num4 $num5 => $sums")
                    end
                end
            end
        end
    end
end

end # module

@time x = P60v2.answer()

#P60v2.canconcatall([5701, 13,8389])
