y = Dict{Int64, Any}()

y[1]  = [75]
y[2]  = [95 64]
y[3]  = [17 47 82]
y[4]  = [18 35 87 10]
y[5]  = [20 04 82 47 65]
y[6]  = [19 01 23 75 03 34]
y[7]  = [88 02 77 73 07 63 67]
y[8]  = [99 65 04 28 06 16 70 92]
y[9]  = [41 41 26 56 83 40 80 70 33]
y[10] = [41 48 72 33 47 32 37 16 94 29]
y[11] = [53 71 44 65 25 43 91 52 97 51 14]
y[12] = [70 11 33 28 77 73 17 78 39 68 17 57]
y[13] = [91 71 52 38 17 14 91 43 58 50 27 29 48]
y[14] = [63 66 04 68 89 53 67 30 73 16 69 87 40 31]
y[15] = [04 62 98 27 23 09 70 98 73 93 38 53 60 04 23]

function choice_mat()
    k = 14
    choices = [ [ bit == '1' ? 1 : 0 for bit in bin(n,k) ] for n in 0:2^k-1 ]
end

function find_max(pyramid::Dict{Int64, Any})
    path = pyramid[1][1]
    biggest = zero(Int64)
    choices = choice_mat()
    col = 1

    for choice = 1:length(choices)
        for row = 2:15
            col  += choices[choice][row-1]
            num   = pyramid[row][col]
            #println("row: $row col: $col num: $num")
            path = path + num
            #println(path)
        end

        #println(path)
        #println(biggest)

        if path > biggest
            biggest = path
            println("New biggest: $biggest")
        end

        path = pyramid[1][1]
        col = 1
    end
    return biggest
end

find_max(y)
