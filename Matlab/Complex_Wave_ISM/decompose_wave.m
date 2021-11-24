%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 18-Nov-2021 $ 
function [f,mag,sine_waves] = decompose_wave(wave,t,Fs,Ts,thresh)
% DECOMPOSE_WAVE returns returns the fundamental sine waves composing a
% complex wave.
%   [f,mag,sine_waves] = DECOMPOSE_WAVE(wave,t,Fs,Ts,thresh) 
%   Eingabe 
%       wave          (1 x n) complex wave
%       Fs            sampling frequency
%       Ts            sampling period  
%       thresh        threshold to filter out weak frequencies
%       t             time array
%
%   Ausgabe  
%       sine_waves    (? x n) fundamental sine waves  
%       f             (1 x ?) the sine waves frequencies
%       mag           (1 x ?) sine wave magnitude
%
    n = length(wave);
    F = fft(wave);
    PS2 = abs(F/n);% Double sampling plot
    PS1 = PS2(1:n/2+1);% Single sampling plot
    PS1(2:end-1) = 2*PS1(2:end-1);
    f = Fs*(0:(n/2))/n;
    
    % Get the peaks from the frequency response
    if(length(PS1) > 3)
        [pks,idx] = findpeaks(PS1);
    else
        pks = 0;
        idx = 0;
    end
    
    
    % Get the frequence of those peaks and filter out the peaks under the
    % threshhold
    f = f(idx(pks > thresh));
    mag = pks(pks > thresh);
    if size(f,2) == 0
       mag = 0;
       f = 0;
    end
    % Generate sine_waves with conrrespondent frequencies
    sine_waves = mag'.*sin(2.*pi.*f'.*t);
end