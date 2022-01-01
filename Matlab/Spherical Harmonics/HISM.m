function p = HISM(S,R,L,omega,c,alpha,order,spacing,CC,LL)
%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 25-Nov-2021 $ 
% ISM computes the pressure deviation at a receiver
% produced by a pressure wave emitted at a source in a room using
% the image source methodk in the spherical harmonics form.
%   p = HISM(S,R,L,T,phase,omega,c,alpha,order,spacing) 
%   Eingabe 
%       S          (1 x 3) source point (x,y,z)
%       R          (1 x 3) receiver point (x,y,z)
%       L          (1 x 3) room dimension (Lx,Ly,Lz)
%       phase      signal phase
%       omega      2*pi*f | f : frequency
%       c          propagation speed
%       alpha      (1 x 6) Absorption coefficient for every wall
%       order      image order - defines the level of reflection
%       spacing    spacing between each grid point
%       CC         Spherical harmonics coefficients
%   Ausgabe  
%       p      (1 x n)  pressure deviation at receiver
% 
    beta = sqrt(1-alpha);
    
    p = 0;
    for q=0:1
        for j=0:1
            for k=0:1
                Rp = [S(1)-R(1)+2*q*R(1); S(2)-R(2)+2*j*R(2); S(3)-R(3)+2*k*R(3)];
                for n=0:order
                    for l=0:order
                        for m=0:order
                            Rr = 2.*[n*L(1);l*L(2);m*L(3)];
                            gain = beta(1)^abs(n-q)*beta(2)^abs(n)*beta(3)^abs(l-j)*beta(4)^abs(l)*beta(5)^abs(m-k)*beta(6)^(m);
                            % Cartesian to spherical coordinates
                            radius = spacing*norm(Rp+Rr);
                            th = atan(R(2)/R(1));
                            phi = acos(R(3)/radius);
                            %LL = ceil((exp(1)*omega/c*radius)/2);
                            for ll=0:LL
                                for mm=-ll:ll
                                    cx = ll+1; % Indexing for the matrix has to start at 1 in matlab thats why +1
                                    cy = (mm + ll)+1;
                                    p = p + CC(cx,cy)*besselj(ll,omega/c*radius)*harmonicY(ll,mm,th,phi);
                                    %i = i + 1;
                                end
                            end
                            p = gain*p;
                        end
                    end
                end
            end
        end
    end
end