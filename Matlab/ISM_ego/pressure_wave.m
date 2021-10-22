

function p = pressure_wave(X_source, X_receiver, omega, t)
    c = 345; %m/s^2 - speed of sound
    R = abs(X_source - X_receiver);
    p = exp(1i*omega*(R/c-t))./(4*pi*R);
end