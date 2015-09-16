%%compare to analytical solution
%%M(T) = (1 - [sinh(1/(4*B*J))]^-4)^1/8, T < Tc
%%B = 1/(k_b*T) = 1/T (set k_b = 1)
function analyticalComparison(simulations, arraySize)

%%magnetization
T = 0:.01:2.3;
B = 1./T;
J = 1;
M = (1 - (sinh((2*J)./T)).^-4).^(1/8);
M = [M zeros(1,170)];
figure();
hold on;
plot(0:.01:4,M, 'mo');
plotMagnetizationPerSite(simulations, arraySize);

% %%energy
% %%use simpson's to do integral
% % E(T) = -2Jtanh(2BJ) + K/2pi*dK/dB*integral(sin^2(phi)/(del*(1+del)), phi,
% % 0, pi
% % dK/dB = -2J(cosh(4JB)-3)sech^3(2JB)
% 
% T = 0:.01:4;
% B = 1./T;
% J = 1;
% 
% syms phi;
% 
% phiVec = linspace(0,pi,102);
% for i = 1:length(T)
%     T_i = T(i);
%     B_i = 1/T_i;
%     K = 2 / (cosh(2*B_i*J)*coth(2*B_i*J));
%     dKdB = -2*J*(cosh(4*J*B_i)-3)*sech(2*J*B_i)^3;
%     numerator = sin(phiVec).^2;
%     del = sqrt(1-K^2*sin(phiVec).^2);
%     denom = del.*(1 + del);
%     integrand = numerator./denom;
%     I = simpson38v2(phiVec, integrand);
%     E(i) = 4*(-2*J*tanh(2*B_i*J) + K/(2*pi)*dKdB*I);
% end
% 
% figure();
% hold on;
% plot(T, E, 'mo');
% plotEnergyPerSite(simulations, arraySize);
legend({'Analytical Solution', 'Simulation results'});