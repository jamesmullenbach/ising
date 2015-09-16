%%plots magnetization per site
function varianceM = plotMagnetizationPerSite(numSimulations, arraySize)

tic;
for i = 1:numSimulations
    N = arraySize;
    T(i) = 5*rand();
    B = 0;
    steps = 80;
    [~, ~, mag] = Ising2D(N, T(i), B, steps, false);
    magPerSite(i) = mag;
    %%feedback
    if mod(i,10) == 0
        fprintf('Simulation number: %d\n', i);
    end
end
toc;
figure();
plot(T, magPerSite, 'b*');
ylabel('Magnetization per site');
xlabel('Temperature');
string = sprintf('M(T) using %d simulations of a %d x %d array', numSimulations, arraySize, arraySize);
title(string);

%variance--------------

expectationF = 1/numSimulations*sum(magPerSite);
expectationF2 = 1/numSimulations*sum(magPerSite.^2);
variance = sqrt(expectationF2 - expectationF^2);
varianceM = variance/sqrt(numSimulations);
