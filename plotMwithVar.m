%%plots magnetization per site
function varianceM = plotMagnetizationPerSite(numSimulations, arraySize)

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
plot(T, magPerSite, 'b*');
ylabel('magnetization per site');
xlabel('temperature');

%variance--------------

expectationF = 1/numSimulations*sum(magPerSite);
expectationF2 = 1/numSimulations*sum(magPerSite.^2);
variance = sqrt(expectationF2 - expectationF^2);
varianceM = variance/sqrt(numSimulations);
