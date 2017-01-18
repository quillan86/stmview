function kcoord_from_rcoord(rcoord)
n = length(rcoord);
k0=pi/abs(rcoord(1)-rcoord(2));
switch mod(n,2)
   case 0 
       k=linspace(0,k0,n/2+1);
       k=[ -1.*k(end-1:-1:1 ) k(2:end-1)];                  
   case 1          
       k=linspace(-k0,k0,nc);
end
end