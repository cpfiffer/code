module FunPlots

using Gadfly

export plot

function plot(f :: Function; domain = (-10, 10) :: Tuple, interval = 0.01 :: Float64)
    xin = collect(domain[1] : 0.01 : domain[2])
    yin = map(f, xin)
    Gadfly.plot(x=xin, y=yin, Geom.point)
end

end #module
