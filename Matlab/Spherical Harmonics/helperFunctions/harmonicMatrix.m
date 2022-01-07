function Y = harmonicMatrix(L,the,phi)
    Y = zeros(L+1,2*L+1);
    for idl=1:L+1
        l = idl-1;
        Ym = zeros(1,2*L+1);
        for idm=1:(2*l+1)
            m = idm-idl;
            Ym(idm) = Ylm(l,m,the,phi);
        end
        Y(idl,:) = Ym;
    end
end