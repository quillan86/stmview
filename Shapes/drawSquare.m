function h = drawSquare(origin,size )
x=([0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]-0.5)*size+origin(1);
y=([0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]-0.5)*size+origin(2);
z=([0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0])*size+origin(3);
for i=1:6
    h=patch(x(:,i),y(:,i),z(:,i),'w');
set(h,'facecolor','none');
    set(h,'edgecolor','k');
end