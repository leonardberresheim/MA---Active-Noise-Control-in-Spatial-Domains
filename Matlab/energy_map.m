x = 1;
y = 1;
z = 1;

m = 100; n = 100 ;
xi = linspace(min(x),max(x),m) ; 
yi = linspace(min(y),max(y),n) ; 
[X,Y] = meshgrid(xi,yi) ; 
Z = griddata(x,y,z,X,Y) ;
figure
pcolor(X,Y,Z) ; shading interp ; colorbar
figure
surf(X,Y,Z) ; shading interp ; colorbar