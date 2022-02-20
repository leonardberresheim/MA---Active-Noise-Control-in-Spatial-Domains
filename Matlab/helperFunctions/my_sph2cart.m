function X = my_sph2cart(TH,PHI,RHO)
    x = RHO.*sin(TH).*cos(PHI);
    y = RHO.*sin(TH).*sin(PHI);
    z = RHO.*cos(TH);
    X = [x;y;z];
end