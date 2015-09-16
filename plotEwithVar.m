%script to plot energy per site
function varianceM = plotEnergyPerSite(numSimulations, arraySize)

for i = 1:numSimulations
    N = arraySize;
    T(i) = 4*rand();
    B = 0;
    steps = 80;
    [~, eTA] = Ising2D(N, T(i), B, steps, false);
    energyPerSite(i) = eTA;
    %%feedback
    if mod(i,10) == 0
        fprintf('Simulation number: %d\n', i);
    end
end
plot(T, energyPerSite, 'b*');
ylabel('energy per site');
xlabel('temperature');

%variance--------------

expectationF = 1/numSimulations*sum(energyPerSite);
expectationF2 = 1/numSimulations*sum(energyPerSite.^2);
variance = sqrt(expectationF2 - expectationF^2);
varianceM = variance/sqrt(numSimulations);

