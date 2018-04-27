function combos(amax, bmax)
    yset = Set{BigInt}()
    for a = 2:amax
        a = BigInt(a)
        for b = 2:bmax
            b = BigInt(b)

            y :: BigInt = a ^ b

            atype = typeof(a)
            btype = typeof(b)
            ytype = typeof(y)

            # println("$atype $btype $ytype")

            if !(y in yset)
                push!(yset, y)
            else
                #println(y)
            end
        end
    end
    println(length(yset))
    return yset
end

z = combos(100, 100)
