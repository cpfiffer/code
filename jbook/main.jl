module Orderbook
using JuliaDB

println("\n=======LOADING ORDERBOOK=======\n")

struct Order
    size::String
    price::String
    side::Bool # 0 for buy, 1 for sell
end

mutable struct Book
    orders::Dict{UInt64, Order}

    Book() = new(Dict{UInt64, Order}())
end

function make_db()
    db = table([],[],[],[],[],[],
        names = [:hash, :price, :size, :side, :priceval, :sizeval],
        pkey = :hash)
end

function stash!(val::Order, db)#::Table)
    push!(rows(db),
    @NT(hash_order(val),
        val.size,
        val.price,
        val.side,
        parse(val.price),
        parse(val.size)))
end


function describe_order(x::Order)
    size = x.size
    price = x.price
    side = x.side
    hash_val = hash_order(x)
    if side side = "sell" else side = "buy " end
    println("This is a $side order for $size units at $price. Hash: $hash_val")
end

function hash_order(x::Order)
    hash(x.size) + hash(x.price) + hash(x.side)
end

function update!(o::Order, book::Book)
    key = hash_order(o)
    book.orders[key] = o
end

function get(key::UInt64, book::Book)
    return book.orders[key]
end

book = Book()
ø = Order("1500", "15.50", 1)
l = Order("2900", "15.62", 0)
update!(l, book)
println(book.orders[hash_order(l)])
describe_order(l)
# =========END MODULE========= #
end
