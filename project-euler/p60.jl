module P60

using Primes
using Combinatorics

mutable struct Failset
    vals :: Set{Int64}
    Failset() = new(Set{Int64}())
end

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

function whichfail!(x, failures)::Bool
    success = true
    perm = permutations(x, 2)

    for i = perm
        if canconcat(i)
            ###
        else
            update!(failures, i)
            success = false
        end
    end
    return success
end

function canconcat(x)::Bool
    num1 = x[1]
    num2 = x[2]

    con1 = parse(string(num1, num2))::Int64
    con2 = parse(string(num2, num1))::Int64

    if isprime(con1) && isprime(con2)
        return true
    else
        return false
    end
end

function quickhigher(tobeat::Int64, arr)
    y = 0

    for i = arr
        y += i
        if y > tobeat
            return y
        end
    end

    return y
end

function primecombo(x::Int64, maxnum::Int64 = 1000)
    # Returns an iterator of combinations of primes.
    plist = deleteat!(primes(3, maxnum), 2)
    combo = combinations(plist, x)
    return combo
end

function update!(x::Dict{Int64, Failset}, z::Array{Int64, 1})
    num1 = z[1]
    num2 = z[2]

    key = 0
    val = 0

    if num1 < num2
        key = num1
        val = num2
    else
        key = num2
        val = num1
    end

    if haskey(x, key)
        if val in x[key].vals
            ###
        else
            push!(x[key].vals, val)
        end
    else
        x[key] = Failset()
        push!(x[key].vals, val)
    end
end

function answer(maxprimes = 1000, numprimes = 4)
    pcombo = primecombo(numprimes, maxprimes)

    best = ones(Array{Int64}(numprimes,1)) .* maxprimes
    sumbest = sum(best)

    failures = Dict{Int64, Failset}()

    reviewed = 0
    counter = 0

    println("\n=====Beginning run=====\n")
    println("\tHighest Prime: $maxprimes\n\tNumber of primes: $numprimes\n")

    for i = pcombo

        nextsum = quickhigher(sumbest, i)

        if isfailure(i, failures)
            # Skip
        elseif nextsum < sumbest
            # # Report
            if counter > 10000
                flength = length(failures)
                println("=====\nReviewed: $reviewed\n Next: $i
Best: $sumbest\n Failures: $flength\n")
                counter = 0
            end

            if whichfail!(i ,failures)
                #println(i)
                println("The new best is $i with a sum of $nextsum")
                best = i
                sumbest = nextsum
            end
        end

        reviewed = reviewed + 1
        counter = counter + 1
    end

    println("The best collection is $best with a sum of $sumbest.")
end

function isfailure(combo, fails)
    #println("Failures: $fails\n")
    for i = combo
        for j = combo

            key = 0
            val = 0

            if i < j
                key = i
                val = j
            elseif j < i
                key = j
                val = i
            end

            if key > 0
                if haskey(fails, key)
                    if val in fails[key].vals
                        return true
                    end
                end
            end
        end
    end

    return false
end

function arraycontains(collection, ls)
    bool1 = false
    bool2 = false

    num1 = ls[1]
    num2 = ls[2]

    for i = collection
        if !bool1 && i == num1
            bool1 = true
        elseif !bool2 && i == num2
            bool2 = true;
        elseif bool1 && bool2
            return true
        end
    end

    return bool1 && bool2
end

end # End module

@time P60.answer(10000, 3)
