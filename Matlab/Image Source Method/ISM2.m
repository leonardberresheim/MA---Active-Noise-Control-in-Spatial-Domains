function p = ISM2(S,R,L,omega,c,alpha,T,order,spacing)
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
                            radius = spacing*norm(Rp-Rr);
                            %p = p + gain*(exp(1i*omega*((radius/c)-T))/(4*pi*radius));
                            p = p + gain*exp((1i*omega/c)*spacing*norm(Rp-Rr))/(4*pi*spacing*norm(Rp-Rr))*exp(-1i*omega*T);
                        end
                    end
                end
            end
        end
    end
end