function [Clm, mic] = harmonicCoefficients(R,rho_k,N,waveFun,n,wave,visualize)
%% AUTHOR    : Leonard Berresheim 
% HARMONICCOEFFICIENTS conputes the harmonics coefficients using the
% Gaussian sampling scheme.
%   [Clm, mic] = HARMONICCOEFFICIENTS(R,rho_k,N,waveFun,n,wave,visualize)
%   Input 
%       R           Radius of region of interrest
%       rho_k       wave number
%       N           number of modes
%       waveFun     Pressure function / acoustic transfer function
%       n           axis limit for visualization
%       wave        primary noise field for visualization
%       visualize   (boolean) wheter to visualize result
%   Output 
%       Clm         Harmonic coefficients
%       mic         2(N+1)^2 microphone position in cartesian coordinates
% 
    p = 0:(2*N+1);
    phi_p = p*2*pi/(2*N+2);
    if(visualize == 1)
        figure;
        subplot(211);
        the_q = legendrePzeros(N,visualize);
        subplot(212);
        plotSamples(N,phi_p,the_q);
    else
        the_q = legendrePzeros(N,visualize);
    end
    
    % weights
    a_q = pi./(N+1).*(2.*(1-cos(the_q).^2))./((N+2)^2*legendreP(N+2,cos(the_q)).^2);
    % Microphone positions in spherical
    mic_sph = combvec(the_q,phi_p);
    % In cartesian
    mic = my_sph2cart(mic_sph(1,:),mic_sph(2,:),R);
    % 3D plot with wave and microphone positions
    if(visualize == 1)
       figure;
        plot3(mic(1,:),mic(2,:),mic(3,:),'ko','MarkerSize',10,'MarkerFaceColor','k');
        hold on;
        xImage = [-n -n; n n];   % The x data for the image corners
        yImage = [n -n; n -n];             % The y data for the image corners
        zImage = [0 0; 0 0];% The z data for the image corners
        surf(xImage,yImage,zImage,...    % Plot the surface
             'CData',imag(wave),...
             'FaceColor','texturemap');
        axis tight;
        title("Pressure wave and microphone position")
        zlim([-n n]) 
    end
    p_qp = waveFun(R,mic_sph(1,:),mic_sph(2,:));
    if(visualize == 1)
        figure;
        plot(imag(p_qp),'-o')
        title("Pressure at microphones");
        ylabel("Pressure in [Pa]");
        xlabel("Microphone i");
    end
    l = (0:N).';
    Jl = sphbessel(l,rho_k*R);

    Clm = zeros(N+1,2*N+1);
    for q=1:length(the_q)
        for p=1:length(phi_p)
            Yqp = harmonicMatrix(N,the_q(q),phi_p(p));
            cYqp = conj(Yqp);
            p_i = waveFun(R,the_q(q),phi_p(p));
            Clm = Clm + a_q(q)*p_i*cYqp;
        end
    end
    Clm = Clm./Jl;
    
end