function [spins, energyPerElectron, magPerElectron] = fullMCStep(spins, energy, N, T)
%%function runs one step per spin (N^2 individual steps = one whole MC
%%step)
%%magnetization is prone to random switching (between spin up/spin down)
%%so it just takes the magnetization per site at the end
energyPerElectron = 0;
for k = 1:N^2
    %%start with a random point in the array
    i = round(N*rand() + 0.5);
    j = round(N*rand() + 0.5);
    
    %%apply periodic boundary conditions
    iPrev = mod(i - 2, N) + 1;
    iNext = mod(i, N) + 1;
    jPrev = mod(j - 2, N) + 1;
    jNext = mod(j, N) + 1;
    
    neighbors = spins(iPrev, j) + spins(iNext, j) + spins(i, jPrev) + spins(i, jNext);
    deltaS = 2 * spins(i,j) * neighbors;
    
    nrg = energy((deltaS) + 9, spins(i,j) + 2);
    energyPerElectron = energyPerElectron + nrg;
    w = exp(nrg / T);
    if (w > rand())
        spins(i,j) = -1*spins(i,j);
    end
end
energyPerElectron = energyPerElectron/(N^2);
magPerElectron = sum(sum(spins))/(N^2);
end