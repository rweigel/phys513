
%nc: number of charges
%r: error function
%v: right part of the numerator equation found in picture 1.2pt4
nc=1
r=1

while(r>=0.01)
    nc=nc+2
    v=0
    for(c=1:((nc-1)/2))

    v= v + (1/(sqrt( ( (2*c)/(nc-1) )^2 + 1 )^3));
    end

r = abs ((sqrt(2) - (1/nc)*( 2 + 4* v))/sqrt(2) )

    
end
delta = 2/(nc-1)
