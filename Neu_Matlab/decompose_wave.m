%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 18-Nov-2021 $ 
%% This code was take from https://www.gaussianwaves.com/2015/11/interpreting-fft-results-obtaining-magnitude-and-phase-information/
%% and changed to fit the projects requirements
function [f,mag,phase,sine_waves] = phase_decompose_wave(wave,t,Fs,Ts)
% DECOMPOSE_WAVE returns returns the fundamental sine waves composing a
% complex wave.
%   [f,mag,sine_waves] = DECOMPOSE_WAVE(wave,t,Fs,Ts,thresh) 
%   Eingabe 
%       wave          (1 x n) complex wave
%       Fs            sampling frequency
%       Ts            sampling period  
%       t             time array
%
%   Ausgabe  
%       sine_waves    (? x n) fundamental sine waves  
%       f             (1 x ?) sine wave frequencies
%       mag           (1 x ?) sine wave magnitude
%       phase         (1 x ?) sine wave phase
    
    n = length(wave); % FFT size
    X = 1/n*fftshift(fft(wave,n)); % N-point complex DFT
    df = Fs/n; % Frequency resolution
    sampleIndex = -n/2:n/2-1; %ordered index for FFT plot
    f=sampleIndex*df; %x-axis index converted to ordered frequencies
    X2 = X; %store the FFT results in another array
    %detect noise (very small numbers (eps)) and ignore them
    threshold = max(abs(X))/100; %tolerance threshold
    X2(abs(X)<threshold) = 0; %maskout values that are below the threshold   
    mag = abs(X2);
    f = f(mag ~= 0);
    f = abs(f(1:round(length(f)/2)));
    phase = atan2(imag(X2),real(X2));
    phase = phase(mag ~= 0);
    phase = abs(phase(1:round(length(phase)/2)) - pi/2);% - pi/2 is added to get the phase of a sine instead of cos
    mag = mag(mag ~= 0);
    mag = mag(1:round(length(mag)/2))*2;
    if(~isempty(mag))
        sine_waves = mag' .* sin(2*pi*f'*t + phase'); 
    else
        sine_waves = zeros(1,n);
    end
    
end
