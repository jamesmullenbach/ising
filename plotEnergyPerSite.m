%script to plot energy per site
function varianceE =  plotEnergyPerSite(numSimulations, arraySize)

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
figure();
plot(T, energyPerSite, 'b*');
ylabel('Energy per site');
xlabel('Temperature');
string = sprintf('E(T) using %d simulations of a %d x %d array', numSimulations, arraySize, arraySize);
title(string);

%variance--------------

expectationF = 1/numSimulations*sum(energyPerSite);
expectationF2 = 1/numSimulations*sum(energyPerSite.^2);
variance = sqrt(expectationF2 - expectationF^2);
varianceE = variance/sqrt(numSimulations);

