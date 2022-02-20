function E = soundenergy(P)
    E = 10*log10(abs(P).^2);
end