function p = ISM(S,R,L,mag,phase,omega,c,alpha,order)
%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 25-Nov-2021 $ 
% ISM computes the pressure deviation at a receiver
% produced by a pressure wave emitted at a source in a room using
% the image source method.
%   p = ISM(S,R,L,phase,omega,c,alpha,order,spacing) 
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
%   Ausgabe 
%       p      (1 x n)  pressure deviation at receiver
% 
    beta = sqrt(1-alpha);
    R = R + L.'./2;
    S = S + L.'./2;
    p = 0;
    if(order == 0)
        radius = norm(S - R);
        p = mag*exp(1i*(omega*radius/c+phase))/(4*pi*radius);
    else
        
        for q=0:1
            for j=0:1
                for k=0:1
                    Rp = [S(1)-R(1)+2*q*R(1); S(2)-R(2)+2*j*R(2); S(3)-R(3)+2*k*R(3)];
                    for n=0:order
                        for l=0:order
                            for m=0:order
                                Rr = 2.*[n*L(1);l*L(2);m*L(3)];
                                gain = beta(1)^abs(n-q)*beta(2)^abs(n)*beta(3)^abs(l-j)*beta(4)^abs(l)*beta(5)^abs(m-k)*beta(6)^(m);
                                radius = norm(Rp+Rr);
                                p = p + gain*(mag*exp(1i*(omega*radius/c+phase))/(4*pi*radius));
                            end
                        end
                    end
                end
            end
        end
    end
end